-- main.lua
package.path = package.path .. ";./src/?.lua"
local FileManager = require("file_manager")

local manager = FileManager.new("data.txt")

print("1. Does the file exist?", manager:exists())

print("\n2. Writing to the file...")
manager:write("Line A: Testing the project evolution.\nLine B: A more complete module.\n")

print("\n3. Does the file exist now?", manager:exists())
print("File size:", manager:get_size(), "bytes")

print("\n4. Reading all lines:")
local lines = manager:read_lines()
if lines then
    for i, line in ipairs(lines) do
        print(i, line)
    end
end

-- Uncomment the following line to test automatic deletion:
-- manager:delete()
