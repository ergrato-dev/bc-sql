#!/usr/bin/env bash
# resume.sh — Restaura el estado del workspace al regresar
# Uso: ./scripts/resume.sh
# ─────────────────────────────────────────────────────────
set -euo pipefail

ROOT="$(git -C "$(dirname "$0")" rev-parse --show-toplevel)"
cd "$ROOT"

echo "▶  Reanudando workspace bc-sql..."
echo ""

# ── 1. Git: traer cambios del remoto ──────────────────────
git pull --ff-only
echo "✓  Repositorio actualizado desde remoto"

# ── 2. Git: restaurar trabajo en progreso si existe ───────
STASH=$(git stash list | grep "wip: paused" | head -1)
if [ -n "$STASH" ]; then
    git stash pop
    echo "✓  Trabajo en progreso restaurado desde stash"
else
    echo "✓  Sin stash pendiente"
fi

# ── 3. Docker: levantar contenedor PostgreSQL ─────────────
COMPOSE="scripts/docker-compose.yml"
if [ -f "$COMPOSE" ]; then
    docker compose -f "$COMPOSE" up -d
    echo "✓  Contenedor PostgreSQL iniciado"
    echo "   → psql: docker compose -f scripts/docker-compose.yml exec postgres psql -U bootcamp -d bootcamp_db"
fi

echo ""
echo "✅ Workspace listo. ¡A trabajar!"
