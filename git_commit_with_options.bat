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
echo 6. Rebase
echo 7. Listar branches
echo 8. Alterar branch
echo 9. Deletar branch
echo 10. Adicionar ao .gitignore
echo 11. Sair
set /p choice="Digite sua escolha: "

rem Verifica qual opção o usuário escolheu e chama a função correspondente
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
    call :rebase_changes
) else if "%choice%"=="7" (
    call :list_branches
) else if "%choice%"=="8" (
    call :checkout_branch
) else if "%choice%"=="9" (
    call :delete_branch
) else if "%choice%"=="10" (
    call :add_to_gitignore
) else if "%choice%"=="11" (
    echo Saindo...
    exit /b 0
) else (
    echo Opção inválida. Tente novamente.
    goto main
)

goto main

:add_scripts_to_gitignore
rem Adiciona os scripts ao .gitignore, se não estiverem lá
set script_files=git_commit_with_options.bat git_commit_with_options.ps1 git_commit_with_options.sh
for %%s in (%script_files%) do (
    findstr /x /c:"%%s" .gitignore >nul || (
        echo %%s >> .gitignore
        echo %%s adicionado ao .gitignore
    )
)
exit /b

:configure_git
rem Configura as informações do usuário no Git
set /p git_name="Digite seu nome: "
git config --global user.name "%git_name%"
set /p git_email="Digite seu e-mail: "
git config --global user.email "%git_email%"
echo Configurações do Git atualizadas:
git config --list
exit /b

:commit_changes
rem Realiza um commit das mudanças
echo Arquivos no diretório:
git status -s
set commit_types=feat fix docs style refactor test chore
echo Tipos de commit: 
echo - feat: Uma nova funcionalidade
echo - fix: Correção de um bug
echo - docs: Mudanças na documentação
echo - style: Mudanças que não afetam o significado do código (espaçamento, formatação, etc.)
echo - refactor: Mudanças de código que não corrigem um bug nem adicionam uma funcionalidade
echo - test: Adicionando testes ou corrigindo testes existentes
echo - chore: Atualizações para tarefas de manutenção
set /p type_choice="Digite o tipo de commit: "
set /p description="Digite a descrição do commit: "
set commit_message=%type_choice%: %description%

git add .
git commit -m "%commit_message%"
echo Commit realizado com sucesso: %commit_message%
exit /b

:pull_changes
rem Puxa as mudanças do repositório remoto
git pull
exit /b

:fetch_changes
rem Busca as mudanças do repositório remoto sem mesclá-las
git fetch
exit /b

:push_changes
rem Envia as mudanças locais para o repositório remoto
git push
exit /b

:rebase_changes
rem Realiza rebase da branch atual na branch especificada
echo "Escolha a branch para rebase:"
git branch
set /p branch_name="Digite o nome da branch: "
git rebase %branch_name%
if errorlevel 1 (
    echo "Conflitos encontrados durante o rebase."
    echo "Resolva os conflitos e, em seguida, execute 'git rebase --continue' para continuar."
)
exit /b

:list_branches
rem Lista as branches disponíveis
echo "Branches disponíveis:"
git branch -v
exit /b

:checkout_branch
rem Altera para a branch especificada pelo usuário
set /p branch_name="Digite o nome da branch para mudar: "
git checkout %branch_name%
exit /b

:delete_branch
rem Deleta a branch especificada pelo usuário
set /p branch_name="Digite o nome da branch a ser deletada: "
git branch -d %branch_name%
exit /b

:add_to_gitignore
rem Adiciona um arquivo ou diretório ao .gitignore
set /p ignore_entry="Digite o arquivo ou diretório a ser adicionado ao .gitignore: "
findstr /x /c:"%ignore_entry%" .gitignore >nul
if errorlevel 1 (
    echo %ignore_entry% >> .gitignore
    echo %ignore_entry% adicionado ao .gitignore
) else (
    echo %ignore_entry% já está no .gitignore
)
exit /b
