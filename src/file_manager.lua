-- src/file_manager.lua
local FileManager = {}
FileManager.__index = FileManager

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
        return nil, "Erro ao abrir arquivo: " .. tostring(err)
    end
    
    local size = file:seek("end")
    file:close()
    return size
end

-- Salva ou sobrescreve o conteúdo do arquivo
function FileManager:write(content)
    local file, err = io.open(self.filepath, "w")
    if not file then
        return false, "Erro ao abrir arquivo para escrita: " .. tostring(err)
    end
    file:write(content)
    file:close()
    return true
end

-- Anexa conteúdo ao final do arquivo
function FileManager:append(content)
    local file, err = io.open(self.filepath, "a")
    if not file then
        return false, "Erro ao abrir arquivo para anexo: " .. tostring(err)
    end
    file:write(content)
    file:close()
    return true
end

-- Lê e retorna todo o conteúdo do arquivo
function FileManager:read_all()
    if not self:exists() then
        return nil, "O arquivo não existe."
    end

    local file, err = io.open(self.filepath, "r")
    if not file then
        return nil, "Erro ao abrir arquivo para leitura: " .. tostring(err)
    end
    local content = file:read("*a")
    file:close()
    return content
end

-- Retorna uma tabela com todas as linhas do arquivo
function FileManager:read_lines()
    if not self:exists() then
        return nil, "O arquivo não existe."
    end

    local lines = {}
    local file, err = io.open(self.filepath, "r")
    if not file then
        return nil, "Erro ao abrir arquivo: " .. tostring(err)
    end

    for line in file:lines() do
        table.insert(lines, line)
    end

    file:close()
    return lines
end

-- Deleta o arquivo do sistema
function FileManager:delete()
    if not self:exists() then
        return false, "O arquivo não existe para ser deletado."
    end
    return os.remove(self.filepath)
end

return FileManager