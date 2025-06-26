FROM shinsenter/php:8.4-fpm-nginx

COPY --from=node:22-alpine /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node:22-alpine /usr/local/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY . /var/www/html

RUN composer install --no-dev --optimize-autoloader
#RUN npm install && npm run build

RUN chown -R www-data:www-data /var/www/html

RUN php artisan key:generate --force
RUN php artisan optimize:clear
RUN php artisan optimize

ENTRYPOINT [ "/nginx/sbin/nginx -c /var/www/html/docker/php-nginx-fpm/nginx-fpm.conf" ] 