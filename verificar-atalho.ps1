# Script para verificar se o atalho foi criado
$shortcutPath = "$env:USERPROFILE\Desktop\Sistema de Estoque.lnk"

Write-Host "Verificando atalho em: $shortcutPath"

if (Test-Path $shortcutPath) {
    Write-Host "Atalho encontrado!" -ForegroundColor Green
    
    # Obter informações do atalho
    $shell = New-Object -ComObject WScript.Shell
    $shortcut = $shell.CreateShortcut($shortcutPath)
    
    Write-Host "Informações do atalho:" -ForegroundColor Cyan
    Write-Host "  Caminho do atalho: $shortcutPath"
    Write-Host "  Destino: $($shortcut.TargetPath)"
    Write-Host "  Diretório de trabalho: $($shortcut.WorkingDirectory)"
    Write-Host "  Descrição: $($shortcut.Description)"
} else {
    Write-Host "Atalho não encontrado!" -ForegroundColor Red
    
    # Verificar se o diretório Desktop existe
    $desktopPath = "$env:USERPROFILE\Desktop"
    if (Test-Path $desktopPath) {
        Write-Host "O diretório da Área de Trabalho existe: $desktopPath"
        
        # Listar arquivos na área de trabalho
        Write-Host "Arquivos na Área de Trabalho:" -ForegroundColor Yellow
        Get-ChildItem -Path $desktopPath -File | ForEach-Object {
            Write-Host "  $($_.Name)"
        }
    } else {
        Write-Host "O diretório da Área de Trabalho não foi encontrado: $desktopPath" -ForegroundColor Red
    }
}

Write-Host "\nPressione qualquer tecla para continuar..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")