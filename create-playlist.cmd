@echo off
chcp 65001
setlocal EnableDelayedExpansion

:: Define o diretório atual como o diretório raiz.
set "ROOT_DIR=."

:: Verifica se um nome de arquivo foi fornecido como argumento.
if "%~1"=="" (
    echo Por favor, forneça um nome para o arquivo da playlist.
    echo Uso: %~nx0 nome_da_playlist.m3u
    exit /b
)

:: Define o nome do arquivo da playlist com base no argumento fornecido.
set "PLAYLIST=%ROOT_DIR%%~1.m3u"

:: Remove o arquivo da playlist se ele já existir.
if exist "%PLAYLIST%" del "%PLAYLIST%"

:: Procura por arquivos MP4 e verifica a permissão antes de adicionar ao arquivo da playlist.
for /r "%ROOT_DIR%" %%a in (*.mp4) do (
    icacls "%%a" | findstr "(M)" >nul
    if !errorlevel! equ 0 (
        echo %%a >> "%PLAYLIST%"
    ) else (
        echo Permissao negada: %%a
    )
)

echo Playlist gerada com sucesso: %PLAYLIST%
