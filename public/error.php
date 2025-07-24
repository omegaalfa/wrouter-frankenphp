<?php

// Detecta o código de erro (se disponível)
$code = $_SERVER['REDIRECT_STATUS'] ?? 500;

http_response_code($code);

if ($code == 404) {
    echo "Página não encontrada (404)";
} elseif ($code == 500) {
    echo "Erro interno do servidor (500)";
} else {
    echo "Erro ($code)";
}
