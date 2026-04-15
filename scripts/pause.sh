#!/usr/bin/env bash
# pause.sh — Guarda el estado del workspace antes de salir
# Uso: ./scripts/pause.sh
# ─────────────────────────────────────────────────────────
set -euo pipefail

ROOT="$(git -C "$(dirname "$0")" rev-parse --show-toplevel)"
cd "$ROOT"

echo "⏸  Pausando workspace bc-sql..."
echo ""

# ── 1. Git: guardar cambios pendientes ────────────────────
if ! git diff --quiet \
    || ! git diff --cached --quiet \
    || [ -n "$(git ls-files --others --exclude-standard)" ]; then

    TIMESTAMP=$(date '+%Y-%m-%d %H:%M')
    git add -A
    git stash push -m "wip: paused at $TIMESTAMP"
    echo "✓  Cambios guardados en stash"
else
    echo "✓  Working tree limpio — nada que guardar"
fi

# ── 2. Git: push de commits ya existentes ─────────────────
AHEAD=$(git rev-list --count @{u}..HEAD 2>/dev/null || echo 0)
if [ "$AHEAD" -gt 0 ]; then
    git push
    echo "✓  $AHEAD commit(s) pusheado(s) al remoto"
else
    echo "✓  Remoto ya está al día"
fi

# ── 3. Docker: detener contenedor si está corriendo ───────
COMPOSE="scripts/docker-compose.yml"
if [ -f "$COMPOSE" ]; then
    if docker compose -f "$COMPOSE" ps --quiet 2>/dev/null | grep -q .; then
        docker compose -f "$COMPOSE" down
        echo "✓  Contenedor PostgreSQL detenido"
    else
        echo "✓  Contenedor ya estaba detenido"
    fi
fi

echo ""
echo "✅ Workspace pausado. ¡Hasta pronto!"
