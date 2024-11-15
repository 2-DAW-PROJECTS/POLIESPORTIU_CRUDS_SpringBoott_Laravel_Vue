# Usar una imagen base oficial de PHP con Apache
FROM php:8.1-apache

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    unzip \
    curl \
    git \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    mariadb-client \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql mbstring exif pcntl bcmath xml

# Habilitar módulos de Apache necesarios
RUN a2enmod rewrite

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# Copiar el archivo de configuración personalizado para php.ini (opcional)
# COPY php.ini /usr/local/etc/php/

# Establecer el directorio de trabajo como el proyecto Laravel
WORKDIR /var/www/html/1_helloworld

# Exponer el puerto 8000 para el servidor de Laravel
EXPOSE 8000

# Ejecutar el servidor de Laravel al iniciar el contenedor (asegurándonos de estar en el directorio correcto)
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
