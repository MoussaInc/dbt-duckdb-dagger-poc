# dbt + DuckDB + Dagger — Test rapide

Mini-projet créé pour tester [Dagger](https://dagger.io) (CLI `v1.0.0-beta.11`) sur un pipeline dbt local, sans dépendance cloud (pas de Snowflake/BigQuery, pas de credentials à gérer).

## Objectif

Valider qu'un pipeline dbt (`seed` → `run` → `test`) peut s'exécuter de façon **reproductible et isolée** dans un conteneur, orchestré par Dagger, sans dépendre de l'environnement Python local.

## Stack

- **dbt-duckdb** (`1.10.1`) — adaptateur dbt pour DuckDB, base de données embarquée, aucun serveur externe requis
- **Dagger CLI** `v1.0.0-beta.11` — orchestration des étapes en conteneur
- Modèles : `stg_orders` (staging) → `mart_customer_revenue` (mart)
- Tests dbt : `unique`, `not_null`, `accepted_values` sur les colonnes clés

## Structure du projet

```
.
├── dbt_project.yml
├── profiles.yml          # profil DuckDB local, pas de secrets
├── requirements.txt       # dbt-duckdb==1.10.1
├── seeds/
│   └── raw_orders.csv
├── models/
│   ├── schema.yml          # tests dbt
│   ├── staging/
│   │   └── stg_orders.sql
│   └── marts/
│       └── mart_customer_revenue.sql
└── dagger-check.sh        # script Dagger (voir ci-dessous)
```

## Test en local (sans Dagger)

```shell
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
dbt build --profiles-dir .
```

## Test avec Dagger (objectif principal)

Exécution du pipeline complet dans un conteneur isolé, via **Dagger Shell** (`dagger -c`) :

```shell
dagger -c "
container |
from python:3.12-slim |
with-directory /project . --exclude=.venv --exclude=target --exclude=__pycache__ |
with-workdir /project |
with-exec -- pip install -r requirements.txt |
with-exec -- dbt seed --profiles-dir . |
with-exec -- dbt run --profiles-dir . |
with-exec -- dbt test --profiles-dir . |
stdout
"
```

Ce pipeline :
1. Crée un conteneur Python 3.12 propre
2. Monte le projet dedans (en excluant `.venv`, `target/`, `__pycache__` pour alléger l'upload)
3. Installe les dépendances (`requirements.txt`)
4. Exécute `dbt seed`, `dbt run`, `dbt test` séquentiellement
5. Retourne le `stdout` du pipeline

Résultat : pipeline entièrement fonctionnel, tous les tests passent, sans dépendre du `.venv` local ni de l'état de la machine hôte.