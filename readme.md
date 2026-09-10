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