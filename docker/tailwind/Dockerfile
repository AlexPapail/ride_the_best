FROM node:20-alpine

RUN apk add --no-cache wget
RUN wget -O /usr/local/bin/tailwindcss https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-x64-musl \
    && chmod +x /usr/local/bin/tailwindcss

WORKDIR /app
