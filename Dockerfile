# l'image docker de base sur laquelle on construit
FROM python:3.13.15-slim

# copier le binaire uv 
COPY --from=ghcr.io/astral-sh/uv:0.12.21 /uv /bin/

# le repertoire de travail dans le conteneur
WORKDIR /app

# ajouter le chemin de l'env virtuel du projet pour installer les packages
ENV PATH="/app/.venv/bin:$PATH"

# copier d'abord les fichiers de dépendances
COPY "pyproject.toml" "uv.lock" ".python-version" ./

# installer les dépendances a partir du lock
RUN uv sync --locked

# copie 
COPY ./01-docker-terraform/pipeline/pipeline.py pipeline.py

# definit la premiere chose à faire lorsque le conteneur demarre
ENTRYPOINT [ "python", "pipeline.py" ]