# Usa UTF-8 em tudo: acentos corretos no terminal, em pipes e em arquivos
$OutputEncoding = [Console]::InputEncoding = [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
