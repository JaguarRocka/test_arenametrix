# README

## Comment lancer l'application en local ?

### 1. Préparer la base de données

J'ai fait le choix de créer une instance de **PostgreSQL** avec un fichier `docker-compose.yml`.

On commence par créer les secrets 

```bash
touch .env
echo "POSTGRES_USER=arena" >> .env
echo "POSTGRES_PASSWORD=metrix" >> .env
echo "POSTGRES_DB=test_arenametrix_development" >> .env
```

Pour lancer la base de données, utilisez la commande suivante :

```bash
docker-compose -f docker-compose.yml up -d
```

Pour l'arrêter : 

```bash
docker-compose -f docker-compose.yml down
```

On fait ensuite la migration de la DB 

```bash
rails db:migrate
```

### 2. Lancer l'environnement :



On utilise les commandes

```bash
bundle install
bin/dev
```


## Logique de l'application

L'application comporte deux pages : 
- la "home" qui fait office de dashboard avec deux sections: statistiques générales, statistiques par spectacle;
- une page "import" dans laquelle ont peut upload ses fichiers CSV pour peupler la DB.
  

## Logique derrière l'import des CSV 
Pour traiter les CSV, nous avons fait le choix d'utiliser la gem SmarterCSV. Elle rend la manipulation plus simple que le module CSV de Rails, notamment en transformant le CSV en array de hashs sur lequel on itère facilement. Elle permet également, pour les gros fichiers d'utiliser des batchs pour limiter l'utilisation de la mémoire (ici j'ai mis un timide 100).


### 3. Lancer les tests: 


```bash
bin/rails test
```

### 4. Schéma de BDD 

<img width="813" alt="image" src="https://github.com/user-attachments/assets/bfa92a9e-6bc9-405c-bf49-81dc09dd37e6" />

