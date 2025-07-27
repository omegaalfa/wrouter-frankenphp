FROM dunglas/frankenphp:1.9.0-php8.4-bookworm

LABEL org.opencontainers.image.title="WRouter App Docker" \
      org.opencontainers.image.description="Docker image for PHP 8.4 + FrankenPHP + Redis + MySQL + WRouter" \
      org.opencontainers.image.authors="omegalfa"


# Instala dependências do sistema + extensões PHP
RUN install-php-extensions \
    pdo_mysql \
    mysqli \
    opcache \
    zip \
    gd \
    intl \
    bcmath \
    mbstring \
    xml \
    curl

# Instalar dependências do sistema (se necessário)
RUN apt-get update && apt-get install -y \
    curl \
    zip \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# php.ini customizado
COPY docker/php.ini /usr/local/etc/php/php.ini

# Configuração do FrankenPHP (Caddyfile)
COPY docker/frankenphp.conf /etc/frankenphp/Caddyfile

# Diretório de trabalho
WORKDIR /app
