#!/bin/bash
set -e

echo "♻️ Fazendo rollback para a última imagem conhecida..."

docker compose -f docker-compose.prod.yml down
docker compose -f docker-compose.prod.yml up -d

echo "✅ Rollback concluído com a última versão construída."
