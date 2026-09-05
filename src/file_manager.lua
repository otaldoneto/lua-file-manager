-- src/file_manager.lua
local FileManager = {}
FileManager.__index = FileManager

-- Construtor do objeto FileManager
function FileManager.new(filepath)
    local self = setmetatable({}, FileManager)
    self.filepath = filepath
    return self
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

return FileManager