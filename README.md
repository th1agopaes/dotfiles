<div align="center">

# 🛠️ dotfiles

**Meu ambiente de desenvolvimento: configurações, ferramentas e documentação em um só lugar.**

![Windows 11](https://img.shields.io/badge/Windows_11-Home-0078D4?style=for-the-badge)
![WSL 2](https://img.shields.io/badge/WSL_2-Ubuntu_26.04_LTS-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![Zsh](https://img.shields.io/badge/Shell-Zsh_5.9-F15A24?style=for-the-badge&logo=zsh&logoColor=white)
![PowerShell](https://img.shields.io/badge/PowerShell-7-5391FE?style=for-the-badge)
![Git](https://img.shields.io/badge/Commits-Assinados_✔-F05032?style=for-the-badge&logo=git&logoColor=white)
![Status](https://img.shields.io/badge/status-ativo-brightgreen?style=for-the-badge)

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
- [Manutenção mensal](#-manutenção-mensal)
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
| **PowerShell** | PowerShell 7 com UTF-8 em tudo (acentos corretos em pipes e arquivos) e funções `Update-Tudo` e `Backup-Wsl` |
| **Shell** | Zsh com Oh My Zsh, tema Powerlevel10k e plugins `git`, `zsh-autosuggestions` e `zsh-syntax-highlighting` |
| **Navegação** | `eza` no lugar do `ls` (ícones e cores), `zoxide` para pular entre pastas por frequência de uso e `fzf` para busca interativa |
| **Arquivos** | `bat` (`cat` com cores) e `fd` (`find` mais rápido e simples) |
| **SSH** | `keychain` para carregar a chave SSH uma única vez por sessão |
| **Visual** | `fastfetch` com arte ASCII personalizada ao abrir o terminal |
| **Produtividade** | Funções `cheat` (consulta `tldr` → `man` → `--help`) e `trazer` (copia arquivos do Windows com permissão correta), além de aliases para pastas e tarefas comuns |
| **Runtimes** | [mise](https://mise.jdx.dev/) gerencia as versões (Node.js 26 LTS); Python via `uv`; Rust via `rustup`; Java 25 (OpenJDK) e GCC pelo `apt` |
| **Medição** | `hyperfine` para benchmarks confiáveis (abertura do Zsh: **~393 ms**) |
| **Git** | Commits e tags assinados com chave SSH, autenticação via GitHub CLI, autocorreção com confirmação e `.gitignore` global para arquivos de editores |
| **Editores** | VS Code com perfis por linguagem, tema Catppuccin Mocha e Settings Sync; IntelliJ IDEA e PyCharm gerenciados pelo JetBrains Toolbox com licença educacional |
| **IA** | Instruções pessoais para o Claude Code (`CLAUDE.md`) |

<details>
<summary><b>⌨️ Aliases e funções</b></summary>

| Comando | O que faz |
|---|---|
| `ls`, `ll`, `la`, `lt` | Listagens com `eza` (simples, detalhada com Git, ocultos e árvore) |
| `dev`, `est`, `proj`, `fac` | Vai direto para `~/dev`, estudos, projetos e o semestre atual |
| `atualizar` | Atualiza tudo no Ubuntu: pacotes, mise e suas ferramentas, Rust, uv, plugins e tema do Zsh |
| `zshconfig` / `recarregar` | Abre o `.zshrc` no VS Code / recarrega as configurações |
| `bat`, `fd` | Atalhos para `batcat` e `fdfind` (nomes dos pacotes no Ubuntu) |
| `waifu` | Mostra o `fastfetch` com a arte ASCII grande |
| `cheat <comando>` | Mostra exemplos rápidos de um comando |
| `trazer <arquivo>` | Copia arquivos do Windows para a pasta atual com permissão `644` (ex.: `trazer "$DL/foto.png"`) |
| `$DL` | Variável com a pasta Downloads do Windows |

</details>

<details>
<summary><b>🧩 Editores: quem faz o quê</b></summary>

| Editor | Uso |
|---|---|
| **VS Code** | Web (JS/React/Node), C, scripts e configurações |
| **IntelliJ IDEA** | Java |
| **PyCharm** | Python e Django |

**Perfis do VS Code** (cada pasta de projeto fica associada ao seu perfil):

| Perfil | Extensões próprias | Pastas |
|---|---|---|
| Padrão | Só a base | `~/dev`, dotfiles, scripts |
| Web | ESLint | `estudos/web`, `columbinamath` |
| C | C/C++ | Exercícios de C |
| Python | Python, Pylance, Ruff, Jupyter, Django, SQLite Viewer | `estudos/ia-python`, `columbinamath-django` |

**Base (todos os perfis):** Claude Code, WSL, Português (Brasil), vscode-icons, Catppuccin, Error Lens, EditorConfig, GitLens, Prettier, Container Tools e Discord Presence.

> Configurações, atalhos e snippets são compartilhados (vêm do perfil Padrão); cada perfil muda apenas as extensões.

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
├── git/                 # .gitconfig, allowed_signers e .gitignore_global
├── mise/                # config.toml (versões globais: Node...)
├── scripts/             # exportar-windows.sh
├── vscode/              # settings.json do VS Code
├── windows/             # Windows Terminal e perfil do PowerShell
└── zsh/                 # .zshrc e .p10k.zsh
```

---

## 🚀 Instalação

Os arquivos ficam no repositório e o sistema acessa cada um por **link simbólico** (um "atalho" que aponta para o arquivo real).

**1. Pacotes do Ubuntu**

```bash
sudo apt update
sudo apt install -y zsh git gh eza zoxide fzf bat fd-find tldr keychain fastfetch hyperfine podman podman-compose build-essential openjdk-25-jdk
```

**2. Instalações manuais** (seguir a documentação oficial de cada um)

| Ferramenta | Instalação |
|---|---|
| Oh My Zsh | [ohmyz.sh/#install](https://ohmyz.sh/#install) |
| Powerlevel10k | [github.com/romkatv/powerlevel10k#oh-my-zsh](https://github.com/romkatv/powerlevel10k#oh-my-zsh) |
| zsh-autosuggestions | [Instalação com Oh My Zsh](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh) |
| zsh-syntax-highlighting | [Instalação com Oh My Zsh](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh) |
| mise | `curl -fsSL https://mise.run \| sh` ([guia](https://mise.jdx.dev/getting-started)) |
| uv | [docs.astral.sh/uv/getting-started/installation](https://docs.astral.sh/uv/getting-started/installation/) |
| Rust | `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \| sh -s -- --no-modify-path` ([guia](https://rust-lang.org/tools/install)) |
| Chave SSH no GitHub | [docs.github.com/pt/authentication/connecting-to-github-with-ssh](https://docs.github.com/pt/authentication/connecting-to-github-with-ssh) |

**3. Clonar e criar os links simbólicos**

```bash
git clone git@github.com:th1agopaes/dotfiles.git ~/dev/dotfiles

mkdir -p ~/.config/git ~/.config/mise ~/.claude
ln -sf  ~/dev/dotfiles/zsh/.zshrc           ~/.zshrc
ln -sf  ~/dev/dotfiles/zsh/.p10k.zsh        ~/.p10k.zsh
ln -sf  ~/dev/dotfiles/git/.gitconfig       ~/.gitconfig
ln -sf  ~/dev/dotfiles/git/allowed_signers  ~/.config/git/allowed_signers
ln -sf  ~/dev/dotfiles/git/.gitignore_global ~/.gitignore_global
ln -sfn ~/dev/dotfiles/fastfetch            ~/.config/fastfetch
ln -sf  ~/dev/dotfiles/claude/CLAUDE.md     ~/.claude/CLAUDE.md
ln -sf  ~/dev/dotfiles/mise/config.toml     ~/.config/mise/config.toml

chsh -s "$(which zsh)"   # define o Zsh como shell padrão
mise install             # instala as versões listadas no config.toml (ex.: Node 26)
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

**5. Editores**

| Editor | Como restaurar |
|---|---|
| VS Code | Entrar com o GitHub em **Fazer Backup e Sincronizar Configurações** (com **Perfis** marcado): tema, configurações, perfis e extensões voltam sozinhos. Cópia versionada em `vscode/settings.json` |
| JetBrains | Instalar o [Toolbox](https://www.jetbrains.com/toolbox-app/), entrar com a conta da [licença educacional](https://www.jetbrains.com/community/education/#students) e instalar as IDEs por ele |

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

**📤 Fazer backup (mensal):** no PowerShell 7, rode `Backup-Wsl`. A função (definida em [`windows/powershell`](windows/powershell/Microsoft.PowerShell_profile.ps1)) exporta o Ubuntu, criptografa, **testa** o arquivo e só então envia ao Google Drive e apaga o `.tar` sem criptografia.

> ℹ️ O aviso `pax format cannot archive sockets` é normal: sockets são arquivos temporários de programas em execução e não precisam de backup.

<details>
<summary><b>📥 Restaurar</b> (PowerShell)</summary>

```powershell
$zip = "C:\Program Files\7-Zip\7z.exe"
& $zip x "C:\backup\wsl\ubuntu-AAAA-MM-DD.7z" -o"C:\backup\wsl"

# Importa como uma distro nova (não mexe na atual)
wsl --import Ubuntu-Restaurado "C:\WSL\Ubuntu-Restaurado" "C:\backup\wsl\ubuntu-AAAA-MM-DD.tar"
wsl -d Ubuntu-Restaurado
```

> O usuário padrão (`kajik`) volta automaticamente, pois está definido no `/etc/wsl.conf` dentro do backup.
> Documentação: [Importar e exportar distribuições](https://learn.microsoft.com/pt-br/windows/wsl/basic-commands#import-and-export-a-distribution)

</details>

---

## 🔧 Manutenção mensal

Uma vez por mês (~15 minutos), nesta ordem:

| # | Onde | Comando | O que faz |
|:-:|---|---|---|
| 1 | Ubuntu | `atualizar` | Pacotes do Ubuntu, mise e suas ferramentas, Rust, uv, plugins e tema do Zsh |
| 2 | PowerShell 7 | `Update-Tudo` | Apps do Windows (`winget`) e o próprio WSL |
| 3 | Ubuntu | `podman system prune` · `mise prune` | Limpa containers parados, imagens órfãs e versões antigas de ferramentas |
| 4 | Ubuntu | `./scripts/exportar-windows.sh` | Traz para o repositório as configs do Windows (revisar com `git diff` e commitar) |
| 5 | PowerShell 7 | `Backup-Wsl` | Backup criptografado e testado, com cópia no Google Drive |

> 💡 O passo 5 fecha o Ubuntu (`wsl --shutdown`), por isso fica por último.

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

### ✅ Fase 4 · Editores
- [x] VS Code com perfis por linguagem (Web, C, Python) e extensões base compartilhadas
- [x] Tema Catppuccin Mocha no VS Code, igual ao terminal
- [x] Formatadores por linguagem (Prettier, Ruff, C/C++) com formatação ao salvar
- [x] Settings Sync do VS Code com perfis (conta GitHub) + `settings.json` versionado
- [x] IDEs JetBrains (IntelliJ, PyCharm) gerenciadas pelo Toolbox, com licença educacional
- [x] Faxina: extensão Docker duplicada, diretórios antigos da JetBrains e `.idea` perdido
- [x] `.gitignore` global para arquivos pessoais de editores

### ✅ Fase 5 · Stack de mercado
- [x] Definir 1–2 ferramentas por área com base em dados ([Stack Overflow Survey 2026](https://survey.stackoverflow.co/2026/technology) e [GitHub Octoverse 2025](https://github.blog/news-insights/octoverse/))
- [x] Trocar o `nvm` pelo `mise` com Node.js 26 LTS (abertura do Zsh medida com `hyperfine`: ~393 ms)
- [x] Instalar Rust via `rustup` (sem alterar arquivos de configuração automaticamente)
- [x] Testar PostgreSQL 18 em container com Podman
- [x] `atualizar` passa a atualizar também o mise e suas ferramentas
- [x] Registrar documentação e tutorial oficial de cada ferramenta (tabela abaixo)

### ✅ Fase 6 · Manutenção
- [x] Rotina mensal documentada ([Manutenção mensal](#-manutenção-mensal))
- [x] `atualizar` cobre apt, mise, Rust, uv e plugins do Zsh
- [x] `Update-Tudo` (winget + WSL) e `Backup-Wsl` (backup testado) no PowerShell
- [ ] Lembrete mensal na agenda

### 🔜 Próximos passos
- [ ] Cópia extra do backup em pendrive (quando tiver um)
- [ ] Repositórios de estudo com README e publicados como portfólio
- [ ] Projetos práticos com a stack da Fase 5

---

## 🧰 Stack por área

Escolhas baseadas em dados de mercado ([Stack Overflow Survey 2026](https://survey.stackoverflow.co/2026/technology), [GitHub Octoverse 2025](https://github.blog/news-insights/octoverse/)), com no máximo duas ferramentas por área.

**Regra de instalação:** no sistema, só gerenciadores e runtimes; bibliotecas e frameworks entram **em cada projeto** (com arquivo de *lock*); bancos de dados rodam **em containers**.

| Legenda | Significado |
|---|---|
| ✅ | Instalado no sistema |
| 📦 | Instalado por projeto (`npm`, `uv`, `cargo`, Maven/Gradle) |
| 🐳 | Executado em container (Podman) |
| 🔜 | Instalar quando for usar |

| Área | Ferramenta | | Documentação | Tutorial oficial |
|---|---|:-:|---|---|
| Versões | mise | ✅ | [mise.jdx.dev](https://mise.jdx.dev/) | [Getting Started](https://mise.jdx.dev/getting-started) |
| Linguagens | TypeScript | 📦 | [typescriptlang.org/docs](https://www.typescriptlang.org/docs/) | [TS em 5 minutos](https://www.typescriptlang.org/docs/handbook/typescript-in-5-minutes.html) |
| Linguagens | Python + uv | ✅ | [docs.python.org/pt-br](https://docs.python.org/pt-br/3/) · [uv](https://docs.astral.sh/uv/) | [Tutorial Python](https://docs.python.org/pt-br/3/tutorial/) |
| Linguagens | Rust | ✅ | [rust-lang.org/learn](https://rust-lang.org/learn) | [The Rust Book](https://doc.rust-lang.org/book/) |
| Front-end | React | 📦 | [pt-br.react.dev](https://pt-br.react.dev/reference/react) | [Início rápido](https://pt-br.react.dev/learn) |
| Front-end | Vite | 📦 | [vite.dev](https://vite.dev/) | [Guia](https://vite.dev/guide/) |
| Back-end | Node.js + Express | ✅ 📦 | [nodejs.org/docs](https://nodejs.org/docs/latest/api/) · [expressjs.com/pt-br](https://expressjs.com/pt-br/) | [Learn Node.js](https://nodejs.org/en/learn) |
| Back-end | Spring Boot | 📦 | [docs.spring.io/spring-boot](https://docs.spring.io/spring-boot/) | [Spring Guides](https://spring.io/guides) |
| Banco de dados | PostgreSQL 18 | 🐳 | [postgresql.org/docs](https://www.postgresql.org/docs/) | [Tutorial oficial](https://www.postgresql.org/docs/current/tutorial.html) |
| Banco de dados | Redis | 🐳 | [redis.io/docs](https://redis.io/docs/) | [Redis Learn](https://redis.io/learn/) |
| Containers | Podman + Compose | ✅ | [docs.podman.io](https://docs.podman.io/) | [Tutoriais Podman](https://docs.podman.io/en/latest/Tutorials.html) |
| CI/CD | GitHub Actions | — | [docs.github.com/pt/actions](https://docs.github.com/pt/actions) | [GitHub Skills](https://skills.github.com/) |
| Cloud | AWS | 🔜 | [docs.aws.amazon.com](https://docs.aws.amazon.com/) | [Getting Started](https://aws.amazon.com/pt/getting-started/) |
| Cloud | Azure (créditos de estudante) | 🔜 | [learn.microsoft.com/pt-br/azure](https://learn.microsoft.com/pt-br/azure/) | [Azure for Students](https://azure.microsoft.com/pt-br/free/students) |
| IA / Dados | Jupyter + pandas | 📦 | [docs.jupyter.org](https://docs.jupyter.org/) · [pandas](https://pandas.pydata.org/docs/) | [Tutoriais pandas](https://pandas.pydata.org/docs/getting_started/intro_tutorials/) |
| IA / Dados | SDKs de LLM (Claude API) | 📦 | [docs.claude.com](https://docs.claude.com/) | [Anthropic Courses](https://github.com/anthropics/courses) |
| Testes | pytest (+ JUnit no Java) | 📦 | [docs.pytest.org](https://docs.pytest.org/) · [junit.org](https://junit.org/) | [Get Started](https://docs.pytest.org/en/stable/getting-started.html) |
| Testes | Vitest | 📦 | [vitest.dev](https://vitest.dev/) | [Guia](https://vitest.dev/guide/) |
| Jogos | Godot (GDScript/C#) | 🔜 | [docs.godotengine.org](https://docs.godotengine.org/pt-br/stable/) | [Primeiro jogo 2D](https://docs.godotengine.org/en/stable/getting_started/first_2d_game/) |
| Jogos | Unity | 🔜 | [docs.unity3d.com](https://docs.unity3d.com/) | [Unity Learn](https://learn.unity.com/) |

> ℹ️ O Podman exibe o aviso `"/" is not a shared mount` em containers *rootless* no WSL. Até agora não causou problemas (PostgreSQL testado com sucesso); fica registrado para investigar se algum volume não montar.

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
| mise | [mise.jdx.dev](https://mise.jdx.dev/) |
| rustup | [rust-lang.github.io/rustup](https://rust-lang.github.io/rustup/) |
| hyperfine | [github.com/sharkdp/hyperfine](https://github.com/sharkdp/hyperfine) |
| Node.js (calendário de versões) | [nodejs.org/about/previous-releases](https://nodejs.org/en/about/previous-releases) |
| fastfetch | [github.com/fastfetch-cli/fastfetch](https://github.com/fastfetch-cli/fastfetch) |
| VS Code | [code.visualstudio.com/docs](https://code.visualstudio.com/docs) |
| Perfis do VS Code | [code.visualstudio.com/docs/configure/profiles](https://code.visualstudio.com/docs/configure/profiles) |
| VS Code com WSL | [code.visualstudio.com/docs/remote/wsl](https://code.visualstudio.com/docs/remote/wsl) |
| Catppuccin (VS Code) | [github.com/catppuccin/vscode](https://github.com/catppuccin/vscode) |
| JetBrains Toolbox | [jetbrains.com/toolbox-app](https://www.jetbrains.com/toolbox-app/) |
| Licença educacional JetBrains | [jetbrains.com/community/education](https://www.jetbrains.com/community/education/#students) |
| Prettier | [prettier.io/docs](https://prettier.io/docs/) |
| Ruff | [docs.astral.sh/ruff](https://docs.astral.sh/ruff/) |
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
