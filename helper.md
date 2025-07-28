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

