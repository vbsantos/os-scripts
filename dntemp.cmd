@echo off
setlocal EnableExtensions

REM Definindo a página de código para UTF-8 para suportar caracteres Unicode
chcp 65001 >nul

REM Obter data e hora atual
set "HOUR=%TIME:~0,2%"
set "HOUR=%HOUR: =0%"
set "MINSEC=%TIME:~3,2%%TIME:~6,2%"

REM Definindo o nome do projeto com base no argumento, ou usando um padrão com data e hora
set "PROJECT_NAME=%~1"
if "%PROJECT_NAME%"=="" set "PROJECT_NAME=Vini.Example.Project%HOUR%%MINSEC%"

REM Criando e entrando no diretório temporário
set "TEMPDIR=%TEMP%\%PROJECT_NAME%"
echo Criando diretório temporário: %TEMPDIR%
mkdir %TEMPDIR%
cd %TEMPDIR%

REM Criando o projeto .NET Console
echo Criando projeto .NET Console chamado: %PROJECT_NAME%
dotnet new console -o %TEMPDIR%

REM Abrindo o diretório no Visual Studio Code
echo Abrindo o diretório no Visual Studio Code
code %TEMPDIR%

echo Operação concluída. Diretório do projeto: %TEMPDIR%
endlocal
