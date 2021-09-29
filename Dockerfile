FROM node:10-buster as build
RUN mkdir /tmp/brouter-web
WORKDIR /tmp/brouter-web
COPY . .
RUN yarn install
RUN yarn run build

FROM nginx:alpine
COPY --from=build /tmp/brouter-web/index.html /usr/share/nginx/html
COPY --from=build /tmp/brouter-web/dist /usr/share/nginx/html/dist
COPY --from=build /tmp/brouter-web/locales/keys.js /usr/share/nginx/html
COPY --from=build /tmp/brouter-web/layers/config/config.js /usr/share/nginx/html
VOLUME [ "/usr/share/nginx/html" ]