<div align="center">

# 🛠️ dotfiles

**Meu ambiente de desenvolvimento: configurações, ferramentas e documentação em um só lugar.**

![Windows 11](https://img.shields.io/badge/Windows_11-Home-0078D4?style=for-the-badge)
![WSL 2](https://img.shields.io/badge/WSL_2-Ubuntu_26.04_LTS-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![Zsh](https://img.shields.io/badge/Shell-Zsh_5.9-F15A24?style=for-the-badge&logo=zsh&logoColor=white)
![Git](https://img.shields.io/badge/Commits-Assinados_✔-F05032?style=for-the-badge&logo=git&logoColor=white)
![Status](https://img.shields.io/badge/status-em_evolução-yellow?style=for-the-badge)

</div>

---

## 📖 Sobre

Este repositório é o **manual do meu ambiente de desenvolvimento**. Ele reúne:

- ⚙️ **Configurações** (dotfiles): terminal, Git e ferramentas, versionadas e fáceis de restaurar
- ✅ **Checklists** de tudo que foi configurado, organizados por fase
- 📚 **Documentação oficial** de cada ferramenta, como fonte confiável de consulta

> 💡 **Por que dotfiles?** No Linux, arquivos de configuração costumam começar com `.` (ex.: `.zshrc`, `.gitconfig`). Versionar esses arquivos no Git permite recriar o ambiente inteiro em uma máquina nova em minutos, e ver o histórico de cada mudança.

---

## 📑 Sumário

- [Máquina](#-máquina)
- [O que está configurado](#-o-que-está-configurado)
- [Estrutura do repositório](#-estrutura-do-repositório)
- [Instalação](#-instalação)
- [Roadmap de configuração](#-roadmap-de-configuração)
- [Stack por área](#-stack-por-área)
- [Documentação oficial](#-documentação-oficial)
- [Convenções](#-convenções)
- [Segurança](#-segurança)
- [Autor](#-autor)

---

## 💻 Máquina

| Componente | Especificação |
|---|---|
| CPU | AMD Ryzen 7 7800X3D |
| GPU | NVIDIA GeForce RTX 5070 |
| RAM | 32 GB DDR5 |
| Armazenamento | SSD 2 TB |
| Sistema | Windows 11 Home + WSL 2 (Ubuntu 26.04 LTS) |
| Shell | Zsh 5.9 + Oh My Zsh + Powerlevel10k |

---

## ✨ O que está configurado

| Área | Destaques |
|---|---|
| **Shell** | Zsh com Oh My Zsh, tema Powerlevel10k e plugins `git`, `zsh-autosuggestions` e `zsh-syntax-highlighting` |
| **Navegação** | `eza` no lugar do `ls` (ícones e cores) e `zoxide` para pular entre pastas por frequência de uso |
| **SSH** | `keychain` para carregar a chave SSH uma única vez por sessão |
| **Visual** | `fastfetch` com arte ASCII personalizada ao abrir o terminal |
| **Produtividade** | Função `cheat` para consultar exemplos rápidos de comandos |
| **Git** | Commits e tags assinados com chave SSH, autenticação via GitHub CLI, autocorreção com confirmação |
| **IA** | Instruções pessoais para o Claude Code (`CLAUDE.md`) |

---

## 🗂️ Estrutura do repositório

```text
dotfiles/
├── README.md            # Este manual
├── LICENSE              # Licença MIT
├── .gitignore           # Arquivos que nunca devem ir para o Git
├── claude/              # CLAUDE.md (instruções do Claude Code)
├── docs/                # Inventário e anotações das fases
├── fastfetch/           # Configuração e arte ASCII
├── git/                 # .gitconfig
└── zsh/                 # .zshrc e .p10k.zsh
```

> 🚧 **Planejado:** `vscode/` (configurações e extensões), `windows/` (`.wslconfig`, Windows Terminal, pacotes winget) e `scripts/` (instalação automática).

---

## 🚀 Instalação

Os arquivos ficam no repositório e o sistema acessa cada um por **link simbólico** (um "atalho" que aponta para o arquivo real).

```bash
# 1. Clonar o repositório
git clone git@github.com:th1agopaes/dotfiles.git ~/dev/dotfiles

# 2. Criar os links simbólicos
ln -sf ~/dev/dotfiles/zsh/.zshrc       ~/.zshrc
ln -sf ~/dev/dotfiles/zsh/.p10k.zsh    ~/.p10k.zsh
ln -sf ~/dev/dotfiles/git/.gitconfig   ~/.gitconfig
mkdir -p ~/.config/fastfetch ~/.claude
ln -sf ~/dev/dotfiles/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc
ln -sf ~/dev/dotfiles/claude/CLAUDE.md       ~/.claude/CLAUDE.md
```

> ⚠️ O `ln -sf` **substitui** arquivos existentes. Faça backup antes em uma máquina nova.

---

## 🗺️ Roadmap de configuração

Cada fase só é marcada como concluída quando todos os itens dela estiverem feitos.

### ✅ Fase 0 · Diagnóstico
- [x] Levantar o estado atual do WSL (SO, shell, ferramentas, Git)
- [x] Listar os apps instalados no Windows e atualizá-los (`winget upgrade --all`)
- [x] Limpar arquivos perdidos na home

### Fase 1 · Fundação
- [x] Estrutura de pastas em `~/dev` (`estudos/`, `faculdade/`, `projetos/`, `sandbox/`)
- [x] Repositório de dotfiles com links simbólicos
- [x] `.gitignore` protegendo credenciais
- [x] `README` e `LICENSE`
- [ ] Auditar segredos e tornar o repositório público

### Fase 2 · Segurança
- [x] Gerenciador de senhas (Bitwarden)
- [ ] 2FA nas contas principais
- [x] Chave SSH configurada no GitHub
- [x] Commits assinados (selo *Verified*)
- [ ] Atualizações automáticas (Windows e Ubuntu)
- [ ] Rotina de backup (regra 3-2-1)

### Fase 3 · Terminal
- [ ] Windows Terminal configurado (perfil padrão, fonte, tema)
- [ ] Revisar `.zshrc` e tema do prompt
- [x] Ferramentas modernas: `eza`, `zoxide`, `fastfetch`, `keychain`

### Fase 4 · Editores
- [ ] VS Code com perfis por linguagem
- [ ] IDEs JetBrains (IntelliJ, PyCharm) gerenciadas pelo Toolbox
- [ ] Sincronização de configurações

### Fase 5 · Stack de mercado
- [ ] Definir 1–2 ferramentas por área (tabela abaixo)
- [ ] Instalar e testar cada uma
- [ ] Registrar documentação oficial

### Fase 6 · Manutenção
- [ ] Rotina mensal de atualização e limpeza

---

## 🧰 Stack por área

> 🚧 Será preenchida na **Fase 5**.

| Área | Ferramenta(s) | Documentação |
|---|---|---|
| Linguagens | — | — |
| Front-end | — | — |
| Back-end | — | — |
| Banco de dados | — | — |
| Containers | — | — |
| CI/CD | — | — |
| Cloud | — | — |
| IA / Dados | — | — |
| Testes | — | — |
| Desenvolvimento de jogos | — | — |

---

## 📚 Documentação oficial

Fontes oficiais das ferramentas em uso. Sempre que uma resposta de IA parecer duvidosa, a verdade está aqui.

| Ferramenta | Link |
|---|---|
| WSL | [learn.microsoft.com/pt-br/windows/wsl](https://learn.microsoft.com/pt-br/windows/wsl/) |
| Windows Terminal | [learn.microsoft.com/pt-br/windows/terminal](https://learn.microsoft.com/pt-br/windows/terminal/) |
| Ubuntu no WSL | [documentation.ubuntu.com/wsl](https://documentation.ubuntu.com/wsl/) |
| Git (livro Pro Git em PT-BR) | [git-scm.com/book/pt-br/v2](https://git-scm.com/book/pt-br/v2) |
| GitHub Docs | [docs.github.com/pt](https://docs.github.com/pt) |
| GitHub CLI | [cli.github.com/manual](https://cli.github.com/manual/) |
| Zsh | [zsh.sourceforge.io/Doc](https://zsh.sourceforge.io/Doc/) |
| Oh My Zsh | [ohmyz.sh](https://ohmyz.sh/) |
| Powerlevel10k | [github.com/romkatv/powerlevel10k](https://github.com/romkatv/powerlevel10k) |
| zsh-autosuggestions | [github.com/zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) |
| zsh-syntax-highlighting | [github.com/zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) |
| eza | [github.com/eza-community/eza](https://github.com/eza-community/eza) |
| zoxide | [github.com/ajeetdsouza/zoxide](https://github.com/ajeetdsouza/zoxide) |
| fastfetch | [github.com/fastfetch-cli/fastfetch](https://github.com/fastfetch-cli/fastfetch) |
| VS Code | [code.visualstudio.com/docs](https://code.visualstudio.com/docs) |
| JetBrains Toolbox | [jetbrains.com/toolbox-app](https://www.jetbrains.com/toolbox-app/) |
| Podman | [docs.podman.io](https://docs.podman.io/) |
| Claude Code | [docs.claude.com](https://docs.claude.com/en/docs/claude-code/overview) |

---

## 📐 Convenções

**Mensagens de commit:** seguem o padrão [Conventional Commits](https://www.conventionalcommits.org/pt-br/v1.0.0/), escritas em português.

| Tipo | Quando usar | Exemplo |
|---|---|---|
| `feat` | Nova configuração ou ferramenta | `feat(zsh): adiciona aliases de git` |
| `fix` | Correção de algo quebrado | `fix(wsl): corrige limite de memória` |
| `docs` | Mudança só no README ou em `docs/` | `docs: conclui fase 1 do roadmap` |
| `refactor` | Reorganização sem mudar comportamento | `refactor(vscode): separa perfis` |
| `chore` | Manutenção geral | `chore: atualiza lista de pacotes` |

**Boas práticas:**
- Um commit por mudança lógica (*commits atômicos*)
- Branch principal: `main`
- Todo commit assinado

---

## 🔒 Segurança

- ❌ **Nunca** versionar senhas, tokens, chaves privadas (`id_ed25519`) ou arquivos `.env`
- ✅ Dados sensíveis ficam em arquivos locais listados no `.gitignore`
- ✅ Revisar o `git diff --staged` antes de cada commit

---

## 👤 Autor

**Thiago Paes (Haru)** · Estudante de Engenharia da Computação · IFMT

[![GitHub](https://img.shields.io/badge/GitHub-th1agopaes-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/th1agopaes)

---

<div align="center">

📄 Licença [MIT](LICENSE)

</div>
