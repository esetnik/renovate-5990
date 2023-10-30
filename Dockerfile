FROM node:18.18.2-alpine@sha256:e3af3befbf609f62642b2ace78b6e99ef45f5f29018b7c628dc4a5315db42649

ARG REACT_APP_ENV=local

RUN apk add --no-cache \
  curl

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN yarn global add serve

COPY package.json yarn.lock .npmrc ./
COPY patches ./patches
RUN yarn install --frozen-lockfile

COPY . .

RUN REACT_APP_ENV=$REACT_APP_ENV yarn build

CMD ["serve", "-s", "build"]
