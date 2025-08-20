# Script para encontrar o caminho correto da área de trabalho

# Método 1: Usando a API do Windows
Write-Host "Método 1: Usando a API do Windows" -ForegroundColor Cyan
try {
    $shell = New-Object -ComObject WScript.Shell
    $desktopPath1 = $shell.SpecialFolders.Item("Desktop")
    Write-Host "Caminho da Área de Trabalho (WScript.Shell): $desktopPath1" -ForegroundColor Green
    
    if (Test-Path $desktopPath1) {
        Write-Host "O diretório existe!" -ForegroundColor Green
    } else {
        Write-Host "O diretório não existe!" -ForegroundColor Red
    }
} catch {
    Write-Host "Erro ao obter o caminho usando WScript.Shell: $_" -ForegroundColor Red
}

# Método 2: Usando a variável de ambiente
Write-Host "\nMétodo 2: Usando a variável de ambiente" -ForegroundColor Cyan
$desktopPath2 = [Environment]::GetFolderPath("Desktop")
Write-Host "Caminho da Área de Trabalho (Environment): $desktopPath2" -ForegroundColor Green

if (Test-Path $desktopPath2) {
    Write-Host "O diretório existe!" -ForegroundColor Green
} else {
    Write-Host "O diretório não existe!" -ForegroundColor Red
}

# Método 3: Usando o perfil do usuário
Write-Host "\nMétodo 3: Usando o perfil do usuário" -ForegroundColor Cyan
$desktopPath3 = "$env:USERPROFILE\Desktop"
Write-Host "Caminho da Área de Trabalho (USERPROFILE): $desktopPath3" -ForegroundColor Green

if (Test-Path $desktopPath3) {
    Write-Host "O diretório existe!" -ForegroundColor Green
} else {
    Write-Host "O diretório não existe!" -ForegroundColor Red
}

# Método 4: Usando OneDrive (comum em instalações recentes do Windows)
Write-Host "\nMétodo 4: Verificando OneDrive" -ForegroundColor Cyan
$oneDriveDesktop = "$env:USERPROFILE\OneDrive\Desktop"
Write-Host "Caminho da Área de Trabalho (OneDrive): $oneDriveDesktop" -ForegroundColor Green

if (Test-Path $oneDriveDesktop) {
    Write-Host "O diretório existe!" -ForegroundColor Green
} else {
    Write-Host "O diretório não existe!" -ForegroundColor Red
}

# Método 5: Usando a API do Shell para obter o CSIDL_DESKTOP
Write-Host "\nMétodo 5: Usando a API do Shell para CSIDL_DESKTOP" -ForegroundColor Cyan
try {
    Add-Type -AssemblyName System.Windows.Forms
    $desktopPath5 = [System.Windows.Forms.SystemInformation]::PowerStatus
    $desktopPath5 = [System.Windows.Forms.Application]::UserAppDataPath
    $desktopPath5 = [System.Windows.Forms.Application]::CommonAppDataPath
    $desktopPath5 = [System.Windows.Forms.Application]::LocalUserAppDataPath
    Write-Host "Informações do sistema:" -ForegroundColor Green
    Write-Host "  UserAppDataPath: $([System.Windows.Forms.Application]::UserAppDataPath)"
    Write-Host "  CommonAppDataPath: $([System.Windows.Forms.Application]::CommonAppDataPath)"
    Write-Host "  LocalUserAppDataPath: $([System.Windows.Forms.Application]::LocalUserAppDataPath)"
} catch {
    Write-Host "Erro ao obter informações do sistema: $_" -ForegroundColor Red
}

# Listar todos os drives disponíveis
Write-Host "\nDrives disponíveis:" -ForegroundColor Cyan
Get-PSDrive | Where-Object { $_.Provider.Name -eq "FileSystem" } | ForEach-Object {
    Write-Host "  $($_.Name): $($_.Root)"
}

Write-Host "\nPressione qualquer tecla para continuar..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")