FROM docker.io/node:23-alpine3.20 as base


FROM base as node-build-stage

RUN apk add --no-cache libc6-compat

COPY package.json package-lock.json* ./

RUN \ 
  if [ -f package-lock.json ]; then npm ci; \
  else echo "package-lock.json file not found." && exit 1; \ 
  fi


FROM base as node-run-stage

ARG APP_HOME=/app

WORKDIR ${APP_HOME}

COPY --from=node-build-stage /node_modules ./node_modules

COPY . ${APP_HOME}

RUN addgroup -g 1001 -S nodejs && \
    adduser -S nextjs -u 1001 -G nodejs

RUN chown -R nextjs:nodejs ${APP_HOME}

USER nextjs

CMD ["npm", "run", "dev"]
