#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> Iniciando bootstrap"

# Set profile
if [[ ! -f "$HOME/.mac-profile" ]]; then
  echo "Select a profile:"
  echo "  1) personal"
  echo "  2) work"
  read -r -p "Profile [1/2]: " choice
  case "$choice" in
    1) echo "personal" > "$HOME/.mac-profile" ;;
    2) echo "work" > "$HOME/.mac-profile" ;;
    *) echo "Invalid choice. Set ~/.mac-profile manually and re-run."; exit 1 ;;
  esac
  echo "Profile set to: $(cat "$HOME/.mac-profile")"
fi

bash "$REPO_ROOT/scripts/install-packages.sh"
bash "$REPO_ROOT/scripts/backup-existing.sh"
bash "$REPO_ROOT/scripts/link-configs.sh"

echo
echo "==> Bootstrap concluído"
echo "Abra um novo terminal ou rode:"
echo "source ~/.zshrc"
