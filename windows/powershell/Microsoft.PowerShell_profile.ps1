# Usa UTF-8 em tudo: acentos corretos no terminal, em pipes e em arquivos
$OutputEncoding = [Console]::InputEncoding = [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

# Atualiza os apps do Windows (winget) e o WSL
function Update-Tudo {
    winget upgrade --all --accept-source-agreements --accept-package-agreements
    wsl --update
}

# Backup mensal do Ubuntu: exporta, criptografa, testa e envia ao Google Drive
function Backup-Wsl {
    $data   = Get-Date -Format yyyy-MM-dd
    $pasta  = "C:\backup\wsl"
    $nuvem  = "G:\Meu Drive\Backups"
    $tar    = "$pasta\ubuntu-$data.tar"
    $arq    = "$pasta\ubuntu-$data.7z"
    $zip    = "C:\Program Files\7-Zip\7z.exe"
    $manter = 3   # quantos backups antigos guardar

    wsl --shutdown
    wsl --export Ubuntu $tar
    if ($LASTEXITCODE -ne 0) { Write-Host "✖ Falha ao exportar o Ubuntu" -ForegroundColor Red; return }

    & $zip a -t7z -mx=1 -mhe=on -p $arq $tar
    & $zip t $arq
    if ($LASTEXITCODE -ne 0) { Write-Host "✖ O teste falhou: nada foi enviado. Confira $arq" -ForegroundColor Red; return }

    Copy-Item $arq $nuvem
    Remove-Item $tar

    # Retenção: mantém só os $manter backups mais recentes (local e nuvem)
    foreach ($dir in $pasta, $nuvem) {
        Get-ChildItem "$dir\ubuntu-*.7z" | Sort-Object Name -Descending |
            Select-Object -Skip $manter | Remove-Item
    }
    Write-Host "✔ Backup concluído e enviado ao Drive: $arq" -ForegroundColor Green
}
