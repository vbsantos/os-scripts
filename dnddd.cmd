@echo off

:: Verifica se um argumento foi passado (nome do projeto)
:: Se não, solicita ao usuário que insira um nome
if "%1"=="" (
  SET /p projectName="Enter the project name: "
) else (
  SET projectName=%1
)

:: Usando PowerShell para exibir texto em cinza
PowerShell -Command "& {Write-Host 'Creating DDD project structure for %projectName%...' -ForegroundColor Yellow}"

:: Cria a pasta raiz do projeto
mkdir %projectName%
cd %projectName%

:: Cria a solução do projeto
PowerShell -Command "& {Write-Host 'Creating Solution...' -ForegroundColor Yellow}"
dotnet new sln -n %projectName%

:: Cria a camada de Domínio (Domain Layer)
PowerShell -Command "& {Write-Host 'Creating Domain Layer...' -ForegroundColor Yellow}"
dotnet new classlib -n %projectName%.Domain
dotnet sln add %projectName%.Domain

:: Cria a camada de Aplicação (Application Layer)
PowerShell -Command "& {Write-Host 'Creating Application Layer...' -ForegroundColor Yellow}"
dotnet new classlib -n %projectName%.Application
dotnet sln add %projectName%.Application

:: Adiciona a referência ao projeto de Domínio na camada de Aplicação
dotnet add %projectName%.Application reference %projectName%.Domain

:: Cria a camada de Infraestrutura (Infrastructure Layer)
PowerShell -Command "& {Write-Host 'Creating Infrastructure Layer...' -ForegroundColor Yellow}"
dotnet new classlib -n %projectName%.Infrastructure
dotnet sln add %projectName%.Infrastructure

:: Adiciona referências aos projetos de Domínio e Aplicação na camada de Infraestrutura
dotnet add %projectName%.Infrastructure reference %projectName%.Domain
dotnet add %projectName%.Infrastructure reference %projectName%.Application

:: Cria a camada de API (API Layer)
PowerShell -Command "& {Write-Host 'Creating API Layer...' -ForegroundColor Yellow}"
dotnet new webapi -n %projectName%.API
dotnet sln add %projectName%.API

:: Adiciona referências aos projetos de Aplicação e Infraestrutura na camada de API
dotnet add %projectName%.API reference %projectName%.Application
dotnet add %projectName%.API reference %projectName%.Infrastructure

:: Cria arquivos extras da solução
dotnet new globaljson
dotnet new editorconfig

:: Cria arquivos referentes ao git
dotnet new gitignore
git init
git add .
git commit -m "First Commit"

:: Exibe uma mensagem final de sucesso
PowerShell -Command "& {Write-Host 'DDD project structure created successfully.' -ForegroundColor Green}"

:: Retorna ao diretório anterior
code .
