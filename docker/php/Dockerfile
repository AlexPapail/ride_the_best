# 1. Utilise l'image officielle PHP 8.3 avec FPM (adapté pour Symfony)
FROM php:8.3-fpm

# 2. Installe les dépendances système nécessaires
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 3.  Installe les extensions PHP nécessaires (pdo, pdo_mysql, zip, gd)
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql zip gd

# 4. Installe Node.js 20. x et npm
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# 5. Installe Composer (gestionnaire de dépendances PHP)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 6.  Définis le dossier de travail (là où sera monté ton code Symfony)
WORKDIR /var/www/html

# 7. Optionnel : installe Xdebug pour le debug (commenté par défaut)
# RUN pecl install xdebug && docker-php-ext-enable xdebug

# 8. Par défaut, le code Symfony sera monté via un volume (cf.  docker-compose.yml)
