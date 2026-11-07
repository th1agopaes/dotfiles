# ============================================================
# .zshrc · arquivo principal do Zsh (Haru)
# Ordem: o que imprime na tela → prompt instantâneo → Oh My Zsh
#        → módulos do dotfiles → ajustes só desta máquina
# Módulos: ambiente.zsh · aliases.zsh · funcoes.zsh · integracoes.zsh
# ============================================================

# --- 1. Antes do prompt instantâneo (pode pedir senha ou imprimir na tela) ---
eval "$(keychain --eval --quiet id_ed25519)"
fastfetch --file ~/.config/fastfetch/haru-mini.txt --logo-color-1 magenta

# --- 2. Prompt instantâneo do Powerlevel10k (deve ficar perto do topo) ---
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- 3. Oh My Zsh: tema e plugins ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
# Atualizações do Oh My Zsh só pelo `atualizar` (sem perguntas ao abrir o terminal)
zstyle ':omz:update' mode disabled
source "$ZSH/oh-my-zsh.sh"

# Visual do prompt (gerado por `p10k configure`)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# --- 4. Módulos do dotfiles (a ordem importa: integrações por último) ---
DOTFILES="$HOME/dev/dotfiles"
for modulo in ambiente aliases funcoes integracoes; do
  source "$DOTFILES/zsh/$modulo.zsh"
done
unset modulo

# --- 5. Ajustes só desta máquina (arquivo opcional, fica fora do Git) ---
[[ ! -r ~/.zshrc.local ]] || source ~/.zshrc.local
