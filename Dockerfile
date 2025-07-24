# Usa a imagem base do FrankenPHP
FROM dunglas/frankenphp

# Instala extensões e dependências PHP necessárias
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    zlib1g-dev \
    libicu-dev \
    && docker-php-ext-install \
    pdo_mysql \
    zip \
    intl \
    opcache \
    pcntl \
    bcmath

# habilita instalação do Redis
RUN curl -sSL https://github.com/phpredis/phpredis/archive/master.tar.gz | tar xz \
    && cd phpredis-*/ \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && docker-php-ext-enable redis \
    && echo "extension=redis.so" >> /usr/local/etc/php/conf.d/docker-php-redis.ini \

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Copia php.ini customizado para dentro da imagem
COPY docker/php.ini /usr/local/etc/php/php.ini

# Copia config do Caddy/FrankenPHP (ex-Caddyfile)
COPY docker/frankenphp.conf /etc/frankenphp/Caddyfile

# Define diretório da aplicação
WORKDIR /app
