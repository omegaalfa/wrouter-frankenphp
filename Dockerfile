FROM dunglas/frankenphp:1.9.0-php8.4-bookworm

LABEL org.opencontainers.image.title="WRouter App Docker" \
      org.opencontainers.image.description="Docker image for PHP 8.4 + FrankenPHP + Redis + MySQL + WRouter" \
      org.opencontainers.image.authors="omegalfa"

# Baixa o instalador de extensões PHP diretamente do GitHub
RUN curl -sSL https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions \
    -o /usr/local/bin/install-php-extensions && \
    chmod +x /usr/local/bin/install-php-extensions

# Instala dependências do sistema + extensões PHP
RUN apt-get update && apt-get install -y --no-install-recommends \
    git unzip libzip-dev zlib1g-dev libicu-dev libgmp-dev libtidy-dev libssh2-1-dev \
    libjpeg-dev libpng-dev libfreetype6-dev libwebp-dev libxpm-dev && \
    install-php-extensions \
    intl \
    pdo_mysql \
    zip \
    opcache \
    pcntl \
    bcmath \
    redis \
    gmp \
    tidy \
    exif \
    gd \
    ssh2 && \
    rm -rf /var/lib/apt/lists/*

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# php.ini customizado
COPY docker/php.ini /usr/local/etc/php/php.ini

# Configuração do FrankenPHP (Caddyfile)
COPY docker/frankenphp.conf /etc/frankenphp/Caddyfile

# Diretório de trabalho
WORKDIR /app
