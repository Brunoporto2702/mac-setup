#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> Iniciando bootstrap"

bash "$REPO_ROOT/scripts/install-packages.sh"
bash "$REPO_ROOT/scripts/backup-existing.sh"
bash "$REPO_ROOT/scripts/link-configs.sh"

echo
echo "==> Bootstrap concluído"
echo "Abra um novo terminal ou rode:"
echo "source ~/.zshrc"
