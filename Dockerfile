FROM dunglas/frankenphp:1.9.0-php8.4-bookworm

LABEL org.opencontainers.image.title="WRouter App Docker" \
      org.opencontainers.image.description="Docker image for PHP 8.4 + FrankenPHP + Redis + MySQL + WRouter" \
      org.opencontainers.image.authors="omegalfa"

# Instala extensões PHP
RUN install-php-extensions \
    pdo_mysql \
    mysqli \
    redis \
    opcache \
    zip \
    gd \
    intl \
    bcmath \
    mbstring \
    xml \
    curl

# Dependências do sistema
RUN apt-get update && apt-get install -y \
    curl \
    zip \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Configurações PHP e Caddy
COPY docker/php.ini /usr/local/etc/php/php.ini
COPY docker/frankenphp.conf /etc/frankenphp/Caddyfile

# Define diretório da app
WORKDIR /app

# Copia o projeto para dentro da imagem
COPY . /app

# Instala dependências PHP para produção
RUN composer install --no-dev --optimize-autoloader --no-interaction

# (Opcional) Limpa .git e ajusta permissões
RUN rm -rf .git \
    && chown -R www-data:www-data /app
