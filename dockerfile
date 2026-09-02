# =========================
# Étape 1 : Build
# =========================
FROM rust:1.89-bookworm AS builder

WORKDIR /app

# Copier les fichiers de dépendances en premier
COPY Cargo.toml Cargo.lock ./

# Créer un projet temporaire pour mettre les dépendances en cache
RUN mkdir src && \
  echo "fn main() {}" > src/main.rs && \
  cargo build --release && \
  rm -rf src

# Copier le vrai code source
COPY src ./src

# Recompiler l'application
RUN touch src/main.rs && \
  cargo build --release


# =========================
# Étape 2 : Runtime
# =========================
FROM debian:bookworm-slim

WORKDIR /app

# Certificats nécessaires pour les connexions HTTPS
RUN apt-get update && \
  apt-get install -y --no-install-recommends ca-certificates && \
  rm -rf /var/lib/apt/lists/*

# Copier uniquement le binaire compilé
COPY --from=builder /app/target/release/auth-axum ./app

# Port utilisé par Axum
EXPOSE 3000

# Lancer l'application
CMD ["./app"]
