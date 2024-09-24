@echo off
setlocal

rem Adiciona os próprios scripts ao .gitignore, se ainda não estiverem lá
call :add_scripts_to_gitignore

:main
echo.
echo Escolha uma operação:
echo 1. Configurar Git
echo 2. Commit
echo 3. Adicionar ao .gitignore
echo 4. Sair
set /p choice="Digite sua escolha: "

if "%choice%"=="1" (
    call :configure_git
) else if "%choice%"=="2" (
    call :commit_changes
) else if "%choice%"=="3" (
    call :add_to_gitignore
) else if "%choice%"=="4" (
    echo Saindo...
    exit /b 0
) else (
    echo Opção inválida. Tente novamente.
    goto main
)

goto main

:add_scripts_to_gitignore
set script_files=git_commit_with_options.bat git_commit_with_options.ps1 git_commit_with_options.sh
for %%s in (%script_files%) do (
    findstr /x /c:"%%s" .gitignore >nul || (
        echo %%s >> .gitignore
        echo %%s adicionado ao .gitignore
    )
)
exit /b

:configure_git
set /p git_name="Digite seu nome: "
git config --global user.name "%git_name%"
set /p git_email="Digite seu e-mail: "
git config --global user.email "%git_email%"
echo Configurações do Git atualizadas:
git config --list
exit /b

:commit_changes
echo Arquivos no diretório:
git status -s
set commit_types=feat fix docs style refactor test chore
echo Tipos de commit: %commit_types%
set /p type_choice="Digite o tipo de commit: "
set /p description="Digite a descrição do commit: "
set commit_message=%type_choice%: %description%

git add .
git commit -m "%commit_message%"
echo Commit realizado com sucesso: %commit_message%
exit /b

:add_to_gitignore
set /p ignore_entry="Digite o arquivo ou diretório a ser adicionado ao .gitignore: "
findstr /x /c:"%ignore_entry%" .gitignore >nul
if errorlevel 1 (
    echo %ignore_entry% >> .gitignore
    echo %ignore_entry% adicionado ao .gitignore
) else (
    echo %ignore_entry% já está no .gitignore
)
exit /b
