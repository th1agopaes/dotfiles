#!/usr/bin/env bash
#
# verificar.sh
# "Check-up" do ambiente de desenvolvimento: confere links simbólicos,
# ferramentas, Git, segurança, configurações do Windows e backups.
#
# Só LÊ informações: não altera nenhum arquivo.
#
# Uso: ./scripts/verificar.sh
# Saída: ✔ ok · ⚠ atenção · ✖ problema (código de saída 1 se houver ✖)

set -uo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WIN_HOME="/mnt/c/Users/kajik"

# ---------- saída colorida (só quando é um terminal) ----------
if [[ -t 1 ]]; then
  VERDE=$'\e[32m'; AMARELO=$'\e[33m'; VERMELHO=$'\e[31m'; CIANO=$'\e[36m'; FIM=$'\e[0m'
else
  VERDE=""; AMARELO=""; VERMELHO=""; CIANO=""; FIM=""
fi

OK=0; AVISOS=0; ERROS=0
ok()    { echo "  ${VERDE}✔${FIM} $*"; OK=$((OK + 1)); }
aviso() { echo "  ${AMARELO}⚠${FIM} $*"; AVISOS=$((AVISOS + 1)); }
erro()  { echo "  ${VERMELHO}✖${FIM} $*"; ERROS=$((ERROS + 1)); }
secao() { echo; echo "${CIANO}== $* ==${FIM}"; }

# ---------- 1. Links simbólicos ----------
secao "Links simbólicos (dotfiles)"
checar_link() {
  local link="$1" alvo="$REPO/$2"
  if [[ -L "$link" && "$(readlink -f "$link")" == "$(readlink -f "$alvo")" ]]; then
    ok "${link/#$HOME/\~} → $2"
  elif [[ -e "$link" ]]; then
    erro "${link/#$HOME/\~} existe, mas não é um link para $2"
  else
    erro "${link/#$HOME/\~} não existe"
  fi
}
checar_link "$HOME/.zshrc"                       "zsh/.zshrc"
checar_link "$HOME/.p10k.zsh"                    "zsh/.p10k.zsh"
checar_link "$HOME/.gitconfig"                   "git/.gitconfig"
checar_link "$HOME/.gitignore_global"            "git/.gitignore_global"
checar_link "$HOME/.config/git/allowed_signers"  "git/allowed_signers"
checar_link "$HOME/.config/fastfetch"            "fastfetch"
checar_link "$HOME/.config/mise/config.toml"     "mise/config.toml"
checar_link "$HOME/.claude/CLAUDE.md"            "claude/CLAUDE.md"

# ---------- 2. Ferramentas ----------
secao "Ferramentas"
checar_cmd() {
  local cmd="$1" versao
  if command -v "$cmd" >/dev/null 2>&1; then
    versao="$("$cmd" --version 2>&1 | head -1)"
    ok "$cmd · ${versao:0:60}"
  else
    erro "$cmd não encontrado"
  fi
}
for c in zsh git gh mise node npm uv rustc cargo java gcc podman podman-compose \
         hyperfine eza zoxide fzf batcat fdfind tldr keychain fastfetch claude; do
  checar_cmd "$c"
done
if command -v code >/dev/null 2>&1; then ok "code (VS Code) disponível"; else aviso "code (VS Code) não está no PATH"; fi

# ---------- 3. Ambiente ----------
secao "Ambiente"
[[ "${SHELL:-}" == *zsh ]] && ok "shell padrão: $SHELL" || aviso "shell padrão é ${SHELL:-desconhecido} (esperado: zsh)"
if [[ ":$PATH:" == *"/.nvm/"* ]]; then erro "o PATH ainda contém o nvm"; else ok "PATH sem restos do nvm"; fi
case "$(command -v node 2>/dev/null)" in
  *mise*) ok "node gerenciado pelo mise" ;;
  "")     erro "node não encontrado" ;;
  *)      aviso "node fora do mise: $(command -v node)" ;;
esac
if command -v hyperfine >/dev/null 2>&1 && command -v python3 >/dev/null 2>&1; then
  tmp="$(mktemp)"
  hyperfine --warmup 2 --runs 5 --style none --export-json "$tmp" 'zsh -i -c exit' >/dev/null 2>&1
  ms="$(python3 -c 'import json,sys; print(round(json.load(open(sys.argv[1]))["results"][0]["mean"]*1000))' "$tmp" 2>/dev/null)"
  rm -f "$tmp"
  if [[ -n "$ms" ]]; then
    (( ms <= 500 )) && ok "abertura do zsh: ${ms} ms" || aviso "abertura do zsh: ${ms} ms (meta: até 500 ms)"
  fi
fi

