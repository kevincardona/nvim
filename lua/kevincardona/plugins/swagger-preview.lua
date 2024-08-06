local function is_running(file)
  local f = io.open(file, "r")
  if f then
    f:close()
    return true
  else
    return false
  end
end

local function write_lock_file(file)
  local f = io.open(file, "w")
  if f then
    f:write("running")
    f:close()
  end
end

local function remove_lock_file(file)
  os.remove(file)
end

local asyncapi_port = 3210
local asyncapi_url = "http://localhost:" .. asyncapi_port
local asyncapi_lock_file = "/tmp/asyncapi_preview.lock"

function StartAsyncApiPreview()
  if is_running(asyncapi_lock_file) then
    print("AsyncApi preview is already running.")
    return
  end

  local file_path = vim.api.nvim_buf_get_name(0)
  local asyncapi_command = string.format("asyncapi start studio -f %s --port %d", file_path, asyncapi_port)
  vim.fn.jobstart(asyncapi_command, {detach = true})
  write_lock_file(asyncapi_lock_file)
  print("AsyncApi preview started at " .. asyncapi_url)
end

local redocly_port = 3471
local redocly_url = "http://localhost:" .. redocly_port
local redocly_lock_file = "/tmp/redocly_preview.lock"

function StopAsyncApiPreview()
  if is_running(asyncapi_lock_file) then
    vim.fn.jobstart("pkill -f 'asyncapi start studio'", {detach = true})
    remove_lock_file(asyncapi_lock_file)
    print("AsyncApi preview stopped.")
  else
    print("No AsyncApi preview running.")
  end
end

function StartRedoclyPreview()
  if is_running(redocly_lock_file) then
    print("Redocly preview is already running.")
    return
  end

  local file_path = vim.api.nvim_buf_get_name(0)
  local redocly_command = string.format("redocly preview-docs %s --port %d", file_path, redocly_port)
  vim.fn.jobstart(redocly_command, {detach = true})
  vim.fn.jobstart({"open", redocly_url}, {detach = true})  -- For macOS
  write_lock_file(redocly_lock_file)
  print("Redocly preview started at " .. redocly_url)
end

function StopRedoclyPreview()
  if is_running(redocly_lock_file) then
    vim.fn.jobstart("pkill -f 'redocly preview-docs'", {detach = true})
    remove_lock_file(redocly_lock_file)
    print("Redocly preview stopped.")
  else
    print("No Redocly preview running.")
  end
end

function LintRedocly()
  local file_path = vim.api.nvim_buf_get_name(0)
  local redocly_command = string.format("redocly lint %s", file_path)
  local output = vim.fn.systemlist(redocly_command)
  print(table.concat(output, "\n"))
end

local swagger_port = 8980
local swagger_lock_file = "/tmp/swagger_preview.lock"

function StartSwaggerPreview()
  if is_running(swagger_lock_file) then
    print("Swagger preview is already running.")
    return
  end

  local file_path = vim.api.nvim_buf_get_name(0)
  local swagger_command = string.format("npx open-swagger-ui --port %s %s", swagger_port, file_path)
  vim.fn.jobstart(swagger_command, {detach = true})
  write_lock_file(swagger_lock_file)
  print("Swagger preview started.")
end

function StopSwaggerPreview()
  if is_running(swagger_lock_file) then
    vim.fn.jobstart("pkill -f 'npm exec open-swagger-ui'", {detach = true})
    remove_lock_file(swagger_lock_file)
    print("Swagger preview stopped.")
  else
    print("No Swagger preview running.")
  end
end

vim.api.nvim_set_keymap('n', '<leader>ap', ":lua StartAsyncApiPreview()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>as', ":lua StopAsyncApiPreview()<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>rp', ":lua StartRedoclyPreview()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rs', ":lua StopRedoclyPreview()<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>sp', ":lua StartSwaggerPreview()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ss', ":lua StopSwaggerPreview()<CR>", { noremap = true, silent = true })

return {}
