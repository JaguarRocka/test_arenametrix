# README

Comment lancer l'application en local ?

- Préparer la DB:

J'ai fait le choix de créer une instance de PostgreSql avec un fichier docker-compose ().

Pour le lancer : docker-compose -f docker-compose.yml up -d

On fait ensuite la migration de la DB avec rails db:migrate

- Lancer l'environnement :

On utilise la commande bin/dev
