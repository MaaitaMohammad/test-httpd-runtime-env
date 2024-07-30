FROM node:20-alpine AS build

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

COPY . /app

WORKDIR /app

RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --prod --frozen-lockfile
RUN pnpm build

RUN wget https://raw.githubusercontent.com/tests-always-included/mo/master/mo

FROM httpd:alpine

WORKDIR /app

RUN apk add bash

COPY --from=build /app/dist /usr/local/apache2/htdocs/
COPY --from=build /app/mo ./mo
RUN chmod +x mo
COPY ./docker/entrypoint.sh ./entrypoint.sh
COPY ./docker/.htaccess /usr/local/apache2/htdocs/
COPY ./docker/httpd.conf /usr/local/apache2/conf/httpd.conf

ENV API_BASE_URL="http://localhost:3010"

CMD [ "./entrypoint.sh" ]
