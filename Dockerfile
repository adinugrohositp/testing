# Base image for PHP 8 with NGINX
FROM php:8

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    nginx

# Install PHP extensions (if needed)
# RUN docker-php-ext-install <extension_name>

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy project files
COPY . .

# Install project dependencies
RUN composer install --no-interaction --no-plugins --no-scripts

# Copy NGINX configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# (Optional) Copy additional NGINX configuration files
# COPY nginx_additional.conf /etc/nginx/conf.d/nginx_additional.conf

# (Optional) Expose any necessary ports
EXPOSE 7000

# (Optional) Set the entry point or command to run
CMD service nginx start && php-fpm
