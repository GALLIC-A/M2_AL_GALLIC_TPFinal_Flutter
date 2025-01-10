LE README EST EN COURS D'ECRITURE, POUR L'INSTANT CE N'EST QU'UN BROUILLON.

identifiants :
utilisateur = Jean, Dupont, jdupont@mail.com, supermotdepasse
utilisateur2 = Denis, Jean, djean@mail.com, secret
administrateur = Admin, User, adm@mail.com, admSecurePassword

EXecution de l'API: 
L'API minimaliste écrite en PHP (8.2) se situe dans le répertoire "auth_api"
Pour la faire fonctionner, il y a deux méthodes :
n°1 - lancer un serveur de développement PHP depuis ce répertoire (avec la commande `php -S localhost:80` ATTENTION cependant à bien veiller qu'il n'y a rien d'autre qui tourne sur le port 80 sur son poste)
n°2 - si on a un serveur web et PHP d'installés sur son poste, on peut copier le contenu du répertoire "auth_api" dans le répertoire desservit par le serveur web.
Pour tester sur un smartphone physique, il faudra récupérer l'adresse IP privée (192.168...) du PC sur lequel le serveur web (API) tourne, et indiquer l'adresse IP du poste
dans le fichier config situé dans /lib.

Les mots de passe sont stockés hachés en base, ils doivent donc être hachés lorsqu'on les tape côté front pour ne pas qu'ils transitent en clair sur le réseau.

Lors de l'initialisation de la bdd, le sel "salt" pour hacher le mot de passe utilisé est "secretSalt"
Commande curl pour tester l'api : `curl -X POST http://localhost:80 -H "Content-Type: application/json" -d "{\"email\": \"jdupont@mail.com\", \"password\": \"16cc49eb96d861344a8467b022e219bbd4eb7b5b87e42f40d4a515f02480aeb4\"}"`



# Projet d'Authentification avec API PHP et Application Flutter

Ce projet comprend une API minimaliste écrite en PHP qui permet de gérer l'authentification d'utilisateurs, et une application mobile développée avec Flutter pour interagir avec l'API. L'API utilise un hachage SHA-256 pour sécuriser les mots de passe et fournit un mécanisme d'authentification basé sur des requêtes HTTP.

## Fonctionnalités Implémentées

### 1. Authentification de l'Utilisateur (Login)
- **Hachage du mot de passe** : Les mots de passe sont salés et hachés avec SHA-256 avant d'être envoyés à l'API pour validation.
- **Communication avec l'API** : L'application Flutter envoie les informations de l'utilisateur (email et mot de passe haché) via une requête `POST` au serveur API.
- **Gestion des erreurs** : L'application gère les erreurs de l'API et affiche des messages d'erreur en cas de problème (par exemple, mot de passe incorrect ou email non trouvé).
- **Affichage des informations de l'utilisateur** : Si la connexion est réussie, l'application affiche les informations de l'utilisateur (prénom, nom, rôle, email).

### 2. Gestion des erreurs de l'API
- **Gestion des erreurs HTTP** : Des messages d'erreur clairs sont renvoyés dans les cas où la requête échoue (par exemple, erreur 500, 400).
- **Gestion des erreurs de réseau** : En cas de problème de connexion, un message d'erreur personnalisé est affiché à l'utilisateur.

### 3. Ajout de Timeout et Retrying
- **Timeout** : L'application Flutter met en place un timeout pour éviter que les requêtes prennent trop de temps sans réponse.
- **Retry** : Un mécanisme de réessai est implémenté pour essayer à nouveau la requête en cas d'échec.

### 4. Centralisation de l'URL de l'API
- **Configuration de l'API** : L'URL de l'API est centralisée dans un fichier de configuration pour faciliter les modifications (ex. pour changer l'environnement de développement à la production).

### 5. Configuration CORS pour l'API PHP
- **CORS** : L'API PHP est configurée pour permettre les requêtes venant de différentes origines (CORS), ce qui permet d'accéder à l'API depuis une application mobile Flutter.

### 6. Sécurité
- **Salage et Hachage des mots de passe** : Les mots de passe sont salés avec un sel (`secretSalt`) avant d'être hachés avec SHA-256 pour éviter des attaques par Rainbow Tables.

### 7. Exécution de l'API en Local
- **Serveur de développement PHP** : L'API peut être lancée en local via le serveur de développement intégré PHP.
- **Adresse IP locale pour les tests sur smartphone** : Lorsque l'application Flutter est installée sur un smartphone physique, l'adresse IP du serveur local doit être utilisée pour communiquer avec l'API.

---

## Installation et Exécution de l'API

### Prérequis
- PHP (version 8.2 ou supérieure)
- Serveur Web (optionnel, pour une installation en production)
- SQLite (base de données)

### 1. Exécution de l'API avec le serveur de développement PHP
Depuis le répertoire contenant l'API, exécute la commande suivante pour démarrer un serveur PHP local :
```bash
php -S localhost:80
