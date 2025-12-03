#!/usr/bin/env bash
set -euo pipefail

echo "Checking FastAPI health..."
resp=$(curl -sS http://app:8000/health || true)
echo "  Response: $resp"
echo "$resp" | grep -q '"status": *"ok"' || { echo "❌ FastAPI health check failed"; exit 1; }

echo "Checking Postgres sanity queries..."
PGPASSWORD=$POSTGRES_PASSWORD psql -h postgres -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "SELECT * FROM orders LIMIT 5;"
PGPASSWORD=$POSTGRES_PASSWORD psql -h postgres -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "SELECT now();"

echo "Running ETL inside checks container..."
python /app/etl.py
echo "ETL done."
