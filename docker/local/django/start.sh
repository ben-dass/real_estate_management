#!/bin/bash

# Fail on first error.
set -o errexit

# Fail on piped commands error.
set -o pipefail

# Treat unset variables as an error.
set -o nounset

python manage.py migrate --no-input
python manage.py collectstatic --no-input
exec python manage.py runserver 0.0.0.0:8000