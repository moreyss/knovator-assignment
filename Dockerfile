# 1st stage build
FROM node:20.8.0-alpine as build
WORKDIR /knovator
COPY . .
RUN yarn
RUN yarn build
# 2nd stage prod
FROM nginx:stable-alpine
COPY -- from=build /knovator/build /usr/share/nginx/html
COPY -- from=build /knovator/nginx/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

