# Inventário inicial do PC (E0) — 2026-10-27

## Windows
- Windows 11 Home 26H2 (build 26300.9711)
- PowerShell padrão: Windows PowerShell 5.1 (o 7 entra na E1)
- Discos: C: (único disco físico, ~1,8 TB, 682 GB usados) · G: = Google Drive (virtual, sincroniza com a nuvem)
- Apps: 154 entradas no `winget list` → `inventario-winget.txt`

## WSL
- WSL 3.0.3 · kernel 6.18.54.1-1 · WSLg 1.0.79
- Distro: `Ubuntu` (Ubuntu 26.04), WSL 2, padrão
- Disco da distro: 7,4 GB usados de 1007 GB (vhdx)
- Dotfiles: `~/dev/dotfiles` (symlinks, ex.: `~/.zshrc` → `zsh/.zshrc`)

## Rede de segurança
- Ponto de restauração nº 87 "E0 antes do setup-pc" (27/10/2026 18:40)
- Backup: `C:\backup\wsl\ubuntu-2026-10-27.tar` (6,6 GiB). Contém ~/.ssh: não vai para a nuvem.
  - ✅ Substituído na Fase 2 por backup **criptografado** (`.7z`, AES-256) com cópia no Google Drive; o `.tar` foi apagado.

## Observações (status em 30/10/2026)
- ✅ Windows Terminal abre em System32 e com o perfil Ubuntu como padrão → resolvido na Fase 3 (`startingDirectory` nos perfis)
- ✅ PowerShell 5.1 quebra acentos sem UTF-8 → resolvido na Fase 3 (PowerShell 7 + UTF-8 no `$PROFILE`)
- ✅ Atualizações pendentes: 7-Zip, Bitwarden, EA app → resolvido na Fase 0 (`winget upgrade --all`) e na rotina mensal (`Update-Tudo`)
- ✅ Pasta /Docker na raiz da distro + ~/.docker + grupo docker: resto do Docker Desktop → removido na Fase 2
- ✅ Arquivos copiados de /mnt/c chegam com modo 755 (sem metadata no DrvFs) → resolvido na Fase 3 com a função `trazer` (o `fmask` no `wsl.conf` foi descartado porque quebraria a execução dos `.exe`)
