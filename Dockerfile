FROM node:lts-alpine as builder
WORKDIR /var/www
COPY package.json yarn.lock ./
RUN yarn --production
COPY . .
RUN npm run build

FROM nginx:stable-alpine

COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /var/www/build /var/www