# ---------- 4. Git e repositório ----------
secao "Git e repositório"
[[ "$(git config --global commit.gpgsign)" == "true" ]] && ok "commits assinados por padrão" || erro "commit.gpgsign não está ativo"
[[ "$(git config --global gpg.format)" == "ssh" ]] && ok "assinatura via chave SSH" || aviso "gpg.format não é ssh"
assinatura="$(git -C "$REPO" log -1 --format=%G? 2>/dev/null)"
[[ "$assinatura" == "G" ]] && ok "último commit com assinatura válida" || erro "último commit sem assinatura válida (%G? = ${assinatura:-?})"
if [[ -z "$(git -C "$REPO" status --porcelain)" ]]; then ok "repositório sem alterações pendentes"; else aviso "há alterações não commitadas no dotfiles"; fi
pendentes="$(git -C "$REPO" log --oneline '@{u}..' 2>/dev/null | wc -l)"
(( pendentes == 0 )) && ok "nenhum commit esperando push" || aviso "$pendentes commit(s) esperando push"

# ---------- 5. Segurança ----------
secao "Segurança"
if [[ -d "$HOME/.ssh" ]]; then
  [[ "$(stat -c %a "$HOME/.ssh")" == "700" ]] && ok "pasta .ssh com permissão 700" || erro "pasta .ssh deveria ter permissão 700 (atual: $(stat -c %a "$HOME/.ssh"))"
  for chave in "$HOME"/.ssh/id_*; do
    [[ -f "$chave" && "$chave" != *.pub ]] || continue
    perm="$(stat -c %a "$chave")"
    [[ "$perm" == "600" ]] && ok "${chave/#$HOME/\~} com permissão 600" || erro "${chave/#$HOME/\~} deveria ter permissão 600 (atual: $perm)"
  done
fi
if getent group docker >/dev/null; then aviso "grupo docker existe (dá poder de root a quem está nele)"; else ok "sem grupo docker"; fi
[[ "$(systemctl is-active unattended-upgrades 2>/dev/null)" == "active" ]] && ok "atualizações automáticas de segurança ativas" || aviso "unattended-upgrades não está ativo"

# ---------- 6. Configurações do Windows ----------
secao "Configurações do Windows × repositório"
comparar() {
  local origem="$1" destino="$REPO/$2"
  if [[ ! -f "$origem" ]]; then aviso "não encontrado no Windows: $2"; return; fi
  # ignora a diferença de quebra de linha (CRLF do Windows × LF do Git)
  if diff -q <(tr -d '\r' < "$origem") <(tr -d '\r' < "$destino") >/dev/null 2>&1; then
    ok "$2 igual ao Windows"
  else
    aviso "$2 diferente do Windows (rode ./scripts/exportar-windows.sh)"
  fi
}
comparar "$WIN_HOME/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json" "windows/terminal/settings.json"
comparar "$WIN_HOME/Documents/PowerShell/Microsoft.PowerShell_profile.ps1" "windows/powershell/Microsoft.PowerShell_profile.ps1"
comparar "$WIN_HOME/AppData/Roaming/Code/User/settings.json" "vscode/settings.json"

# ---------- 7. Backups ----------
secao "Backups"
verificar_backup() {
  local pasta="$1" nome="$2" ultimo dias
  if [[ ! -d "$pasta" ]]; then aviso "$nome: pasta não acessível ($pasta)"; return; fi
  ultimo="$(ls -t "$pasta"/ubuntu-*.7z 2>/dev/null | head -1)"
  if [[ -z "$ultimo" ]]; then erro "$nome: nenhum backup .7z encontrado"; return; fi
  dias=$(( ( $(date +%s) - $(stat -c %Y "$ultimo") ) / 86400 ))
  (( dias <= 35 )) && ok "$nome: $(basename "$ultimo") (há $dias dia(s))" \
                   || aviso "$nome: último backup tem $dias dias (rode Backup-Wsl)"
  ls "$pasta"/*.tar >/dev/null 2>&1 && erro "$nome: há .tar SEM criptografia em $pasta"
}
verificar_backup "/mnt/c/backup/wsl" "SSD"
if [[ -d "/mnt/g" ]]; then
  verificar_backup "/mnt/g/Meu Drive/Backups" "Google Drive"
else
  aviso "Google Drive (G:) não está montado no WSL: confira a pasta Backups pelo Windows"
fi

# ---------- Resumo ----------
echo
echo "${CIANO}== Resumo ==${FIM}  ${VERDE}✔ $OK${FIM}  ${AMARELO}⚠ $AVISOS${FIM}  ${VERMELHO}✖ $ERROS${FIM}"
(( ERROS == 0 ))
