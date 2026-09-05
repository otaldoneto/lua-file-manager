-- src/file_manager.lua
local FileManager = {}
FileManager.__index = FileManager

local function error_message(operation, err)
    return operation .. ": " .. tostring(err)
end

function FileManager.new(filepath)
    local self = setmetatable({}, FileManager)
    self.filepath = filepath
    return self
end

-- Verifica se o arquivo existe no sistema
function FileManager:exists()
    local file = io.open(self.filepath, "r")
    if file then
        file:close()
        return true
    end
    return false
end

-- Obtém o tamanho do arquivo em bytes
function FileManager:get_size()
    local file, err = io.open(self.filepath, "r")
    if not file then
        return nil, error_message("Erro ao abrir arquivo", err)
    end

    local size, seek_err = file:seek("end")
    local close_ok, close_err = file:close()

    if not size then
        return nil, error_message("Erro ao obter tamanho do arquivo", seek_err)
    end
    if not close_ok then
        return nil, error_message("Erro ao fechar arquivo", close_err)
    end

    return size
end

-- Salva ou sobrescreve o conteúdo do arquivo
function FileManager:write(content)
    if type(content) ~= "string" and type(content) ~= "number" then
        return false, "O conteúdo deve ser uma string ou número."
    end

    local file, err = io.open(self.filepath, "w")
    if not file then
        return false, error_message("Erro ao abrir arquivo para escrita", err)
    end

    local write_ok, write_err = file:write(content)
    local close_ok, close_err = file:close()

    if not write_ok then
        return false, error_message("Erro ao escrever arquivo", write_err)
    end
    if not close_ok then
        return false, error_message("Erro ao fechar arquivo", close_err)
    end

    return true
end

-- Anexa conteúdo ao final do arquivo
function FileManager:append(content)
    if type(content) ~= "string" and type(content) ~= "number" then
        return false, "O conteúdo deve ser uma string ou número."
    end

    local file, err = io.open(self.filepath, "a")
    if not file then
        return false, error_message("Erro ao abrir arquivo para anexo", err)
    end

    local write_ok, write_err = file:write(content)
    local close_ok, close_err = file:close()

    if not write_ok then
        return false, error_message("Erro ao anexar conteúdo ao arquivo", write_err)
    end
    if not close_ok then
        return false, error_message("Erro ao fechar arquivo", close_err)
    end

    return true
end

-- Lê e retorna todo o conteúdo do arquivo
function FileManager:read_all()
    local file, err = io.open(self.filepath, "r")
    if not file then
        return nil, error_message("Erro ao abrir arquivo para leitura", err)
    end

    local content, read_err = file:read("*a")
    local close_ok, close_err = file:close()

    if content == nil then
        return nil, error_message("Erro ao ler arquivo", read_err)
    end
    if not close_ok then
        return nil, error_message("Erro ao fechar arquivo", close_err)
    end

    return content
end

-- Retorna uma tabela com todas as linhas do arquivo
function FileManager:read_lines()
    local lines = {}
    local file, err = io.open(self.filepath, "r")
    if not file then
        return nil, error_message("Erro ao abrir arquivo", err)
    end

    while true do
        local line, read_err = file:read("*l")
        if line == nil then
            if read_err then
                file:close()
                return nil, error_message("Erro ao ler arquivo", read_err)
            end
            break
        end
        lines[#lines + 1] = line
    end

    local close_ok, close_err = file:close()
    if not close_ok then
        return nil, error_message("Erro ao fechar arquivo", close_err)
    end

    return lines
end

-- Deleta o arquivo do sistema
function FileManager:delete()
    local ok, err = os.remove(self.filepath)
    if not ok then
        return false, error_message("Erro ao deletar arquivo", err)
    end

    return true
end

return FileManager
