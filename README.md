# 📁 Lua File Manager
![Lua Version](https://img.shields.io/badge/Lua-5.1%2B-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

Um módulo leve e reutilizável em **Lua** para simplificar operações de leitura, escrita e manipulação de arquivos de texto.

## 🚀 Funcionalidades

- Criar e sobrescrever arquivos (`write`)
- Anexar novos dados sem apagar os existentes (`append`)
- Ler o conteúdo completo de um arquivo (`read_all`)
- Obter todas as linhas do arquivo em formato de tabela (`read_lines`)

## 🛠️ Como Executar

Certifique-se de ter o Lua instalado em sua máquina:
bash
lua main.lua

## 💻 Exemplo de Uso
lua
local FileManager = require("src.file_manager")
local manager = FileManager.new("meu_arquivo.txt")

-- Escrever texto
manager:write("Olá, Mundo!\n")

-- Anexar texto
manager:append("Nova linha de texto.\n")

-- Ler todo o conteúdo
local conteudo = manager:read_all()
print(conteudo)