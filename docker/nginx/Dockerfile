FROM nginx:alpine

WORKDIR /data

# Create user www-data with UID and GID: 1000
RUN addgroup -g 1000 -S www-data \
    && adduser -u 1000 -D -S -G www-data www-data \
    && addgroup www-data nginx

# Add default config to nginx
COPY default /etc/nginx/conf.d/default.conf
