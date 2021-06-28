FROM elixir:1.12-alpine

ENV MIX_ENV dev

# Install NPM
RUN apk update && apk upgrade && \
  apk add inotify-tools git nodejs nodejs-npm build-base && npm install npm -g --no-progress && \
  rm -rf /var/cache/apk/*

# Add local node module binaries to PATH
ENV PATH=./node_modules/.bin:$PATH

WORKDIR /app

COPY . /app

RUN mix do local.hex --force, local.rebar --force

COPY config/ /app/config/
COPY mix.exs /app/
COPY mix.* /app/

COPY apps/ushortener/mix.exs /app/apps/ushortener/
COPY apps/ushortener_web/mix.exs /app/apps/ushortener_web/

RUN mix do deps.get, deps.compile

WORKDIR /app/apps/ushortener_web

RUN npm install --prefix ./assets
RUN mix phx.digest

WORKDIR /app

RUN mix compile

EXPOSE 4000

CMD ["mix", "phx.server"]
