# Script PowerShell para criar atalho na área de trabalho

# Obter o caminho completo do script iniciar-sistema.bat
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$targetPath = Join-Path -Path $scriptDir -ChildPath "iniciar-sistema.bat"

# Obter o caminho da área de trabalho usando o objeto Shell
$shell = New-Object -ComObject WScript.Shell
$desktopPath = $shell.SpecialFolders.Item("Desktop")

# Caminho completo para o atalho
$shortcutPath = Join-Path -Path $desktopPath -ChildPath "Sistema de Estoque.lnk"

Write-Host "Criando atalho para o Sistema de Estoque..."
Write-Host "Caminho do script: $targetPath"
Write-Host "Caminho da área de trabalho: $desktopPath"
Write-Host "Caminho do atalho: $shortcutPath"

try {
    # Criar o objeto de atalho
    $shortcut = $shell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $targetPath
    $shortcut.WorkingDirectory = $scriptDir
    $shortcut.Description = "Sistema de Estoque"
    $shortcut.IconLocation = "$env:SystemRoot\System32\SHELL32.dll,22"
    $shortcut.Save()
    
    if (Test-Path $shortcutPath) {
        Write-Host "Atalho criado com sucesso!" -ForegroundColor Green
    } else {
        Write-Host "Erro: O atalho não foi criado!" -ForegroundColor Red
    }
} catch {
    Write-Host "Erro ao criar o atalho: $_" -ForegroundColor Red
}

# Verificar se o atalho foi criado
if (Test-Path $shortcutPath) {
    Write-Host "\nInformações do atalho:" -ForegroundColor Cyan
    $verifyShortcut = $shell.CreateShortcut($shortcutPath)
    Write-Host "  Destino: $($verifyShortcut.TargetPath)"
    Write-Host "  Diretório de trabalho: $($verifyShortcut.WorkingDirectory)"
    Write-Host "  Descrição: $($verifyShortcut.Description)"
}

Write-Host "\nPressione qualquer tecla para continuar..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")