.PHONY: help up up-bg down restart shell logs assets assets-build npm-install worker messenger-stats messenger-failed cache-clear composer-install install clean
# === AIDE ===
help:
	@echo "🚀 Commandes disponibles :"
	@echo ""
	@echo "📦 Docker :"
	@echo "  make up              - Démarrer Docker (interactif)"
	@echo "  make up-bg           - Démarrer Docker (arrière-plan)"
	@echo "  make down            - Arrêter Docker"
	@echo "  make restart         - Redémarrer Symfony"
	@echo "  make shell           - Accéder au container"
	@echo "  make logs            - Voir les logs"
	@echo ""
	@echo "🎨 Assets :"
	@echo "  make npm-install     - Installer les dépendances npm"
	@echo "  make assets          - Watch assets (INTERACTIF - recommandé)"
	@echo "  make assets-build    - Build assets production"
	@echo ""
	@echo "📧 Messenger :"
	@echo "  make worker          - Lancer worker Messenger (INTERACTIF)"
	@echo "  make messenger-stats - Stats de la queue"
	@echo ""
	@echo "🔧 Symfony :"
	@echo "  make cache-clear     - Vider le cache"
	@echo "  make composer-install - Installer dépendances PHP"
	@echo ""
	@echo "💡 Workflow recommandé :"
	@echo "  Terminal 1: make up"
	@echo "  Terminal 2: make assets"
	@echo "  Terminal 3: make worker (si besoin)"

# === DOCKER ===
up:
	@echo "🚀 Démarrage Docker (mode interactif)..."
	@echo "💡 Ctrl+C pour arrêter"
	docker-compose up

up-bg:
	@echo "🚀 Démarrage Docker (arrière-plan)..."
	docker-compose up -d
	@echo "✅ Docker démarré"
	@echo "💡 Utilise 'make logs' pour voir les logs"

down:
	@echo "⏹️  Arrêt Docker..."
	docker-compose down

restart:
	@echo "🔄 Redémarrage Symfony..."
	docker-compose restart symfony

shell:
	@echo "🐚 Accès au container..."
	docker exec -it symfony_app bash

logs:
	@echo "📋 Logs Docker (Ctrl+C pour quitter)..."
	docker-compose logs -f

# === NPM / ASSETS ===
npm-install:
	@echo "📦 Installation des dépendances npm..."
	docker exec -it symfony_app npm install
	@echo "✅ Dépendances installées"

assets:
	@echo "🎨 Watch assets (mode interactif)..."
	@echo "💡 Webpack va recompiler automatiquement à chaque modification"
	@echo "💡 Ctrl+C pour arrêter"
	@echo ""
	docker exec -it symfony_app npm run watch

assets-build:
	@echo "🎨 Build assets production..."
	docker exec -it symfony_app npm run build

# === MESSENGER ===
worker:
	@echo "🚀 Worker Messenger (mode interactif)..."
	@echo "💡 Tu verras les messages traités en temps réel"
	@echo "💡 Ctrl+C pour arrêter"
	@echo ""
	docker exec -it symfony_app php bin/console messenger:consume async -vv

messenger-stats:
	@echo "📊 Stats Messenger..."
	docker exec -it symfony_app php bin/console messenger:stats

messenger-failed:
	@echo "❌ Messages échoués..."
	docker exec -it symfony_app php bin/console messenger:failed:show

# === SYMFONY ===
cache-clear:
	@echo "🧹 Nettoyage du cache..."
	docker exec -it symfony_app php bin/console cache:clear
	@echo "✅ Cache vidé"

composer-install:
	@echo "📦 Installation des dépendances PHP..."
	docker exec -it symfony_app composer install
	@echo "✅ Dépendances installées"

# === RACCOURCIS UTILES ===
# Tout installer d'un coup
install:
	@echo "📦 Installation complète..."
	make composer-install
	make npm-install
	@echo "✅ Installation terminée"

# Tout nettoyer
clean:
	@echo "🧹 Nettoyage complet..."
	docker-compose down -v
	docker exec -it symfony_app rm -rf var/cache/*
	@echo "✅ Nettoyage terminé"
