#!/bin/bash
set -e

dagger -c '
container |
  from python:3.11-slim |
  with-mounted-cache /root/.cache/pip pip-cache-dbt |
  with-directory /project . --exclude=.venv --exclude=__pycache__ --exclude=.git |
  with-workdir /project |
  with-exec -- pip install -r requirements.txt |
  with-exec -- dbt build --profiles-dir . |
  stdout
'
