@echo on
echo Criando atalho para o Sistema de Estoque na Area de Trabalho (OneDrive)...

set "SCRIPT_PATH=%~dp0iniciar-sistema.bat"
set "SHORTCUT_PATH=%USERPROFILE%\OneDrive\Desktop\Sistema de Estoque.lnk"

echo Caminho do script: %SCRIPT_PATH%
echo Caminho do atalho: %SHORTCUT_PATH%

:: Criar arquivo VBS temporário
set "VBS_FILE=%TEMP%\create_shortcut.vbs"

echo Creating VBS file: %VBS_FILE%

:: Escrever o conteúdo do arquivo VBS
echo Set oWS = WScript.CreateObject("WScript.Shell") > "%VBS_FILE%"
echo sLinkFile = "%SHORTCUT_PATH%" >> "%VBS_FILE%"
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%VBS_FILE%"
echo oLink.TargetPath = "%SCRIPT_PATH%" >> "%VBS_FILE%"
echo oLink.WorkingDirectory = "%~dp0" >> "%VBS_FILE%"
echo oLink.Description = "Sistema de Estoque" >> "%VBS_FILE%"
echo oLink.IconLocation = "%SystemRoot%\System32\SHELL32.dll,22" >> "%VBS_FILE%"
echo oLink.Save >> "%VBS_FILE%"
echo WScript.Echo "Atalho criado com sucesso em " ^& sLinkFile >> "%VBS_FILE%"

:: Executar o arquivo VBS
echo Executando VBS...
cscript //nologo "%VBS_FILE%"

:: Verificar se o atalho foi criado
if exist "%SHORTCUT_PATH%" (
    echo.
    echo Atalho criado com sucesso! Verifique sua Area de Trabalho.
    echo Caminho do atalho: %SHORTCUT_PATH%
) else (
    echo.
    echo Erro ao criar o atalho. Verifique as permissoes.
)

:: Limpar o arquivo VBS temporário
del "%VBS_FILE%"

echo.
pause