-- tests.lua
package.path = package.path .. ";./src/?.lua"
local FileManager = require("file_manager")

local test_file = "test_output.tmp"
local manager = FileManager.new(test_file)

-- Ensure a clean environment before starting.
if manager:exists() then
    manager:delete()
end

local function assert_equal(actual, expected, test_name)
    if actual == expected then
        print("  [PASSED] " .. test_name)
    else
        print("  [FAILED] " .. test_name .. " | Expected: " .. tostring(expected) .. ", Received: " .. tostring(actual))
        os.exit(1)
    end
end

local function assert_error_response(ok, err, test_name)
    assert_equal(ok, false, test_name .. " should fail")
    assert_equal(type(err), "string", test_name .. " should return an error message")
end

print("=========================================")
print("🧪 RUNNING FILE MANAGER TEST SUITE")
print("=========================================\n")

-- Test 1: Nonexistent file
assert_equal(manager:exists(), false, "File should not exist initially")

-- Test 2: Write
local ok_write = manager:write("Test Line 1\n")
assert_equal(ok_write, true, "File write should succeed")
assert_equal(manager:exists(), true, "File should exist after writing")

-- Test 3: Append
local ok_append = manager:append("Test Line 2\n")
assert_equal(ok_append, true, "Content append should succeed")

-- Test 4: Full read
local content = manager:read_all()
assert_equal(content, "Test Line 1\nTest Line 2\n", "Full read should return the correct content")

-- Test 5: Line-by-line read
local lines = manager:read_lines()
assert_equal(#lines, 2, "File should contain exactly two lines")
assert_equal(lines[1], "Test Line 1", "First line content should be correct")
assert_equal(lines[2], "Test Line 2", "Second line content should be correct")

-- Test 6: File size
local size = manager:get_size()
assert_equal(size > 0, true, "File size should be greater than zero bytes")

-- Test 7: Invalid content validation
local ok_invalid_write, invalid_write_err = manager:write(nil)
assert_error_response(ok_invalid_write, invalid_write_err, "Write with invalid content")

local ok_invalid_append, invalid_append_err = manager:append({})
assert_error_response(ok_invalid_append, invalid_append_err, "Append with invalid content")

-- Test 8: Read error for a nonexistent file
local missing_manager = FileManager.new("file_that_does_not_exist.tmp")
local missing_content, missing_err = missing_manager:read_all()
assert_equal(missing_content, nil, "Nonexistent file read should not return content")
assert_equal(type(missing_err), "string", "Nonexistent file read should return an error")

-- Test 9: File deletion
local ok_delete = manager:delete()
assert_equal(ok_delete, true, "File deletion should succeed")
assert_equal(manager:exists(), false, "File should not exist after deletion")

local ok_delete_missing, delete_missing_err = manager:delete()
assert_error_response(ok_delete_missing, delete_missing_err, "Deletion of a nonexistent file")

print("\n=========================================")
print("✨ ALL TESTS PASSED!")
print("=========================================")
