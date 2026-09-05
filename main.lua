-- main.lua
package.path = package.path .. ";./src/?.lua"
local FileManager = require("file_manager")

local manager = FileManager.new("dados.txt")

print("1. O arquivo existe?", manager:exists())

print("\n2. Escrevendo no arquivo...")
manager:write("Linha A: Testando evolução do projeto.\nLinha B: Módulo mais completo.\n")

print("\n3. O arquivo existe agora?", manager:exists())
print("Tamanho do arquivo:", manager:get_size(), "bytes")

print("\n4. Lendo todas as linhas:")
local lines = manager:read_lines()
if lines then
    for i, line in ipairs(lines) do
        print(i, line)
    end
end

-- Descomente a linha abaixo se quiser testar a exclusão automática:
-- manager:delete()