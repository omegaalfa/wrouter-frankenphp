#!/bin/bash

SERVICE_NAME="wrouter.service"
SERVICE_SRC="./systemd/$SERVICE_NAME"
SERVICE_DST="/etc/systemd/system/$SERVICE_NAME"

echo "🔧 Instalando $SERVICE_NAME ..."

# Verifica se o arquivo do serviço existe
if [ ! -f "$SERVICE_SRC" ]; then
  echo "❌ Arquivo $SERVICE_SRC não encontrado!"
  echo "📁 Diretório atual: $(pwd)"
  echo "📁 Conteúdo de ./systemd:"
  ls -la ./systemd/ 2>/dev/null || echo "Diretório systemd não encontrado"
  exit 1
fi

#verifica .env
if [ -f .env ]; then
  echo "✅ Arquivo .env encontrado."
else
  echo "❌ Arquivo .env não encontrado."
fi

# Copia o service para o systemd
sudo cp "$SERVICE_SRC" "$SERVICE_DST"
sudo systemctl daemon-reload
sudo systemctl enable "$SERVICE_NAME"
sudo systemctl restart "$SERVICE_NAME"

# Verifica o status
if sudo systemctl is-active --quiet "$SERVICE_NAME"; then
  echo "✅ Serviço $SERVICE_NAME instalado e iniciado com sucesso."
else
  echo "❌ Falha ao iniciar o serviço $SERVICE_NAME"
  sudo systemctl status "$SERVICE_NAME"
  sudo journalctl -u "$SERVICE_NAME" --no-pager -n 20
fi
