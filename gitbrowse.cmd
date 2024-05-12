@echo off
setlocal EnableExtensions
setlocal enabledelayedexpansion

REM Definindo a página de código para UTF-8 para suportar caracteres Unicode
chcp 65001 >nul

REM Verifica se o diretório atual é um repositório Git
if not exist .git (
    echo Este não é um repositório Git.
    exit /b
) else (
    echo Diretório atual é um repositório Git.
)

REM Obtém a URL do repositório remoto
for /f "delims=" %%i in ('git config --get remote.origin.url') do set "repoURL=%%i"

REM Verifica se uma URL foi encontrada
if "%repoURL%" == "" (
    echo URL do repositório remoto não encontrada.
    exit /b
) else (
    echo URL do repositório remoto encontrada: %repoURL%
)

REM Transforma a URL do git para uma URL acessível via navegador
if not "!repoURL!"=="!repoURL:github=!" (
    set "provider=GitHub"
    set "webURL=!repoURL:.git=!"
    if "!repoURL!"=="!repoURL:https=!" (
        set "webURL=!webURL:git@github.com:=!"
        set "webURL=https://github.com/!webURL!"
    )
) else if not "!repoURL!"=="!repoURL:gitlab=!" (
    set "provider=GitLab"
    set "webURL=!repoURL:.git=!"
    if "!repoURL!"=="!repoURL:https=!" (
        set "tempURL=!webURL:git@gitlab.com:=!"
        set "webURL=https://gitlab.com/!tempURL!"
    )
) else (
    set "provider=Unknown"
    set "webURL=!repoURL!"
)

REM Exibe informações sobre o provedor e a URL para acesso
echo Provedor detectado: %provider%
echo URL transformada para acesso via navegador: %webURL%

REM Abre a URL no navegador padrão
start "" "%webURL%"
