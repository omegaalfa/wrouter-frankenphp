<?php

namespace App\middlewares;

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;

class ExampleMiddleware implements MiddlewareInterface
{

	public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
	{

        // Adiciona um atributo no request
        $request = $request->withAttribute('name', 'João');
        echo "[ExampleMiddleware] passando...\n";
        return $handler->handle($request);
	}
}