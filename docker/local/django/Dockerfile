FROM docker.io/python:3.8.5-slim-buster as python

# Stage 1: Build our dependency wheels
FROM python AS python-build-stage

ARG BUILD_ENVIRONMENT=local

RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    libpq-dev 

COPY ./requirements .

RUN pip wheel --wheel-dir /usr/src/app/wheels \
    -r ${BUILD_ENVIRONMENT}.txt

# Stage 2: Python run stage
FROM python AS python-run-stage

ARG BUILD_ENVIRONMENT=local

ARG APP_HOME=/app

ENV PYTHONDONTWRITEBTTECODE=1

ENV PYTHONUNBUFFERED=1

ENV BUILD_ENVIRONMENT=${BUILD_ENVIRONMENT}

WORKDIR ${APP_HOME}

RUN apt-get update && apt-get install --no-install-recommends -y \
    sudo git bash-completion nano ssh

RUN addgroup --system django && \
    adduser --system --ingroup django django && \
    mkdir -p -m 777 ${APP_HOME}/staticfiles && \
    chown -R django:django ${APP_HOME}/staticfiles && \
    chmod -R 755 ${APP_HOME}/staticfiles

RUN apt-get update && apt-get install --no-install-recommends -y \
    libpq-dev gettext && \ 
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
    rm -rf /var/lib/apt/lists/*

COPY --from=python-build-stage /usr/src/app/wheels /wheels

RUN pip install --no-cache-dir --no-index --find-links=/wheels/ /wheels/* && \ 
    rm -rf /wheels/


COPY --chown=django:django ./docker/local/django/entrypoint.sh /entrypoint
RUN sed -i 's/\r$//g' /entrypoint
RUN chmod +x /entrypoint

COPY --chown=django:django ./docker/local/django/start.sh /start
RUN sed -i 's/\r$//g' /start
RUN chmod +x /start

COPY --chown=django:django . ${APP_HOME}

RUN chown -R django:django ${APP_HOME}

USER django

ENTRYPOINT [ "/entrypoint" ]