<?php
// initbdd.php : Script pour initialiser la base de données
// Il supprime d'abord la table "users" dans le cas où elle existe
// Ensuite il créer la table 
// Puis enfin il insère des données.
try 
{
    $db = new PDO('sqlite:database.sqlite');

	echo "Suppression de la table 'users' (si elle existe)\n";
	$db->exec("DROP TABLE IF EXISTS t_users");

	echo "Création de la table 'users'\n";
    $db->exec("CREATE TABLE t_users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT NOT NULL,
        lastName TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        role TEXT NOT NULL
    );");

	echo "Alimentation de la DB\n";
    $db->exec("
		INSERT INTO t_users (firstName, lastName, email, password, role) VALUES
		('Jean', 'Dupont', 'jdupont@mail.com', '".hashPassword('supermotdepasse')."', 'User'),
		('Denis', 'Jean', 'djean@mail.com', '".hashPassword('secret')."', 'User'),
		('Admin', 'User', 'adm@mail.com', '".hashPassword('admSecurePassword')."', 'Admin')
	;");

    echo "Base de données initialisée avec succès.\n";
} catch (Exception $e) 
{
    echo "Erreur : " . $e->getMessage();
}

function hashPassword(string $clearPassword): string
{
	$salt = "secretSalt"; // random_bytes(16);
	return hash('sha256', $salt . $clearPassword);
}
