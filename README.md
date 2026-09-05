# 📁 Lua File Manager

![Lua Version](https://img.shields.io/badge/Lua-5.1%2B-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

Um módulo leve, robusto e reutilizável em **Lua** para simplificar operações de leitura, escrita, verificação e manipulação de arquivos de texto.

---

## 🚀 Funcionalidades

- **`exists()`**: Verifica se o arquivo existe no sistema de arquivos.
- **`write(content)`**: Cria ou sobrescreve o arquivo com o conteúdo informado.
- **`append(content)`**: Anexa novo conteúdo ao final do arquivo existente.
- **`read_all()`**: Retorna todo o conteúdo do arquivo em uma única string.
- **`read_lines()`**: Retorna uma tabela contendo todas as linhas do arquivo.
- **`get_size()`**: Retorna o tamanho do arquivo em bytes.
- **`delete()`**: Apaga o arquivo do sistema de arquivos com segurança.

---

## 🛠️ Como Executar

Certifique-se de ter o **Lua 5.1+** instalado em sua máquina.

### Executar a Aplicação de Demonstração:
```bash
lua main.lua
```

### Executar a Suíte de Testes Automatizados:

```bash
lua tests.lua
```

## 💻 Exemplo de Uso

```lua
package.path = package.path .. ";./src/?.lua"

local FileManager = require("file_manager")
local manager = FileManager.new("meu_arquivo.txt")

-- Escreve ou sobrescreve o arquivo.
local ok, err = manager:write("Olá, Mundo!\n")
assert(ok, err)

-- Anexa conteúdo ao fim do arquivo.
ok, err = manager:append("Segunda linha.\n")
assert(ok, err)

-- Lê todas as linhas.
local lines, read_err = manager:read_lines()
assert(lines, read_err)

for i, line in ipairs(lines) do
    print(i, line)
end

-- Consulta o tamanho em bytes.
local size, size_err = manager:get_size()
assert(size, size_err)
print("Tamanho do arquivo:", size, "bytes")

-- Remove o arquivo.
local deleted, delete_err = manager:delete()
assert(deleted, delete_err)
```

## 📚 API

| Método | Descrição | Retorno em falha |
| --- | --- | --- |
| `FileManager.new(filepath)` | Cria um gerenciador para o caminho informado. | — |
| `exists()` | Verifica se o arquivo pode ser aberto para leitura. | `false` |
| `write(content)` | Cria ou sobrescreve o conteúdo. Aceita `string` ou `number`. | `false, mensagem` |
| `append(content)` | Anexa conteúdo. Aceita `string` ou `number`. | `false, mensagem` |
| `read_all()` | Retorna todo o conteúdo em uma string. | `nil, mensagem` |
| `read_lines()` | Retorna uma tabela sem as quebras de linha. | `nil, mensagem` |
| `get_size()` | Retorna o tamanho do arquivo em bytes. | `nil, mensagem` |
| `delete()` | Remove o arquivo. | `false, mensagem` |

> O módulo não cria diretórios intermediários. A pasta de destino deve existir antes de usar `write()` ou `append()`.

## 🧪 Testes Automatizados

A suíte não usa dependências externas e verifica criação, escrita, anexo, leitura completa e por linhas, tamanho, exclusão e erros de entrada.

```bash
lua tests.lua
```

## 📄 Licença

Este projeto está sob a [licença MIT](LICENSE).
