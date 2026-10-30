<div align="center">

# 🛠️ dotfiles

**Meu ambiente de desenvolvimento: configurações, ferramentas e documentação em um só lugar.**

![Windows 11](https://img.shields.io/badge/Windows_11-Home-0078D4?style=for-the-badge)
![WSL 2](https://img.shields.io/badge/WSL_2-Ubuntu_26.04_LTS-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![Zsh](https://img.shields.io/badge/Shell-Zsh_5.9-F15A24?style=for-the-badge&logo=zsh&logoColor=white)
![PowerShell](https://img.shields.io/badge/PowerShell-7-5391FE?style=for-the-badge)
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
- [Backup e restauração](#-backup-e-restauração)
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
| Terminal | Windows Terminal + PowerShell 7 |

---

## ✨ O que está configurado

| Área | Destaques |
|---|---|
| **Terminal** | Windows Terminal com tema Catppuccin Mocha, fonte MesloLGS NF e transparência acrílica para todos os perfis; Ubuntu como padrão; pastas iniciais definidas |
| **PowerShell** | PowerShell 7 com UTF-8 em tudo (acentos corretos em pipes e arquivos) |
| **Shell** | Zsh com Oh My Zsh, tema Powerlevel10k e plugins `git`, `zsh-autosuggestions` e `zsh-syntax-highlighting` |
| **Navegação** | `eza` no lugar do `ls` (ícones e cores), `zoxide` para pular entre pastas por frequência de uso e `fzf` para busca interativa |
| **Arquivos** | `bat` (`cat` com cores) e `fd` (`find` mais rápido e simples) |
| **SSH** | `keychain` para carregar a chave SSH uma única vez por sessão |
| **Visual** | `fastfetch` com arte ASCII personalizada ao abrir o terminal |
| **Produtividade** | Funções `cheat` (consulta `tldr` → `man` → `--help`) e `trazer` (copia arquivos do Windows com permissão correta), além de aliases para pastas e tarefas comuns |
| **Node.js** | Versões gerenciadas pelo `nvm` |
| **Git** | Commits e tags assinados com chave SSH, autenticação via GitHub CLI, autocorreção com confirmação |
| **IA** | Instruções pessoais para o Claude Code (`CLAUDE.md`) |

<details>
<summary><b>⌨️ Aliases e funções</b></summary>

| Comando | O que faz |
|---|---|
| `ls`, `ll`, `la`, `lt` | Listagens com `eza` (simples, detalhada com Git, ocultos e árvore) |
| `dev`, `est`, `proj`, `fac` | Vai direto para `~/dev`, estudos, projetos e o semestre atual |
| `atualizar` | Atualiza e limpa os pacotes do Ubuntu |
| `zshconfig` / `recarregar` | Abre o `.zshrc` no VS Code / recarrega as configurações |
| `bat`, `fd` | Atalhos para `batcat` e `fdfind` (nomes dos pacotes no Ubuntu) |
| `waifu` | Mostra o `fastfetch` com a arte ASCII grande |
| `cheat <comando>` | Mostra exemplos rápidos de um comando |
| `trazer <arquivo>` | Copia arquivos do Windows para a pasta atual com permissão `644` (ex.: `trazer "$DL/foto.png"`) |
| `$DL` | Variável com a pasta Downloads do Windows |

</details>

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
├── git/                 # .gitconfig e allowed_signers
├── scripts/             # exportar-windows.sh
├── windows/             # Windows Terminal e perfil do PowerShell
└── zsh/                 # .zshrc e .p10k.zsh
```

> 🚧 **Planejado:** `vscode/` (configurações e extensões).

---

## 🚀 Instalação

Os arquivos ficam no repositório e o sistema acessa cada um por **link simbólico** (um "atalho" que aponta para o arquivo real).

**1. Pacotes do Ubuntu**

```bash
sudo apt update
sudo apt install -y zsh git gh eza zoxide fzf bat fd-find tldr keychain fastfetch
```

**2. Instalações manuais** (seguir a documentação oficial de cada um)

| Ferramenta | Instalação |
|---|---|
| Oh My Zsh | [ohmyz.sh/#install](https://ohmyz.sh/#install) |
| Powerlevel10k | [github.com/romkatv/powerlevel10k#oh-my-zsh](https://github.com/romkatv/powerlevel10k#oh-my-zsh) |
| zsh-autosuggestions | [Instalação com Oh My Zsh](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh) |
| zsh-syntax-highlighting | [Instalação com Oh My Zsh](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh) |
| nvm | [github.com/nvm-sh/nvm#installing-and-updating](https://github.com/nvm-sh/nvm#installing-and-updating) |
| Chave SSH no GitHub | [docs.github.com/pt/authentication/connecting-to-github-with-ssh](https://docs.github.com/pt/authentication/connecting-to-github-with-ssh) |

**3. Clonar e criar os links simbólicos**

```bash
git clone git@github.com:th1agopaes/dotfiles.git ~/dev/dotfiles

mkdir -p ~/.config/git ~/.claude
ln -sf  ~/dev/dotfiles/zsh/.zshrc           ~/.zshrc
ln -sf  ~/dev/dotfiles/zsh/.p10k.zsh        ~/.p10k.zsh
ln -sf  ~/dev/dotfiles/git/.gitconfig       ~/.gitconfig
ln -sf  ~/dev/dotfiles/git/allowed_signers  ~/.config/git/allowed_signers
ln -sfn ~/dev/dotfiles/fastfetch            ~/.config/fastfetch
ln -sf  ~/dev/dotfiles/claude/CLAUDE.md     ~/.claude/CLAUDE.md

chsh -s "$(which zsh)"   # define o Zsh como shell padrão
```

> ⚠️ O `ln -sf` **substitui** arquivos existentes. Em uma máquina nova, faça backup antes. Se `~/.config/fastfetch` já existir como pasta comum, mova-a para outro lugar antes de criar o link.

**4. Lado Windows**

Pré-requisitos: [PowerShell 7](https://learn.microsoft.com/pt-br/powershell/scripting/install/installing-powershell-on-windows) (`winget install --id Microsoft.PowerShell --source winget`) e a fonte [MesloLGS NF](https://github.com/romkatv/powerlevel10k#fonts).

```bash
WT_DIR=/mnt/c/Users/kajik/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState
PS_DIR=/mnt/c/Users/kajik/Documents/PowerShell

cp ~/dev/dotfiles/windows/terminal/settings.json "$WT_DIR/"
mkdir -p "$PS_DIR"
cp ~/dev/dotfiles/windows/powershell/Microsoft.PowerShell_profile.ps1 "$PS_DIR/"
```

> 🛡️ Se a **proteção contra ransomware** (Acesso controlado a pastas) bloquear o perfil do PowerShell, libere o `pwsh.exe` em *Segurança do Windows → Proteção contra ransomware*, sem desativar a proteção.

> 🔄 **Manutenção:** essas configurações vivem no Windows (os apps as reescrevem). Depois de mudar algo, rode `./scripts/exportar-windows.sh`, revise com `git diff` e faça o commit.

---

## 💾 Backup e restauração

Seguindo a **regra 3-2-1** (3 cópias, 2 mídias, 1 fora de casa):

| Cópia | Onde | Conteúdo |
|---|---|---|
| 1 | SSD | Sistema em uso |
| 2 | SSD (`C:\backup\wsl`) | Ubuntu exportado e criptografado (`.7z`) |
| 3 | Google Drive | Mesmo `.7z`, fora de casa |
| — | GitHub | Todos os projetos de código |

> 🔐 O backup contém a chave SSH privada, por isso é sempre criptografado (AES-256) com senha guardada no Bitwarden.

<details>
<summary><b>📤 Fazer backup</b> (PowerShell, mensal)</summary>

```powershell
wsl --shutdown
$data = Get-Date -Format yyyy-MM-dd
$7z = "C:\Program Files\7-Zip\7z.exe"

wsl --export Ubuntu "C:\backup\wsl\ubuntu-$data.tar"
& $7z a -t7z -mx=1 -mhe=on -p "C:\backup\wsl\ubuntu-$data.7z" "C:\backup\wsl\ubuntu-$data.tar"
& $7z t "C:\backup\wsl\ubuntu-$data.7z"       # testar: deve terminar em "Everything is Ok"

Copy-Item "C:\backup\wsl\ubuntu-$data.7z" "G:\Meu Drive\Backups\"
Remove-Item "C:\backup\wsl\ubuntu-$data.tar"  # o .tar não é criptografado
```

> ℹ️ O aviso `pax format cannot archive sockets` é normal: sockets são arquivos temporários de programas em execução e não precisam de backup.

</details>

<details>
<summary><b>📥 Restaurar</b> (PowerShell)</summary>

```powershell
$7z = "C:\Program Files\7-Zip\7z.exe"
& $7z x "C:\backup\wsl\ubuntu-AAAA-MM-DD.7z" -o"C:\backup\wsl"

# Importa como uma distro nova (não mexe na atual)
wsl --import Ubuntu-Restaurado "C:\WSL\Ubuntu-Restaurado" "C:\backup\wsl\ubuntu-AAAA-MM-DD.tar"
wsl -d Ubuntu-Restaurado
```

> O usuário padrão (`kajik`) volta automaticamente, pois está definido no `/etc/wsl.conf` dentro do backup.
> Documentação: [Importar e exportar distribuições](https://learn.microsoft.com/pt-br/windows/wsl/basic-commands#import-and-export-a-distribution)

</details>

---

## 🗺️ Roadmap de configuração

Cada fase só é marcada como concluída quando todos os itens dela estiverem feitos.

### ✅ Fase 0 · Diagnóstico
- [x] Levantar o estado atual do WSL (SO, shell, ferramentas, Git)
- [x] Listar os apps instalados no Windows e atualizá-los (`winget upgrade --all`)
- [x] Limpar arquivos perdidos na home

### ✅ Fase 1 · Fundação
- [x] Estrutura de pastas em `~/dev` (`estudos/`, `faculdade/`, `projetos/`, `sandbox/`)
- [x] Repositório de dotfiles com links simbólicos
- [x] `.gitignore` protegendo credenciais
- [x] `README` e `LICENSE`
- [x] Auditar segredos e tornar o repositório público

### ✅ Fase 2 · Segurança
- [x] Gerenciador de senhas (Bitwarden)
- [x] 2FA nas contas principais
- [x] Chave SSH configurada no GitHub
- [x] Commits assinados (selo *Verified*)
- [x] Atualizações automáticas (Windows Update e `unattended-upgrades` no Ubuntu)
- [x] Remover restos do Docker Desktop (grupo `docker`, `/Docker`, `~/.docker`)
- [x] Backup criptografado do WSL (SSD + Google Drive) com restauração documentada

### ✅ Fase 3 · Terminal
- [x] Windows Terminal configurado (pasta inicial, perfil padrão, fonte e tema compartilhados em `defaults`)
- [x] PowerShell 7 com UTF-8 (acentos corretos)
- [x] Permissões de arquivos vindos do Windows: função `trazer` (`install -m 644`)
- [x] Revisar `.zshrc` (`TERM_PROGRAM` condicional, configuração morta removida)
- [x] Ferramentas modernas: `eza`, `zoxide`, `fzf`, `bat`, `fd`, `fastfetch`, `keychain`
- [x] Configurações do Windows versionadas (`scripts/exportar-windows.sh`)

> ⚖️ **Decisão:** o WSL foi mantido com as permissões padrão em `/mnt/c`. Forçar `644` via `fmask` no `wsl.conf` tiraria a permissão de execução dos `.exe` do Windows, quebrando comandos como `code` e `explorer.exe` dentro do Ubuntu.

### Fase 4 · Editores
- [ ] VS Code com perfis por linguagem
- [ ] IDEs JetBrains (IntelliJ, PyCharm) gerenciadas pelo Toolbox
- [ ] Sincronização de configurações

### Fase 5 · Stack de mercado
- [ ] Definir 1–2 ferramentas por área (tabela abaixo)
- [ ] Instalar e testar cada uma
- [ ] Registrar documentação oficial
- [ ] Trocar o `nvm` por um gerenciador de versões mais rápido (medido: o `nvm` ocupa ~0,40 s dos 0,63 s de abertura do Zsh)

### Fase 6 · Manutenção
- [ ] Rotina mensal de atualização e limpeza
- [ ] Backup mensal do WSL
- [ ] Cópia extra do backup em pendrive

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
| PowerShell | [learn.microsoft.com/pt-br/powershell](https://learn.microsoft.com/pt-br/powershell/) |
| Catppuccin (tema) | [github.com/catppuccin/windows-terminal](https://github.com/catppuccin/windows-terminal) |
| Acesso controlado a pastas | [support.microsoft.com/help/4046851](https://support.microsoft.com/help/4046851) |
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
| fzf | [github.com/junegunn/fzf](https://github.com/junegunn/fzf) |
| bat | [github.com/sharkdp/bat](https://github.com/sharkdp/bat) |
| fd | [github.com/sharkdp/fd](https://github.com/sharkdp/fd) |
| tldr | [tldr.sh](https://tldr.sh/) |
| keychain | [github.com/danielrobbins/keychain](https://github.com/danielrobbins/keychain) |
| nvm | [github.com/nvm-sh/nvm](https://github.com/nvm-sh/nvm) |
| fastfetch | [github.com/fastfetch-cli/fastfetch](https://github.com/fastfetch-cli/fastfetch) |
| VS Code | [code.visualstudio.com/docs](https://code.visualstudio.com/docs) |
| JetBrains Toolbox | [jetbrains.com/toolbox-app](https://www.jetbrains.com/toolbox-app/) |
| Podman | [docs.podman.io](https://docs.podman.io/) |
| Comandos do WSL (export/import) | [learn.microsoft.com/pt-br/windows/wsl/basic-commands](https://learn.microsoft.com/pt-br/windows/wsl/basic-commands) |
| Gitleaks | [github.com/gitleaks/gitleaks](https://github.com/gitleaks/gitleaks) |
| Bitwarden | [bitwarden.com/help](https://bitwarden.com/help/) |
| 7-Zip | [7-zip.org](https://www.7-zip.org/) |
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
- ✅ Auditoria de segredos com [Gitleaks](https://github.com/gitleaks/gitleaks) antes de tornar um repositório público

---

## 👤 Autor

**Thiago Paes (Haru)** · Estudante de Engenharia da Computação · IFMT

[![GitHub](https://img.shields.io/badge/GitHub-th1agopaes-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/th1agopaes)

---

<div align="center">

📄 Licença [MIT](LICENSE)

</div>
