# ============================================================
# funcoes.zsh · comandos próprios (mais completos que um alias)
# ============================================================

# Exemplos rápidos de um comando: tldr → man → --help
cheat() {
  if [[ -z "$1" ]]; then
    echo "uso: cheat <comando>" >&2
    return 1
  fi
  tldr "$1" 2>/dev/null || man "$1" 2>/dev/null || "$1" --help
}

# Copia arquivos do Windows para a pasta atual com permissão 644
# (arquivos do NTFS chegam como "executáveis" no Linux)
trazer() {
  if (( $# == 0 )); then
    echo "uso: trazer <arquivo>..." >&2
    return 1
  fi
  install -m 644 -t . -- "$@"
}

# Atualiza tudo no Ubuntu: apt, mise, Rust, uv, plugins/tema do Zsh e Oh My Zsh
atualizar() {
  print -P "%F{cyan}==> Ubuntu (apt)%f"
  sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y

  print -P "%F{cyan}==> mise e ferramentas%f"
  mise self-update --yes && mise upgrade

  print -P "%F{cyan}==> Rust%f"
  rustup update

  print -P "%F{cyan}==> uv%f"
  uv self update

  print -P "%F{cyan}==> Plugins e tema do Zsh%f"
  local repo
  for repo in ${ZSH_CUSTOM:-$ZSH/custom}/{plugins,themes}/*/.git(N:h); do
    git -C "$repo" pull --quiet --ff-only && print "  ✔ ${repo:t}"
  done


  # Por último: se houver novidade, o omz update reinicia o terminal
  print -P "%F{cyan}==> Oh My Zsh%f"
  omz update
}
