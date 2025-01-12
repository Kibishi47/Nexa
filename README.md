
# Nexa - AI Conversation App

Nexa est une application de messagerie intelligente qui permet aux utilisateurs d’interagir avec une IA avancée. Elle repose sur une API développée en Python, qui fait appel à l'API de ChatGPT pour fournir des réponses rapides et précises. Cette application est conçue pour offrir une expérience conversationnelle fluide et enrichissante.

## Fonctionnalités

- **Conversations en temps réel** avec une IA avancée.
- **Sauvegarde des conversations** pour une consultation ultérieure.
- **Gestion des utilisateurs** avec prise en charge des conversations multiples.
- Réponses générées par l'API **ChatGPT**, via une API personnalisée en Python.
- Organisation des messages par ordre chronologique avec prise en charge du dernier message.

## Technologies utilisées

### Backend
- **Python** : Développement de l'API principale.
- **FastAPI** : Framework rapide et léger pour l'API REST.
- **API ChatGPT** : Pour les réponses intelligentes de l'IA.

### Frontend
- **SwiftUI** : Interface utilisateur intuitive et moderne pour iOS.
- **Combine et async/await** : Pour une gestion fluide des appels réseau.

### Base de données
- **Supabase** : Gestion des conversations et des messages.

## Installation

### Frontend (App SwiftUI)

1. Clonez le dépôt de l'application iOS :
   ```bash
   git clone https://github.com/Kibishi47/Nexa.git
   cd Nexa
   ```

2. Ouvrez le projet dans Xcode :
   ```bash
   open Nexa.xcodeproj
   ```

3. Configurez les variables nécessaires pour connecter l'application à l'API Python dans un fichier `.plist` ou directement dans le code.

4. Build et exécutez l’application sur un simulateur ou un appareil physique.

## Utilisation

1. **Lancez l'API backend** en suivant les étapes ci-dessus.
2. **Démarrez l'application iOS** et connectez-vous avec votre identifiant (ou créez-en un).
3. **Commencez une conversation avec Nexa** :
   - Tapez votre message et laissez l'IA répondre.
   - Vos conversations sont enregistrées et organisées dans l'application.

## Lien du dépôt GitHub

- Backend API Python : [Lien du dépôt](https://github.com/Kibishi47/APIOpenAI)
- Frontend App iOS : [Lien du dépôt](https://github.com/Kibishi47/Nexa)


## Vidéo d'exemple

Voici le lien d'une vidéo de démonstration de l'application en marche : https://www.swisstransfer.com/d/070b384d-4d82-4f57-98ee-8d017f0cd0cd

---

Créé par Emmanuel Moulin (https://github.com/Kibishi47).
