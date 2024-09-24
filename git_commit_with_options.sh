#!/bin/bash

# Adiciona os próprios scripts ao .gitignore, se ainda não estiverem lá
add_scripts_to_gitignore() {
    script_files=("$0" "git_commit_with_options.bat" "git_commit_with_options.ps1")
    for script in "${script_files[@]}"; do
        if ! grep -Fxq "$script" .gitignore; then
            echo "$script" >> .gitignore
            echo "$script adicionado ao .gitignore"
        fi
    done
}

# Função para configurar o Git
configure_git() {
    read -p "Digite seu nome: " git_name
    git config --global user.name "$git_name"
    read -p "Digite seu e-mail: " git_email
    git config --global user.email "$git_email"
    echo "Configurações do Git atualizadas:"
    git config --list
}

# Função para realizar um commit
commit_changes() {
    echo "Arquivos no diretório:"
    git status -s

    commit_types=("feat" "fix" "docs" "style" "refactor" "test" "chore")
    echo "Tipos de commit:"
    echo "- feat: Uma nova funcionalidade"
    echo "- fix: Correção de um bug"
    echo "- docs: Mudanças na documentação"
    echo "- style: Mudanças que não afetam o significado do código (espaçamento, formatação, etc.)"
    echo "- refactor: Mudanças de código que não corrigem um bug nem adicionam uma funcionalidade"
    echo "- test: Adicionando testes ou corrigindo testes existentes"
    echo "- chore: Atualizações para tarefas de manutenção"

    read -p "Digite o tipo de commit: " type_choice
    read -p "Digite a descrição do commit: " description

    commit_message="$type_choice: $description"

    git add .
    git commit -m "$commit_message"
    echo "Commit realizado com sucesso: $commit_message"
}

# Função para puxar mudanças
pull_changes() {
    git pull
}

# Função para buscar mudanças
fetch_changes() {
    git fetch
}

# Função para enviar mudanças
push_changes() {
    git push
}

# Função para rebase
rebase_changes() {
    echo "Escolha a branch para rebase:"
    git branch
    read -p "Digite o nome da branch: " branch_name
    git rebase "$branch_name"

    if [ $? -ne 0 ]; then
        echo "Conflitos encontrados durante o rebase."
        echo "Resolva os conflitos e, em seguida, execute 'git rebase --continue' para continuar."
    fi
}

# Função para listar branches
list_branches() {
    echo "Branches disponíveis:"
    git branch -v
}

# Função para alterar branch
checkout_branch() {
    read -p "Digite o nome da branch para mudar: " branch_name
    git checkout "$branch_name"
}

# Função para deletar branch
delete_branch() {
    read -p "Digite o nome da branch a ser deletada: " branch_name
    git branch -d "$branch_name"
}

# Função para adicionar ao .gitignore
add_to_gitignore() {
    read -p "Digite o arquivo ou diretório a ser adicionado ao .gitignore: " ignore_entry
    if ! grep -Fxq "$ignore_entry" .gitignore; then
        echo "$ignore_entry" >> .gitignore
        echo "$ignore_entry adicionado ao .gitignore"
    else
        echo "$ignore_entry já está no .gitignore"
    fi
}

# Função principal
main() {
    add_scripts_to_gitignore  # Adiciona os scripts ao .gitignore
    while true; do
        echo ""
        echo "Escolha uma operação:"
        echo "1. Configurar Git"
        echo "2. Commit"
        echo "3. Pull"
        echo "4. Fetch"
        echo "5. Push"
        echo "6. Rebase"
        echo "7. Listar branches"
        echo "8. Alterar branch"
        echo "9. Deletar branch"
        echo "10. Adicionar ao .gitignore"
        echo "11. Sair"

        read -p "Digite sua escolha: " choice

        case $choice in
            1) configure_git ;;
            2) commit_changes ;;
            3) pull_changes ;;
            4) fetch_changes ;;
            5) push_changes ;;
            6) rebase_changes ;;
            7) list_branches ;;
            8) checkout_branch ;;
            9) delete_branch ;;
            10) add_to_gitignore ;;
            11) echo "Saindo..."; exit ;;
            *) echo "Opção inválida. Tente novamente." ;;
        esac
    done
}

# Chama a função principal
main
