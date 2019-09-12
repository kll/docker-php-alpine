FROM php:7.3-fpm-alpine3.10

RUN apk add --no-cache su-exec

COPY docker-nonroot-entrypoint.sh /usr/local/bin/docker-nonroot-entrypoint

ENTRYPOINT ["docker-nonroot-entrypoint"]
CMD ["docker-php-entrypoint", "php", "-a"]
