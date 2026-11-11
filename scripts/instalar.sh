#!/usr/bin/env bash
#
# instalar.sh
# Recria o lado Linux (Ubuntu no WSL) do ambiente de desenvolvimento numa
# máquina nova: pacotes, Zsh + Oh My Zsh, versões (mise, uv, Rust) e os
# links simbólicos do dotfiles.
#
# É idempotente: pode rodar quantas vezes quiser; o que já está pronto é pulado.
# Arquivos que seriam substituídos pelos links vão para ~/.dotfiles-backup/<data>/.
#
# Uso:  ./scripts/instalar.sh            instala
#       ./scripts/instalar.sh --simular  só mostra o que faria, sem mudar nada
#
# Requisitos: Ubuntu 26.04, usuário comum com sudo e o repositório em ~/dev/dotfiles

set -Eeuo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
USUARIO="$(id -un)"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y-%m-%d_%H%M%S)"
SIMULAR=0

# Impressões digitais oficiais das chaves do repositório apt do GitHub CLI
# (fonte: https://github.com/cli/cli/blob/trunk/docs/install_linux.md)
GH_CHAVES_OFICIAIS="2C6106201985B60E6C7AC87323F3D4EA75716059 7F38BBB59D064DBCB3D84D725612B36462313325"

# ---------- saída colorida (só quando é um terminal) ----------
if [[ -t 1 ]]; then
  VERDE=$'\e[32m'; AMARELO=$'\e[33m'; VERMELHO=$'\e[31m'; CIANO=$'\e[36m'; FIM=$'\e[0m'
else
  VERDE=""; AMARELO=""; VERMELHO=""; CIANO=""; FIM=""
fi
etapa() { echo; echo "${CIANO}==> $*${FIM}"; }
ok()    { echo "  ${VERDE}✔${FIM} $*"; }
info()  { echo "  ${AMARELO}→${FIM} $*"; }
erro()  { echo "  ${VERMELHO}✖${FIM} $*" >&2; }
feito() { (( SIMULAR )) || ok "$@"; }   # confirma uma ação (calado na simulação)

trap 'erro "falhou na linha $LINENO. Corrija e rode de novo: o que já estiver pronto será pulado."' ERR

# Executa um comando ou, no modo simulação, só mostra o que seria feito
executar() {
  if (( SIMULAR )); then
    echo "  [simulação] $*"
  else
    "$@"
  fi
}

# Baixa o instalador oficial de uma ferramenta e o executa.
# No comando, {} marca onde entra o arquivo baixado (como no find -exec).
# Ex.: instalar_com_script https://mise.run sh {}
instalar_com_script() {
  local url="$1"; shift
  if (( SIMULAR )); then
    echo "  [simulação] baixar $url e executar: $*"
    return
  fi
  local script arg comando=()
  script="$(mktemp)"
  curl --proto '=https' --tlsv1.2 -fsSL "$url" -o "$script"
  for arg in "$@"; do
    if [[ "$arg" == "{}" ]]; then comando+=("$script"); else comando+=("$arg"); fi
  done
  "${comando[@]}"
  rm -f "$script"
}

# Cria um link simbólico do repositório para o lugar esperado,
# guardando no backup qualquer arquivo que já exista ali
linkar() {
  local origem="$REPO/$1" destino="$2" nome="${2/#$HOME/\~}"
  if [[ -L "$destino" && "$(readlink -f "$destino")" == "$(readlink -f "$origem")" ]]; then
    ok "$nome já aponta para $1"
    return
  fi
  [[ -d "$(dirname "$destino")" ]] || executar mkdir -p "$(dirname "$destino")"
  if [[ -e "$destino" || -L "$destino" ]]; then
    executar mkdir -p "$BACKUP"
    executar mv "$destino" "$BACKUP/"
    info "$nome antigo guardado em ${BACKUP/#$HOME/\~}/"
  fi
  executar ln -s "$origem" "$destino"
  feito "$nome → $1"
}

# Clona um repositório (plugin/tema) só se ainda não existir
clonar() {
  local url="$1" destino="$2"
  if [[ -d "$destino/.git" ]]; then
    ok "${destino##*/} já instalado"
  else
    executar git clone --quiet --depth=1 "$url" "$destino"
    feito "${destino##*/} instalado"
  fi
}

