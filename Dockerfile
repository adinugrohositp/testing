FROM php:8.0

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy project files
COPY . .

#composer update
#composer install 

# Install project dependencies
RUN composer install --ignore-platform-reqs --no-interaction --no-plugins --no-scripts

# Expose port (if necessary)
EXPOSE 7000

# Start PHP server (if necessary)
# CMD ["php", "-S", "0.0.0.0:80", "-t", "public/"]

# Example CMD for running a PHP script
# CMD ["php", "script.php"]
