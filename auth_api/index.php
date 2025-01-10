<?php
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(["status" => 405, "message" => "Method Not Allowed"]);
    http_response_code(405);
    exit;
}

$data = json_decode(file_get_contents('php://input'), true);
$email = $data['email'] ?? null;
$password = $data['password'] ?? null;

if (!$email || !$password) {
    echo json_encode(["status" => 400, "message" => "Email and password are required"]);
    http_response_code(400);
    exit;
}

try {
    $db = new PDO('sqlite:database.sqlite');
    $stmt = $db->prepare('SELECT * FROM t_users WHERE email = :email');
    $stmt->bindParam(':email', $email);
    $stmt->execute();

    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user && ($password === $user['password'])) {
        echo json_encode([
            "status" => 200,
            "message" => "Success",
            "id" => $user['id'],
            "firstName" => $user['firstName'],
            "lastName" => $user['lastName'],
            "email" => $user['email'],
            "role" => $user['role']
        ]);
    } else {
        echo json_encode(["status" => 400, "message" => "Error"]);
        http_response_code(400);
    }
} catch (Exception $e) {
    echo json_encode(["status" => 500, "message" => "Internal Server Error"]);
    http_response_code(500);
}
