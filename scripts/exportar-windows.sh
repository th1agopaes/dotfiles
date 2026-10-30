#!/usr/bin/env bash
#
# exportar-windows.sh
# Copia para o repositório as configurações que vivem no lado Windows.
#
# Esses arquivos pertencem aos próprios apps (o Windows Terminal, por exemplo,
# reescreve o settings.json quando você muda algo pela interface). Por isso o
# Windows é a "fonte da verdade" e o repositório guarda um retrato versionado.
#
# Uso: ./scripts/exportar-windows.sh   (depois revise com git diff e faça o commit)

set -euo pipefail

WIN_HOME="/mnt/c/Users/kajik"
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# exportar <arquivo no Windows> <destino relativo ao repositório>
exportar() {
  local origem="$1"
  local destino="$REPO/$2"

  if [[ ! -f "$origem" ]]; then
    echo "⚠️  não encontrado: $origem" >&2
    return 0
  fi

  mkdir -p "$(dirname "$destino")"
  install -m 644 "$origem" "$destino"
  echo "✔ $2"
}

exportar "$WIN_HOME/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json" \
         "windows/terminal/settings.json"

exportar "$WIN_HOME/Documents/PowerShell/Microsoft.PowerShell_profile.ps1" \
         "windows/powershell/Microsoft.PowerShell_profile.ps1"

exportar "$WIN_HOME/AppData/Roaming/Code/User/settings.json" \
         "vscode/settings.json"

echo
git -C "$REPO" status --short -- windows/ vscode/
