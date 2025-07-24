#!/bin/bash

# Configurações comuns
DURACAO="10s"
THREADS=16
CONEXOES=100

# URLs
URL_FRANKEN="http://127.0.0.1:8000/frankephp"
URL_NGINX="http://127.0.0.1:8082/ngnix"

echo "🔧 Iniciando benchmark:"
echo " - FrankenPHP => $URL_FRANKEN"
echo " - NGINX      => $URL_NGINX"
echo " - Threads: $THREADS | Conexões: $CONEXOES | Duração: $DURACAO"
echo "========================================================="
echo ""
sleep 1

echo "🚀 FrankenPHP:"
wrk -t"$THREADS" -c"$CONEXOES" -d"$DURACAO" --latency "$URL_FRANKEN"
echo ""
echo "========================================================="
echo ""

echo "🚀 NGINX:"
wrk -t"$THREADS" -c"$CONEXOES" -d"$DURACAO" --latency "$URL_NGINX"
echo ""
echo "✅ Benchmark finalizado."
