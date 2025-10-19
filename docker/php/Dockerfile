# 1. Utilise l'image officielle PHP 8.2 avec FPM (adapté pour Symfony)
FROM php:8.3-fpm

# 2. Installe les extensions PHP nécessaires (pdo, pdo_mysql, etc.)
RUN docker-php-ext-install pdo pdo_mysql

# 3. Installe Composer (gestionnaire de dépendances PHP)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 4. Définis le dossier de travail (là où sera monté ton code Symfony)
WORKDIR /var/www/html

# 5. Optionnel : installe Xdebug pour le debug (commenté par défaut)
# RUN pecl install xdebug && docker-php-ext-enable xdebug

# 6. Optionnel : installer d’autres dépendances (git, unzip, node, npm...) si besoin
# RUN apt-get update && apt-get install -y git unzip

# 7. Par défaut, le code Symfony sera monté via un volume (cf. docker-compose.yml)
