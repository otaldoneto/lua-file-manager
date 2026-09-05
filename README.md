# Lua File Manager

![Lua Version](https://img.shields.io/badge/Lua-5.1%2B-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

A lightweight, robust, and reusable **Lua** module for reading, writing, checking, and managing text files.

---

## Features

- **`exists()`**: Checks whether a file can be opened for reading.
- **`write(content)`**: Creates or overwrites a file with the supplied content.
- **`append(content)`**: Adds content to the end of a file.
- **`read_all()`**: Returns the full file contents as one string.
- **`read_lines()`**: Returns all file lines in a table.
- **`get_size()`**: Returns the file size in bytes.
- **`delete()`**: Deletes a file.
- Consistent error returns for failed file operations.

---

## Requirements

- Lua 5.1 or newer.
- Operating-system permission to access the target file.

No external dependencies are required.

## Project structure

```text
lua-file-manager/
├── src/
│   └── file_manager.lua  # Main module
├── main.lua              # Usage demonstration
├── tests.lua             # Dependency-free test suite
├── README.md
└── LICENSE
```

## Running the project

Run the demonstration from the repository root:

```bash
lua main.lua
```

Run the automated tests:

```bash
lua tests.lua
```

## Usage example

```lua
package.path = package.path .. ";./src/?.lua"

local FileManager = require("file_manager")
local manager = FileManager.new("my_file.txt")

-- Create or overwrite a file.
local ok, err = manager:write("Hello, world!\n")
assert(ok, err)

-- Add content without replacing existing content.
ok, err = manager:append("Second line.\n")
assert(ok, err)

-- Read every line.
local lines, read_err = manager:read_lines()
assert(lines, read_err)

for index, line in ipairs(lines) do
    print(index, line)
end

-- Get the file size in bytes.
local size, size_err = manager:get_size()
assert(size, size_err)
print("File size:", size, "bytes")

-- Delete the file.
local deleted, delete_err = manager:delete()
assert(deleted, delete_err)
```

## API

| Method | Description | Failure return |
| --- | --- | --- |
| `FileManager.new(filepath)` | Creates a manager for the supplied path. | — |
| `exists()` | Checks whether the file can be opened for reading. | `false` |
| `write(content)` | Creates or overwrites content. Accepts a `string` or `number`. | `false, message` |
| `append(content)` | Appends content. Accepts a `string` or `number`. | `false, message` |
| `read_all()` | Returns the complete contents as a string. | `nil, message` |
| `read_lines()` | Returns a table without line breaks. | `nil, message` |
| `get_size()` | Returns the file size in bytes. | `nil, message` |
| `delete()` | Deletes the file. | `false, message` |

> The module does not create intermediate directories. The destination directory must exist before calling `write()` or `append()`.

## Tests

The dependency-free test suite covers creation, writing, appending, full and line-by-line reads, file size, deletion, and invalid input.

```bash
lua tests.lua
```

## License

This project is licensed under the [MIT License](LICENSE).
