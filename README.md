### `README.md`

```markdown
# My Git Scripts

Este repositório contém scripts que facilitam a interação com o Git, permitindo configurações rápidas, commits padronizados e a adição de arquivos ao `.gitignore`. Os scripts estão disponíveis para diferentes ambientes: Windows, Linux e macOS.

## Estrutura do Projeto

/my-git-scripts
│
├── git_commit_with_options.bat  # Script para Windows (Command Prompt)
├── git_commit_with_options.ps1   # Script para Windows (PowerShell)
├── git_commit_with_options.sh     # Script para Linux e macOS (Bash)
└── README.md                      # Documentação do projeto


## Funcionalidades

Os scripts oferecem as seguintes opções:

1. **Configurar Git**: Permite definir seu nome e e-mail para os commits.
2. **Realizar Commit**: Realiza um commit com mensagens padronizadas baseadas em tipos de commit (feat, fix, docs, etc.).
3. **Adicionar ao `.gitignore`**: Adiciona arquivos ou diretórios ao arquivo `.gitignore`, evitando que sejam enviados para o repositório, incluindo os próprios scripts.
4. **Saída**: Encerra o script.

## Como Usar

### Para Windows

1. **Download do script usando Command Prompt (CMD)**:
   ```cmd
   curl -L -o git_commit_with_options.bat https://raw.githubusercontent.com/alyssonwolfpoet/my-git-scripts/main/git_commit_with_options.bat
   ```

2. **Download do script usando PowerShell**:
   ```powershell
   Invoke-WebRequest -Uri https://raw.githubusercontent.com/alyssonwolfpoet/my-git-scripts/main/git_commit_with_options.ps1 -OutFile git_commit_with_options.ps1
   ```

3. **Executar o script**:
   - Para usar o script em `Command Prompt`:
     ```cmd
     git_commit_with_options.bat
     ```
   - Para usar o script em `PowerShell`:
     ```powershell
     Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
     .\git_commit_with_options.ps1
     ```

### Para Linux

1. **Download do script**:
   ```bash
   wget https://raw.githubusercontent.com/alyssonwolfpoet/my-git-scripts/main/git_commit_with_options.sh
   ```

2. **Dar permissão de execução**:
   ```bash
   chmod +x git_commit_with_options.sh
   ```

3. **Executar o script**:
   ```bash
   ./git_commit_with_options.sh
   ```

### Para macOS

1. **Download do script**:
   ```bash
   curl -L -o git_commit_with_options.sh https://raw.githubusercontent.com/alyssonwolfpoet/my-git-scripts/main/git_commit_with_options.sh
   ```

2. **Dar permissão de execução**:
   ```bash
   chmod +x git_commit_with_options.sh
   ```

3. **Executar o script**:
   ```bash
   ./git_commit_with_options.sh
   ```

## Requisitos

- **Git**: Certifique-se de que o Git está instalado e configurado em seu sistema.
- **Permissões**: Para o script PowerShell, pode ser necessário ajustar a política de execução.

## Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou pull requests para melhorias ou novas funcionalidades.

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).
```

### Resumo das Melhorias Incorporadas

1. **Funcionalidades Claras**: Descrição detalhada das funcionalidades dos scripts.
2. **Estrutura do Projeto**: Apresentação clara dos arquivos no repositório.
3. **Instruções de Uso**: Instruções de download e execução específicas para Windows (CMD e PowerShell), Linux e macOS.
4. **Verificação e Adição ao `.gitignore`**: Funcionalidade para verificar se um item já está no `.gitignore` antes de adicionar.
5. **Mensagens de Saída**: Melhorias nas mensagens exibidas durante a execução dos scripts, usando cores e formatação.
6. **Download Direto dos Scripts**: Links diretos para download dos scripts individuais usando `curl` e `wget`.
# GitAlchemy
