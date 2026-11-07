# ============================================================
# integracoes.zsh · ferramentas que se ligam ao shell
# Carregado por último (a documentação do zoxide pede o fim da configuração)
# ============================================================

# fzf: Ctrl+R (histórico) | Ctrl+T (arquivos) | Alt+C (pastas)
source <(fzf --zsh)

# zoxide: z <nome> pula para pastas usadas com frequência
eval "$(zoxide init zsh)"
