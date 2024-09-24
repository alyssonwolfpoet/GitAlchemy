# Adiciona os próprios scripts ao .gitignore, se ainda não estiverem lá
function Add-ScriptsToGitIgnore {
    $scriptFiles = @("git_commit_with_options.bat", "git_commit_with_options.ps1", "git_commit_with_options.sh")
    foreach ($script in $scriptFiles) {
        if (-not (Get-Content .gitignore | Select-String -Fx $script)) {
            Add-Content -Path .gitignore -Value $script
            Write-Host "$script adicionado ao .gitignore"
        }
    }
}

# Função para configurar o Git
function Configure-Git {
    $gitName = Read-Host "Digite seu nome"
    git config --global user.name $gitName
    $gitEmail = Read-Host "Digite seu e-mail"
    git config --global user.email $gitEmail
    Write-Host "Configurações do Git atualizadas:"
    git config --list
}

# Função para realizar um commit
function Commit-Changes {
    Write-Host "Arquivos no diretório:"
    git status -s

    $commitTypes = @("feat", "fix", "docs", "style", "refactor", "test", "chore")
    Write-Host "Tipos de commit:"
    Write-Host "- feat: Uma nova funcionalidade"
    Write-Host "- fix: Correção de um bug"
    Write-Host "- docs: Mudanças na documentação"
    Write-Host "- style: Mudanças que não afetam o significado do código (espaçamento, formatação, etc.)"
    Write-Host "- refactor: Mudanças de código que não corrigem um bug nem adicionam uma funcionalidade"
    Write-Host "- test: Adicionando testes ou corrigindo testes existentes"
    Write-Host "- chore: Atualizações para tarefas de manutenção"

    $typeChoice = Read-Host "Digite o tipo de commit"
    $description = Read-Host "Digite a descrição do commit"

    $commitMessage = "$typeChoice: $description"

    git add .
    git commit -m $commitMessage
    Write-Host "Commit realizado com sucesso: $commitMessage"
}

# Função para puxar mudanças
function Pull-Changes {
    git pull
}

# Função para buscar mudanças
function Fetch-Changes {
    git fetch
}

# Função para enviar mudanças
function Push-Changes {
    git push
}

# Função para listar branches
function List-Branches {
    Write-Host "Branches disponíveis:"
    git branch -v
}

# Função para alterar branch
function Checkout-Branch {
    $branchName = Read-Host "Digite o nome da branch para mudar"
    git checkout $branchName
}

# Função para deletar branch
function Delete-Branch {
    $branchName = Read-Host "Digite o nome da branch a ser deletada"
    git branch -d $branchName
}

# Função para adicionar ao .gitignore
function Add-ToGitIgnore {
    $ignoreEntry = Read-Host "Digite o arquivo ou diretório a ser adicionado ao .gitignore"
    if (-not (Get-Content .gitignore | Select-String -Fx $ignoreEntry)) {
        Add-Content -Path .gitignore -Value $ignoreEntry
        Write-Host "$ignoreEntry adicionado ao .gitignore"
    } else {
        Write-Host "$ignoreEntry já está no .gitignore"
    }
}

# Função principal
function Main {
    Add-ScriptsToGitIgnore  # Adiciona os scripts ao .gitignore
    while ($true) {
        Write-Host ""
        Write-Host "Escolha uma operação:"
        Write-Host "1. Configurar Git"
        Write-Host "2. Commit"
        Write-Host "3. Pull"
        Write-Host "4. Fetch"
        Write-Host "5. Push"
        Write-Host "6. Listar branches"
        Write-Host "7. Alterar branch"
        Write-Host "8. Deletar branch"
        Write-Host "9. Adicionar ao .gitignore"
        Write-Host "10. Sair"

        $choice = Read-Host "Digite sua escolha"

        switch ($choice) {
            "1" { Configure-Git }
            "2" { Commit-Changes }
            "3" { Pull-Changes }
            "4" { Fetch-Changes }
            "5" { Push-Changes }
            "6" { List-Branches }
            "7" { Checkout-Branch }
            "8" { Delete-Branch }
            "9" { Add-ToGitIgnore }
            "10" { Write-Host "Saindo..."; exit }
            default { Write-Host "Opção inválida. Tente novamente." }
        }
    }
}

# Chama a função principal
Main
