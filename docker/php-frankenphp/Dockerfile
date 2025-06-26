FROM dunglas/frankenphp:php8.4-alpine

COPY --from=node:22-alpine /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node:22-alpine /usr/local/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN install-php-extensions \
    pcntl

WORKDIR /app

COPY . /app

RUN chown -R www-data:www-data /app

RUN composer install --no-dev --optimize-autoloader
RUN npm install && npm run build

RUN php artisan key:generate --force
RUN php artisan optimize:clear
RUN php artisan optimize

ENTRYPOINT ["sh", "/app/docker/php-frankenphp/entrypoint.sh"]