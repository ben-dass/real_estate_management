#!/bin/bash

# Fail on first error.
set -o errexit

# Fail on piped commands error.
set -o pipefail

# Treat unset variables as an error.
set -o nounset

python << END
import sys
import time
import psycopg2
suggest_unrecoverable_after = 30
start = time.time()
while True:
    try:
        psycopg2.connect(
            host="${POSTGRES_HOST}",
            port="${POSTGRES_PORT}",
            dbname="${POSTGRES_DB}",
            user="${POSTGRES_USER}",
            password="${POSTGRES_PASSWORD}",
        )
        break
    except psycopg2.OperationalError as error:
        sys.stderr.write("Waiting for PostgreSQL to become available...\n")
        if time.time() - start > suggest_unrecoverable_after:
            sys.stderr.write("PostgreSQL is taking too long to start. Error: '{}'\n".format(error))
            time.sleep(1) 
END

>&2 echo "PostgreSQL is available"

exec "$@"