# ---------- opções ----------
case "${1:-}" in
  "")         ;;
  --simular)  SIMULAR=1 ;;
  -h|--help)  sed -n '3,15p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
  *)          erro "opção desconhecida: $1 (use --simular ou --help)"; exit 2 ;;
esac

# ---------- 0. Conferências antes de começar ----------
etapa "Conferindo o terreno"
if (( EUID == 0 )); then
  erro "rode como seu usuário comum (o script chama o sudo quando precisa)"; exit 1
fi
# shellcheck source=/dev/null
. /etc/os-release
if [[ "${ID:-}" != "ubuntu" ]]; then
  erro "este script é para Ubuntu (encontrado: ${PRETTY_NAME:-desconhecido})"; exit 1
fi
if [[ "${VERSION_ID:-}" == "26.04" ]]; then
  ok "$PRETTY_NAME"
else
  info "feito para o Ubuntu 26.04; encontrado $PRETTY_NAME (seguindo mesmo assim)"
fi
if [[ "$(readlink -f "$REPO")" != "$(readlink -f "$HOME/dev/dotfiles")" ]]; then
  erro "o repositório precisa estar em ~/dev/dotfiles (o .zshrc e o .gitconfig usam esse caminho)"; exit 1
fi
ok "repositório em ~/dev/dotfiles"
command -v sudo >/dev/null || { erro "sudo não encontrado"; exit 1; }
if (( SIMULAR )); then
  info "modo simulação: nada será alterado"
else
  sudo -v   # pede a senha do sudo uma vez, no começo
fi

# ---------- 1. Pacotes do Ubuntu ----------
etapa "Pacotes do Ubuntu (apt)"
PACOTES=(
  zsh git curl wget gpg ca-certificates software-properties-common
  eza zoxide fzf bat fd-find tealdeer keychain hyperfine
  podman podman-compose build-essential openjdk-25-jdk
)
executar sudo env DEBIAN_FRONTEND=noninteractive apt-get update -q
executar sudo env DEBIAN_FRONTEND=noninteractive apt-get install -y -q "${PACOTES[@]}"
feito "pacotes base"

# GitHub CLI pelo repositório oficial (o do Ubuntu é antigo), com a chave conferida
if grep -rqs "cli.github.com/packages" /etc/apt/sources.list.d/; then
  ok "repositório do GitHub CLI já configurado"
elif (( SIMULAR )); then
  echo "  [simulação] baixar a chave do GitHub CLI, conferir as impressões digitais e adicionar o repositório"
else
  chave="$(mktemp)"
  curl --proto '=https' --tlsv1.2 -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg -o "$chave"
  # impressões digitais das chaves principais (ignora as subchaves)
  digitais="$(gpg --show-keys --with-colons "$chave" 2>/dev/null | awk -F: '$1 == "fpr" && anterior == "pub" {print $10} {anterior = $1}')"
  [[ -n "$digitais" ]] || { erro "não consegui ler a chave do GitHub CLI"; exit 1; }
  while read -r d; do
    [[ " $GH_CHAVES_OFICIAIS " == *" $d "* ]] || { erro "chave do GitHub CLI desconhecida ($d): confira a documentação oficial"; exit 1; }
  done <<< "$digitais"
  sudo install -D -m 644 "$chave" /etc/apt/keyrings/githubcli-archive-keyring.gpg
  rm -f "$chave"
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
    | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
  ok "repositório do GitHub CLI adicionado (chave conferida)"
fi

# fastfetch pelo PPA oficial do projeto (versão mais nova que a do Ubuntu)
if grep -rqs "zhangsongcui3371/fastfetch" /etc/apt/sources.list.d/; then
  ok "PPA do fastfetch já configurado"
else
  executar sudo add-apt-repository -y -n ppa:zhangsongcui3371/fastfetch
  feito "PPA do fastfetch adicionado"
fi
executar sudo env DEBIAN_FRONTEND=noninteractive apt-get update -q
executar sudo env DEBIAN_FRONTEND=noninteractive apt-get install -y -q gh fastfetch
feito "gh e fastfetch"

