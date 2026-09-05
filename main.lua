-- main.lua
local FileManager = require("src.file_manager")

-- Instancia o gerenciador apontando para um arquivo de testes
local manager = FileManager.new("dados.txt")

print("=== Testando Escrita ===")
local success, err = manager:write("Linha 1: Primeira linha salva no Mac.\n")
if success then
    print("✔ Conteúdo gravado com sucesso.")
else
    print("✖ " .. err)
end

print("\n=== Testando Anexo (Append) ===")
manager:append("Linha 2: Segunda linha anexada.\n")
manager:append("Linha 3: Terceira linha anexada.\n")
print("✔ Linhas anexadas.")

print("\n=== Leitura Completa do Arquivo ===")
local content = manager:read_all()
print(content)

print("=== Leitura Linha por Linha (Tabela) ===")
local lines = manager:read_lines()
if lines then
    for i, line in ipairs(lines) do
        print(string.format("Linha [%d]: %s", i, line))
    end
end