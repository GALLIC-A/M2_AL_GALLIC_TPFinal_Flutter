<?php
header('Content-Type: application/json');

$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$uri = explode('/', $uri);

if (isset($uri[1])) {
    switch ($uri[1]) {
        case 'users':
            require 'users.php';
            break;
        case 'test':
            require 'test.php';
            break;
        default:
            echo json_encode(['error' => 'Route non trouvée']);
            http_response_code(404);
    }
} else {
    echo json_encode(['error' => 'Aucune route spécifiée']);
    http_response_code(400);
}
