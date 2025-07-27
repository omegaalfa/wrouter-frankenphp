<?php


use Omegaalfa\Wrouter\Router\Wrouter;
use Laminas\Diactoros\Response;
use Laminas\Diactoros\ServerRequestFactory;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface;

$request = ServerRequestFactory::fromGlobals();
$response = new Response();

$router = new Wrouter($response, $request);


$router->get('/health', function (Request $request, ResponseInterface $response) {
    $response->getBody()->write('OK');
    return $response->withStatus(200);
});

$router->get('/', function (Request $request, ResponseInterface $response) {

    $response->getBody()->write('Página inicial');
    return $response;
});

$router->get('/frankephp', function (Request $request, ResponseInterface $response) {
    $response->getBody()->write('Pagina frankephp');
    return $response;
});


// Dispatcher
$path = $request->getUri()->getPath();
$response = $router->dispatcher($path);

// Emite a resposta HTTP
$router->emitResponse($response);
