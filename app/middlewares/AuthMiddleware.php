<?php

namespace App\middlewares;

use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;
use Psr\Http\Message\ResponseInterface;

class AuthMiddleware implements MiddlewareInterface
{
    public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
    {
        echo "[AuthMiddleware] verificando token..." . PHP_EOL;

        $token = $request->getHeaderLine('Authorization');
        if ($token !== 'Bearer secreta') {
            echo "[AuthMiddleware] acesso negado." . PHP_EOL;
            $response = new \Laminas\Diactoros\Response();
            $response->getBody()->write('Acesso negado');
            return $response->withStatus(401);
        }

        echo "[AuthMiddleware] token válido." . PHP_EOL;
        return $handler->handle($request);
    }
}
