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

-- Checks whether the file can be opened for reading.
function FileManager:exists()
    local file = io.open(self.filepath, "r")
    if file then
        file:close()
        return true
    end
    return false
end

-- Gets the file size in bytes.
function FileManager:get_size()
    local file, err = io.open(self.filepath, "r")
    if not file then
        return nil, error_message("Failed to open file", err)
    end

    local size, seek_err = file:seek("end")
    local close_ok, close_err = file:close()

    if not size then
        return nil, error_message("Failed to get file size", seek_err)
    end
    if not close_ok then
        return nil, error_message("Failed to close file", close_err)
    end

    return size
end

-- Saves or overwrites the file contents.
function FileManager:write(content)
    if type(content) ~= "string" and type(content) ~= "number" then
        return false, "Content must be a string or number."
    end

    local file, err = io.open(self.filepath, "w")
    if not file then
        return false, error_message("Failed to open file for writing", err)
    end

    local write_ok, write_err = file:write(content)
    local close_ok, close_err = file:close()

    if not write_ok then
        return false, error_message("Failed to write file", write_err)
    end
    if not close_ok then
        return false, error_message("Failed to close file", close_err)
    end

    return true
end

-- Appends content to the end of the file.
function FileManager:append(content)
    if type(content) ~= "string" and type(content) ~= "number" then
        return false, "Content must be a string or number."
    end

    local file, err = io.open(self.filepath, "a")
    if not file then
        return false, error_message("Failed to open file for appending", err)
    end

    local write_ok, write_err = file:write(content)
    local close_ok, close_err = file:close()

    if not write_ok then
        return false, error_message("Failed to append content to file", write_err)
    end
    if not close_ok then
        return false, error_message("Failed to close file", close_err)
    end

    return true
end

-- Reads and returns the full file contents.
function FileManager:read_all()
    local file, err = io.open(self.filepath, "r")
    if not file then
        return nil, error_message("Failed to open file for reading", err)
    end

    local content, read_err = file:read("*a")
    local close_ok, close_err = file:close()

    if content == nil then
        return nil, error_message("Failed to read file", read_err)
    end
    if not close_ok then
        return nil, error_message("Failed to close file", close_err)
    end

    return content
end

-- Returns a table containing every line in the file.
function FileManager:read_lines()
    local lines = {}
    local file, err = io.open(self.filepath, "r")
    if not file then
        return nil, error_message("Failed to open file", err)
    end

    while true do
        local line, read_err = file:read("*l")
        if line == nil then
            if read_err then
                file:close()
                return nil, error_message("Failed to read file", read_err)
            end
            break
        end
        lines[#lines + 1] = line
    end

    local close_ok, close_err = file:close()
    if not close_ok then
        return nil, error_message("Failed to close file", close_err)
    end

    return lines
end

-- Deletes the file from the file system.
function FileManager:delete()
    local ok, err = os.remove(self.filepath)
    if not ok then
        return false, error_message("Failed to delete file", err)
    end

    return true
end

return FileManager
