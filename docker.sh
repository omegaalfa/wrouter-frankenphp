#!/bin/bash

SERVICE_NAME="app"

function run_composer() {
  echo "📦 Instalando dependências com Composer..."
  if [ ! -d "./vendor" ]; then
    echo "⚠️  Tentando acessar o contêiner para executar o Composer..."
    docker compose exec $SERVICE_NAME composer install
  else
    echo "✅ Composer já está instalado."
  fi
}

function is_running() {
  docker compose ps --status=running | grep -q "$SERVICE_NAME"
}

case "$1" in
  up)
    echo "🚀 Iniciando o container Docker..."
    docker compose up -d --build
    echo "⏳ Aguardando container subir..."
    sleep 3
    docker compose ps
    run_composer
    ;;
  down)
    echo "🛑 Parando e removendo o container..."
    docker compose down
    ;;
  restart)
    echo "🔁 Reiniciando o container..."
    docker compose down
    docker compose up -d --build
    echo "⏳ Aguardando container subir..."
    sleep 3
    docker compose ps
    run_composer
    ;;
  logs)
    echo "📄 Logs do container:"
    docker compose logs -f
    ;;
  bash)
    if is_running; then
      echo "🔧 Acessando shell do container:"
      docker compose exec $SERVICE_NAME sh
    else
      echo "⚠️  O container não está rodando. Use ./docker.sh up primeiro."
    fi
    ;;
  composer)
    if is_running; then
      run_composer
    else
      echo "⚠️  O container não está rodando. Use ./docker.sh up primeiro."
    fi
    ;;
  *)
    echo "❓ Uso: ./docker.sh {up|down|restart|logs|bash|composer}"
    ;;
esac
