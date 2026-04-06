#!/usr/bin/env bash
set -euo pipefail

echo "==> Instalando pacotes pessoais"

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

brew install tursodatabase/tap/turso

echo "==> Pacotes pessoais instalados"
