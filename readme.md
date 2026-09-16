# dbt + DuckDB + Dagger — Test rapide

Mini-projet créé pour tester [Dagger](https://dagger.io) (CLI `v1.0.0-beta.11`) sur un pipeline dbt local, sans dépendance cloud (pas de Snowflake/BigQuery, pas de credentials à gérer).

## Objectif

Valider qu'un pipeline dbt (`seed` → `run` → `test`) peut s'exécuter de façon **reproductible et isolée** dans un conteneur, orchestré par Dagger, sans dépendre de l'environnement Python local.

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
    ├── intermediate/
│   │   └── int_customer_revenue.sql
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

## Test avec Dagger

Exécution du pipeline complet dans un conteneur isolé, via **Dagger Shell** (`dagger -c`) :

```shell
dagger -c "
container |
  from python:3.11-slim |
  with-mounted-cache /root/.cache/pip pip-cache-dbt |
  with-directory /project . --exclude=.venv --exclude=__pycache__ --exclude=.git |
  with-workdir /project |
  with-exec -- pip install -r requirements.txt |
  with-exec -- dbt seed --profiles-dir . |
  with-exec -- dbt run --profiles-dir . |
  with-exec -- dbt test --profiles-dir . |
  stdout
"
```

Ce pipeline :
1. Crée un conteneur Python 3.11 propre
2. Monter un volume pour la mise en cache (pour rapidite si re-execution)
3. Monte le projet dedans (en excluant `.venv`, `target/`, `__pycache__` pour alléger l'upload)
4. Installe les dépendances (`requirements.txt`)
5. Exécute `dbt seed`, `dbt run`, `dbt test` séquentiellement
6. Retourne le `stdout` du pipeline

Résultat : pipeline entièrement fonctionnel, tous les tests passent, sans dépendre du `.venv` local ni de l'état de la machine hôte.