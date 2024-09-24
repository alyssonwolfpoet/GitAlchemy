@echo off
setlocal

rem Adiciona os próprios scripts ao .gitignore, se ainda não estiverem lá
call :add_scripts_to_gitignore

:main
echo.
echo Escolha uma operação:
echo 1. Configurar Git
echo 2. Commit
echo 3. Pull
echo 4. Fetch
echo 5. Push
echo 6. Listar branches
echo 7. Alterar branch
echo 8. Deletar branch
echo 9. Adicionar ao .gitignore
echo 10. Sair
set /p choice="Digite sua escolha: "

if "%choice%"=="1" (
    call :configure_git
) else if "%choice%"=="2" (
    call :commit_changes
) else if "%choice%"=="3" (
    call :pull_changes
) else if "%choice%"=="4" (
    call :fetch_changes
) else if "%choice%"=="5" (
    call :push_changes
) else if "%choice%"=="6" (
    call :list_branches
) else if "%choice%"=="7" (
    call :checkout_branch
) else if "%choice%"=="8" (
    call :delete_branch
) else if "%choice%"=="9" (
    call :add_to_gitignore
) else if "%choice%"=="10" (
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

:pull_changes
git pull
exit /b

:fetch_changes
git fetch
exit /b

:push_changes
git push
exit /b

:list_branches
git branch
exit /b

:checkout_branch
set /p branch_name="Digite o nome da branch para mudar: "
git checkout %branch_name%
exit /b

:delete_branch
set /p branch_name="Digite o nome da branch a ser deletada: "
git branch -d %branch_name%
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
