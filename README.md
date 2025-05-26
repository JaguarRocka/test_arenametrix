# README

## Comment lancer l'application en local ?

### 1. Préparer la base de données

J'ai fait le choix de créer une instance de **PostgreSQL** avec un fichier `docker-compose.yml`.

Pour lancer la base de données, utilisez la commande suivante :

```bash
docker-compose -f docker-compose.yml up -d
```

On fait ensuite la migration de la DB 

```bash
rails db:migrate
```

### 2. Lancer l'environnement :

On utilise la commande 

```bash
bin/dev
```
