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

# Define diretório da app
WORKDIR /app

# CACHE INTELIGENTE: Copia apenas composer.json primeiro
COPY composer.json composer.lock* ./

# Instala dependências PHP para produção (será cacheado se composer.json não mudar)
RUN composer install --no-dev --optimize-autoloader --no-interaction --no-scripts

# Executa scripts pós-instalação se necessário
RUN composer run-script --no-dev post-install-cmd || true

# Cria diretórios necessários com permissões adequadas
RUN mkdir -p /app/storage/logs /app/storage/cache /app/storage/sessions \
    && chown -R www-data:www-data /app/storage \
    && chmod -R 775 /app/storage

# Configurações PHP
COPY docker/php.ini /usr/local/etc/php/php.ini

# Configuração do FrankenPHP/Caddy
COPY docker/frankenphp.conf /etc/frankenphp/Caddyfile

# Ajusta permissões do diretório base
RUN chown -R www-data:www-data /app \
    && chmod -R 755 /app

# Expõe portas
EXPOSE 80 443

# Comando padrão
CMD ["frankenphp", "run", "--config", "/etc/frankenphp/Caddyfile"]