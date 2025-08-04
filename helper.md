# Como usar no seu servidor:

```bash
git pull origin main
chmod +x deploy.sh
./deploy.sh
```

# Reinicie o daemon:

```bash
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
```

# Recarregue o systemd e inicie de novo:
```bash
sudo systemctl daemon-reload
sudo systemctl restart wrouter.service
```

# Reinstale o serviço com o novo watchdog
```bash
sudo systemctl restart wrouter.service
sudo systemctl status wrouter.service
```

# Você pode limpar o log com:

```bash
sudo journalctl --vacuum-time=1d

```


# E acompanhar o log do seu serviço com:

```bash
sudo journalctl -u wrouter.service -f
```

# Crie o diretório de plugins (caso não exista):
```bash
mkdir -p ~/.docker/cli-plugins

```

# Baixe o binário do Compose v2:
```bash
curl -SL https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
```

# Dê permissão de execução:
```bash
chmod +x ~/.docker/cli-plugins/docker-compose
```

### Build inicial (uma vez só)
docker compose -f docker-compose.prod.yml up -d --build

### Edite arquivos normalmente - mudanças aparecem na hora!

### Só rebuilda se mudar composer.json ou Dockerfile
docker compose -f docker-compose.prod.yml build --no-cache app

### Para adicionar nova dependência
docker compose -f docker-compose.prod.yml exec app composer require nova/dependencia
