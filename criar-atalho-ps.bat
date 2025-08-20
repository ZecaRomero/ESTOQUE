@echo off
echo Criando atalho para o Sistema de Estoque na Area de Trabalho...

set "SCRIPT_PATH=%~dp0iniciar-sistema.bat"
set "SHORTCUT_PATH=%USERPROFILE%\Desktop\Sistema de Estoque.lnk"

powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%SHORTCUT_PATH%'); $Shortcut.TargetPath = '%SCRIPT_PATH%'; $Shortcut.WorkingDirectory = '%~dp0'; $Shortcut.Description = 'Sistema de Estoque'; $Shortcut.IconLocation = '%SystemRoot%\System32\SHELL32.dll,22'; $Shortcut.Save(); Write-Host 'Atalho criado com sucesso em %SHORTCUT_PATH%'"

if exist "%SHORTCUT_PATH%" (
    echo.
    echo Atalho criado com sucesso! Verifique sua Area de Trabalho.
    echo Caminho do atalho: %SHORTCUT_PATH%
) else (
    echo.
    echo Erro ao criar o atalho. Verifique as permissoes.
)

echo.
pause