@echo off
echo Iniciando o Sistema de Estoque de Semen Bovino...
echo.
echo Frontend: http://localhost:3005
echo Backend: http://localhost:4005
echo.
echo Aguarde alguns segundos para o sistema inicializar...
cd %~dp0
npm run dev
pause