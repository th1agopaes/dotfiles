# ============================================================
# ambiente.zsh · variáveis, PATH e versões das ferramentas
# Carregado pelo .zshrc antes dos aliases e das funções
# ============================================================

# O Windows Terminal não se identifica sozinho dentro do WSL
[[ -n $WT_SESSION ]] && export TERM_PROGRAM="Windows Terminal"

# Editor padrão (usado pelo git commit, por exemplo)
export EDITOR="code --wait"

# Pasta Downloads do Windows (ex.: trazer "$DL/arquivo")
DL="/mnt/c/Users/kajik/Downloads"

# --- PATH (typeset -U remove caminhos repetidos) ---
typeset -U path PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# --- mise (gerencia as versões de Node, delta etc.) ---
eval "$(~/.local/bin/mise activate zsh)"
