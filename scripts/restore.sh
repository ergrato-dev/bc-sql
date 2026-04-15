#!/usr/bin/env bash
# restore.sh — Instalación completa desde cero (máquina nueva o reset)
# Uso: ./scripts/restore.sh [--reset-db]
#
#   Sin flags   → git pull + docker up (conserva datos)
#   --reset-db  → git pull + docker down -v + docker up (borra datos PG)
# ─────────────────────────────────────────────────────────────────────
set -euo pipefail

ROOT="$(git -C "$(dirname "$0")" rev-parse --show-toplevel)"
cd "$ROOT"

RESET_DB=false
for arg in "$@"; do
    [ "$arg" = "--reset-db" ] && RESET_DB=true
done

echo "🔄 Restaurando workspace bc-sql..."
[ "$RESET_DB" = true ] && echo "   ⚠️  Modo --reset-db: se eliminarán los datos de PostgreSQL"
echo ""

# ── 1. Git: sincronizar con remoto ────────────────────────
git fetch --all
git pull --ff-only
echo "✓  Repositorio sincronizado"

# ── 2. Docker: levantar (con o sin reset de volumen) ──────
COMPOSE="scripts/docker-compose.yml"
if [ -f "$COMPOSE" ]; then
    if [ "$RESET_DB" = true ]; then
        docker compose -f "$COMPOSE" down -v 2>/dev/null || true
        echo "✓  Volumen PostgreSQL eliminado"
    fi

    docker compose -f "$COMPOSE" up -d
    echo "✓  Contenedor PostgreSQL iniciado"
    echo "   → psql: docker compose -f scripts/docker-compose.yml exec postgres psql -U bootcamp -d bootcamp_db"
fi

echo ""
echo "✅ Workspace restaurado y listo."
