<?php
// Création de la base de données SQLite
$db = new PDO('sqlite:./database.db');
$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

// Création de la table
$db->exec("
DROP TABLE IF EXISTS users; 
CREATE TABLE users (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT NOT NULL,
    password TEXT NOT NULL,
	firstName TEXT NOT NULL,
	lastName TEXT NOT NULL,
	role TEXT NOT NULL
);
");

echo "\nBase de données et table créées avec succès.";

// Insertion de quelques utilisateurs
$stmt = $db->prepare("INSERT INTO users (email, password, firstName, lastName, role) VALUES (?, ?, ?, ?, ?);");
$stmt->execute(['user@example.com', 'userpass', 'Jane', 'Doe', 'User']);
$stmt->execute(['user2@example.com', 'userpass', 'John', 'Doe', 'User']);
$stmt->execute(['admin@example.com', 'adminpass', 'Admin', 'User', 'Admin']);

echo "\nDonnées insérées avec succès.";

?>
