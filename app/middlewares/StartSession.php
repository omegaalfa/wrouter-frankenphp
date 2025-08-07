<?php

declare(strict_types = 1);

namespace App\middlewares;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\MiddlewareInterface as Middleware;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;

use function session_start;
use function session_status;

final class StartSession implements Middleware
{

	/**
	 * @param  string  $samesite
	 *
	 * @return void
	 */
	public function start(string $samesite = 'Lax'): void
	{
		session_set_cookie_params([
			'lifetime' => 0,
			'path'     => '/',
			'domain'   => null,
			'secure'   => true,
			'httponly' => true,
			'samesite' => $samesite // 'Strict' Ou 'Lax'
		]);

		session_start();
	}

	/**
	 * @param  Request         $request
	 * @param  RequestHandler  $handler
	 *
	 * @return Response
	 */
	public function process(Request $request, RequestHandler $handler): Response
	{
		if(session_status() === PHP_SESSION_NONE) {
			$this->start();
		}

		$request = $request->withAttribute('session', $_SESSION);

		return $handler->handle($request);
	}
}