# ---------- 2. Links simbólicos ----------
etapa "Links simbólicos do dotfiles"
linkar zsh/.zshrc             "$HOME/.zshrc"
linkar zsh/.p10k.zsh          "$HOME/.p10k.zsh"
linkar git/.gitconfig         "$HOME/.gitconfig"
linkar git/.gitignore_global  "$HOME/.gitignore_global"
linkar git/allowed_signers    "$HOME/.config/git/allowed_signers"
linkar fastfetch              "$HOME/.config/fastfetch"
linkar mise/config.toml       "$HOME/.config/mise/config.toml"
linkar claude/CLAUDE.md       "$HOME/.claude/CLAUDE.md"

# ---------- 3. Oh My Zsh, tema e plugins ----------
etapa "Oh My Zsh, Powerlevel10k e plugins"
if [[ -d "$HOME/.oh-my-zsh" ]]; then
  ok "Oh My Zsh já instalado"
else
  # --unattended: não troca o shell nem abre o zsh · --keep-zshrc: mantém o nosso .zshrc
  instalar_com_script https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh \
    sh {} --unattended --keep-zshrc
  feito "Oh My Zsh instalado"
fi
CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
clonar https://github.com/romkatv/powerlevel10k.git              "$CUSTOM/themes/powerlevel10k"
clonar https://github.com/zsh-users/zsh-autosuggestions.git      "$CUSTOM/plugins/zsh-autosuggestions"
clonar https://github.com/zsh-users/zsh-syntax-highlighting.git  "$CUSTOM/plugins/zsh-syntax-highlighting"

# ---------- 4. Versões das ferramentas ----------
etapa "Versões das ferramentas (mise, uv, Rust)"
if [[ -x "$HOME/.local/bin/mise" ]]; then
  ok "mise já instalado"
else
  instalar_com_script https://mise.run sh {}
  feito "mise instalado"
fi
executar "$HOME/.local/bin/mise" install
feito "ferramentas do mise/config.toml (Node, delta…)"

if [[ -x "$HOME/.local/bin/uv" ]]; then
  ok "uv já instalado"
else
  # UV_NO_MODIFY_PATH: quem controla o PATH é o .zshrc do dotfiles
  instalar_com_script https://astral.sh/uv/install.sh env UV_NO_MODIFY_PATH=1 sh {}
  feito "uv instalado"
fi

if [[ -x "$HOME/.cargo/bin/rustup" ]]; then
  ok "Rust (rustup) já instalado"
else
  instalar_com_script https://sh.rustup.rs sh {} -y --no-modify-path
  feito "Rust instalado"
fi

# ---------- 5. Shell padrão e últimos ajustes ----------
etapa "Shell padrão e últimos ajustes"
ZSH_BIN="$(command -v zsh || echo /usr/bin/zsh)"
if [[ "$(getent passwd "$USUARIO" | cut -d: -f7)" == "$ZSH_BIN" ]]; then
  ok "zsh já é o shell padrão"
else
  executar sudo chsh -s "$ZSH_BIN" "$USUARIO"
  feito "zsh definido como shell padrão"
fi
if (( SIMULAR )); then
  echo "  [simulação] tldr --update"
elif tldr --update >/dev/null 2>&1; then
  ok "páginas do tldr baixadas"
else
  info "não deu para baixar as páginas do tldr agora; rode 'tldr --update' depois"
fi

# ---------- Resumo ----------
etapa "Pronto! Falta só o que é pessoal (manual, por segurança)"
if [[ -d "$BACKUP" ]]; then info "arquivos antigos guardados em ${BACKUP/#$HOME/\~}/"; fi
cat <<'EOF'
  1. Chave SSH: restaure a sua de um backup seguro ou crie uma nova
     (ssh-keygen -t ed25519) e cadastre no GitHub para autenticação e assinatura.
     Chave nova? Atualize também o git/allowed_signers.
  2. GitHub CLI: gh auth login
  3. Remoto do dotfiles por SSH:
     git -C ~/dev/dotfiles remote set-url origin git@github.com:th1agopaes/dotfiles.git
  4. Lado Windows (Terminal, PowerShell e VS Code): veja o README, passo 4
  5. Abra um terminal novo e rode ~/dev/dotfiles/scripts/verificar.sh
EOF
if (( SIMULAR )); then echo; info "simulação concluída: nada foi alterado"; fi
