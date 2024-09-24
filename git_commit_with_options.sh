#!/bin/bash

# Adiciona os próprios scripts ao .gitignore, se ainda não estiverem lá
add_scripts_to_gitignore() {
    local script_files=("git_commit_with_options.bat" "git_commit_with_options.ps1" "git_commit_with_options.sh")
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

    # Tipos de commit em um array
    commit_types=("feat" "fix" "docs" "style" "refactor" "test" "chore")
    echo "Tipos de commit: ${commit_types[*]}"
    read -p "Digite o tipo de commit: " type_choice
    read -p "Digite a descrição do commit: " description

    commit_message="$type_choice: $description"

    git add .
    git commit -m "$commit_message"
    echo "Commit realizado com sucesso: $commit_message"
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
        echo "3. Adicionar ao .gitignore"
        echo "4. Sair"

        read -p "Digite sua escolha: " choice

        case $choice in
            1) configure_git ;;
            2) commit_changes ;;
            3) add_to_gitignore ;;
            4) echo "Saindo..."; exit 0 ;;
            *) echo "Opção inválida. Tente novamente." ;;
        esac
    done
}

# Chama a função principal
main
