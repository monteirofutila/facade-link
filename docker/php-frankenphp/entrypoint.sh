#!/bin/sh
php artisan octane:install --server=frankenphp
php artisan octane:start --server=frankenphp --port=8000 --host=0.0.0.0