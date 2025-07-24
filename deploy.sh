#!/bin/bash
set -e

echo "🚀 Iniciando build e deploy da aplicação..."

# Recarrega variáveis do .env
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

docker compose -f docker-compose.prod.yml down
docker compose -f docker-compose.prod.yml build --no-cache
docker compose -f docker-compose.prod.yml up -d

echo "✅ Deploy finalizado com sucesso!"
