<?php
$method = $_SERVER['REQUEST_METHOD'];

switch($method) 
{
	case 'GET':
		$db = new PDO('sqlite:./database.db');

		$stmt = $db->query('SELECT id, email, password, firstName, lastName, role FROM users');
		
		$users = $stmt->fetchAll(PDO::FETCH_ASSOC);
		
		echo json_encode($users);
		break;
	case 'POST':
		$input = json_decode(file_get_content('php://input'), true);
		
		if(!isset($input['name']) || !isset($input['email'])) 
		{
			echo json_encode(['error' => 'Paramètre manquants (name, email requis)']);
			http_response_code(400);
			exit;
		}
		
		$user = [
			'id' => rand(1, 1000),
			'name' => $input['name'],
			'email' => $input['email'],
		];
		
		echo json_encode(['message' => 'Utilisateur ajouté avec succès', 'user' => $user]);
		http_response_code(201);
		break;
	default:
		echo json_encode(['error' => 'Méthode non supportée']);
		http_response_code(405);
};