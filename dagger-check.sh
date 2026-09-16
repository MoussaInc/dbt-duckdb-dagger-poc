#!/bin/bash
set -e

# 1. Configuration du Cache Volume pour PIP
# 2. Installation des dépendances et de SQLFluff
# 3. Étape de Linting Automatique
# 4. Étape de Build et Tests dbt (si le linting passe)

dagger -c '
container |
  from python:3.11-slim |
  with-mounted-cache /root/.cache/pip pip-cache-dbt |
  with-directory /project . --exclude=.venv --exclude=__pycache__ --exclude=.git |
  with-workdir /project |
  with-exec -- pip install -r requirements.txt sqlfluff dbt-core |
  with-exec -- sqlfluff lint models/ |
  with-exec -- dbt build --profiles-dir . |
  stdout
'
