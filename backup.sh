#!/bin/bash
set -e

DATE=$(date +"%Y%m%d-%H%M")
BACKUP_DIR="./backups/$DATE"

mkdir -p "$BACKUP_DIR"

echo "💾 Fazendo backup do banco MySQL..."
docker exec mysql_db sh -c 'exec mysqldump -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE"' > "$BACKUP_DIR/db.sql"

echo "📦 Salvando dump do Redis..."
docker exec redis_cache redis-cli save
docker cp redis_cache:/data/dump.rdb "$BACKUP_DIR/dump.rdb"

echo "✅ Backup salvo em: $BACKUP_DIR"
