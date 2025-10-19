# Démarrer la stack Docker avec le bon fichier d'env
up:
	docker-compose --env-file .env.docker up --build

# Stopper tous les conteneurs
down:
	docker-compose down

# Entrer dans le conteneur symfony_app pour lancer des commandes Symfony
bash:
	docker exec -it symfony_app bash

# Exécuter une commande Symfony sans ouvrir bash
console:
	docker exec -it symfony_app php bin/console

# Voir les logs de Symfony
logs:
	docker-compose logs -f symfony
