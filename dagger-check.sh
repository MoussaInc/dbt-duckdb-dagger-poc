#!/bin/bash
set -e
dagger -c "
container |
from python:3.12-slim |
with-directory /project . --exclude=.venv --exclude=target --exclude=__pycache__ --exclude=.git |
with-workdir /project |
with-exec -- pip install -r requirements.txt |
with-exec -- dbt build --profiles-dir . |
stdout
"
