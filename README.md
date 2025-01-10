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

