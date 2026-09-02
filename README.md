# Axum JWT Authentication API

API d'authentification construite avec **Rust et Axum**, avec une implémentation de l'authentification basée sur les **JSON Web Tokens (JWT)**.

## 🚀 Fonctionnalités

- Authentification avec JWT
- Extraction du token `Bearer` depuis le header `Authorization`
- Validation et décodage des JWT
- Gestion des `Claims`
- Gestion centralisée des erreurs d'authentification
- Configuration du secret JWT via les variables d'environnement
- Utilisation d'`EncodingKey` et `DecodingKey`
- Support de Docker
- Architecture préparée pour l'ajout de l'autorisation et des rôles

## 🛠️ Technologies

- **Rust**
- **Axum**
- **jsonwebtoken**
- **Serde**
- **Axum Extra**
- **Tokio**
- **Docker**

## 🔐 Fonctionnement

Lorsqu'un utilisateur accède à une route protégée, l'API récupère le token :

```text
Authorization: Bearer <JWT>
```

Le token est ensuite :

1. extrait du header HTTP ;
2. vérifié avec la clé secrète ;
3. décodé ;
4. transformé en `Claims` ;
5. transmis au handler si le token est valide.

```text
Client
  │
  │ Bearer JWT
  ▼
Axum Extractor
  │
  ▼
JWT Validation
  │
  ▼
Claims
  │
  ▼
Protected Route
```

## ⚙️ Configuration

Le secret JWT est fourni par une variable d'environnement :

```env
JWT_SECRET=your-secret
```

Le secret n'est pas intégré directement dans le code source.

## 🐳 Docker

L'application peut être compilée et exécutée dans un conteneur Docker grâce à un **build multi-stage**, permettant de séparer l'environnement de compilation Rust de l'image finale d'exécution.

## 📌 Objectif

Ce projet sert de base réutilisable pour mes futurs projets **Rust/Axum** nécessitant une authentification sécurisée. Il pourra évoluer avec l'ajout des **rôles, permissions, refresh tokens et PostgreSQL**.
