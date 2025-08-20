@echo on
echo Criando atalho para o Sistema de Estoque na Area de Trabalho...

set SCRIPT="%TEMP%\create_shortcut.vbs"
echo Criando script temporario em: %SCRIPT%

echo Set oWS = WScript.CreateObject("WScript.Shell") > %SCRIPT%
echo sLinkFile = oWS.SpecialFolders("Desktop") ^& "\Sistema de Estoque.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%~dp0iniciar-sistema.bat" >> %SCRIPT%
echo oLink.WorkingDirectory = "%~dp0" >> %SCRIPT%
echo oLink.Description = "Sistema de Estoque" >> %SCRIPT%
echo oLink.IconLocation = "%SystemRoot%\System32\SHELL32.dll,22" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
echo WScript.Echo "Atalho criado com sucesso em " ^& sLinkFile >> %SCRIPT%

echo Executando script VBS...
cscript /nologo %SCRIPT%
echo Removendo script temporario...
del %SCRIPT%

echo.
echo Atalho criado com sucesso! Verifique sua Area de Trabalho.
echo.
pause