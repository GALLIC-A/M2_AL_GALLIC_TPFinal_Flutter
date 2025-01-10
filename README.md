identifiants :
utilisateur = Jean, Dupont, jdupont@mail.com, supermotdepasse
utilisateur2 = Denis, Jean, djean@mail.com, secret
administrateur = Admin, User, adm@mail.com, admSecurePassword

EXecution de l'API: 
L'API minimaliste écrite en PHP (8.2) se situe dans le répertoire "auth_api", il suffit de lancer un serveur de développement PHP depuis ce répertoire (avec la commande `php -S localhost:3030`)

Les mots de passe sont stockés hachés en base, ils doivent donc être hachés lorsqu'on les tape côté front pour ne pas qu'ils transitent en clair sur le réseau.
