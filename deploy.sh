#!/bin/bash

SERVICE_NAME="wrouter.service"
SERVICE_SRC="systemd/$SERVICE_NAME"
SERVICE_DST="/etc/systemd/system/$SERVICE_NAME"

echo "🔧 Instalando $SERVICE_NAME ..."

# Verifica se o arquivo existe
if [ ! -f "$SERVICE_SRC" ]; then
  echo "❌ Arquivo $SERVICE_SRC não encontrado!"
  exit 1
fi

# Copia o serviço para o systemd
sudo cp "$SERVICE_SRC" "$SERVICE_DST"
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable "$SERVICE_NAME"
sudo systemctl restart "$SERVICE_NAME"

echo "✅ Serviço $SERVICE_NAME instalado e iniciado com sucesso."
