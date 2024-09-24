function Configure-Git {
    $gitName = Read-Host "Digite seu nome"
    git config --global user.name $gitName
    $gitEmail = Read-Host "Digite seu e-mail"
    git config --global user.email $gitEmail
    Write-Host "Configurações do Git atualizadas:" -ForegroundColor Green
    git config --list
}

function Commit-Changes {
    git status -s | Out-Host
    $commitTypes = @("feat", "fix", "docs", "style", "refactor", "test", "chore")
    Write-Host "Tipos de commit: $($commitTypes -join ', ')" -ForegroundColor Cyan
    $typeChoice = Read-Host "Digite o tipo de commit"
    $description = Read-Host "Digite a descrição do commit"
    $commitMessage = "$typeChoice: $description"

    git add .
    git commit -m $commitMessage
    Write-Host "Commit realizado com sucesso: $commitMessage" -ForegroundColor Green
}

function Add-To-Gitignore {
    $ignoreEntry = Read-Host "Digite o arquivo ou diretório a ser adicionado ao .gitignore"
    if (-not (Get-Content .gitignore | Where-Object { $_ -eq $ignoreEntry })) {
        Add-Content -Path .gitignore -Value $ignoreEntry
        Write-Host "$ignoreEntry adicionado ao .gitignore" -ForegroundColor Green
    } else {
        Write-Host "$ignoreEntry já está no .gitignore" -ForegroundColor Yellow
    }
}

function Show-Menu {
    while ($true) {
        Write-Host "Escolha uma operação:"
        Write-Host "1. Configurar Git"
        Write-Host "2. Commit"
        Write-Host "3. Adicionar ao .gitignore"
        Write-Host "4. Sair"

        $choice = Read-Host "Digite sua escolha"

        switch ($choice) {
            "1" { Configure-Git }
            "2" { Commit-Changes }
            "3" { Add-To-Gitignore }
            "4" { break }
            default { Write-Host "Opção inválida. Tente novamente." -ForegroundColor Red }
        }
    }
}

Show-Menu
