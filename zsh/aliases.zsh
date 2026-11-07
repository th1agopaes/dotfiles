# ============================================================
# aliases.zsh · atalhos de comandos
# Para ver todos os aliases ativos: alias
# ============================================================

# --- Navegação (eza) ---
alias ls='eza --icons --group-directories-first'
alias ll='eza -la --icons --group-directories-first --git'
alias la='eza -a --icons --group-directories-first'
alias lt='eza --tree --icons --level=2'

# --- Atalhos de pastas ---
alias dev='cd ~/dev'
alias fac='cd ~/dev/faculdade/05-semestre'
alias est='cd ~/dev/estudos'
alias proj='cd ~/dev/projetos'

# --- Ferramentas com nome diferente no Ubuntu ---
alias bat='batcat'
alias fd='fdfind'

# --- Manutenção ---
alias zshconfig='code "$DOTFILES/zsh"'
alias recarregar='omz reload'

# --- Visual ---
alias sistema='fastfetch --file ~/.config/fastfetch/haru.txt --logo-color-1 magenta'
