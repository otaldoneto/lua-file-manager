-- tests.lua
package.path = package.path .. ";./src/?.lua"
local FileManager = require("file_manager")

local test_file = "test_output.tmp"
local manager = FileManager.new(test_file)

-- Garantir um ambiente limpo antes de iniciar
if manager:exists() then
    manager:delete()
end

local function assert_equal(actual, expected, test_name)
    if actual == expected then
        print("  [PASSED] " .. test_name)
    else
        print("  [FAILED] " .. test_name .. " | Esperado: " .. tostring(expected) .. ", Recebido: " .. tostring(actual))
        os.exit(1)
    end
end

local function assert_error_response(ok, err, test_name)
    assert_equal(ok, false, test_name .. " deve falhar")
    assert_equal(type(err), "string", test_name .. " deve retornar uma mensagem de erro")
end

print("=========================================")
print("🧪 RODANDO SUÍTE DE TESTES DO FILE MANAGER")
print("=========================================\n")

-- Teste 1: Existência em arquivo inexistente
assert_equal(manager:exists(), false, "Arquivo nao deve existir inicialmente")

-- Teste 2: Escrita
local ok_write = manager:write("Linha Teste 1\n")
assert_equal(ok_write, true, "Escrita de arquivo deve ser bem-sucedida")
assert_equal(manager:exists(), true, "Arquivo deve existir apos escrita")

-- Teste 3: Anexo (Append)
local ok_append = manager:append("Linha Teste 2\n")
assert_equal(ok_append, true, "Anexo de texto deve ser bem-sucedido")

-- Teste 4: Leitura completa
local content = manager:read_all()
assert_equal(content, "Linha Teste 1\nLinha Teste 2\n", "Leitura completa deve retornar o conteudo correto")

-- Teste 5: Leitura de linhas
local lines = manager:read_lines()
assert_equal(#lines, 2, "Arquivo deve conter exatamente 2 linhas")
assert_equal(lines[1], "Linha Teste 1", "Conteudo da primeira linha correto")
assert_equal(lines[2], "Linha Teste 2", "Conteudo da segunda linha correto")

-- Teste 6: Tamanho do arquivo
local size = manager:get_size()
assert_equal(size > 0, true, "Tamanho do arquivo deve ser maior que 0 bytes")

-- Teste 7: Validacao de conteudo invalido
local ok_invalid_write, invalid_write_err = manager:write(nil)
assert_error_response(ok_invalid_write, invalid_write_err, "Escrita com conteudo invalido")

local ok_invalid_append, invalid_append_err = manager:append({})
assert_error_response(ok_invalid_append, invalid_append_err, "Anexo com conteudo invalido")

-- Teste 8: Erro de leitura em arquivo inexistente
local missing_manager = FileManager.new("arquivo_que_nao_existe.tmp")
local missing_content, missing_err = missing_manager:read_all()
assert_equal(missing_content, nil, "Leitura de arquivo inexistente nao deve retornar conteudo")
assert_equal(type(missing_err), "string", "Leitura de arquivo inexistente deve retornar erro")

-- Teste 9: Deleção de arquivo
local ok_delete = manager:delete()
assert_equal(ok_delete, true, "Remocao do arquivo deve ser bem-sucedida")
assert_equal(manager:exists(), false, "Arquivo nao deve existir apos remocao")

local ok_delete_missing, delete_missing_err = manager:delete()
assert_error_response(ok_delete_missing, delete_missing_err, "Remocao de arquivo inexistente")

print("\n=========================================")
print("✨ TODOS OS TESTES PASSARAM COM SUCESSO!")
print("=========================================")
