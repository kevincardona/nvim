-- lua/kevincardona/plugins/gitlab_pipeline.lua

local gitlab_url = "https://gitlab.vailsys.com/"
local cloudbees_base_url = "https://cloudbees.vail/teams-racc/job/"  -- Replace with your actual CloudBees base URL

-- Function to run shell commands and capture the output
local function run_command(cmd)
    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()
    return result
end

-- Function to read the GitLab token from a file
local function read_gitlab_token()
    local file = io.open(os.getenv("HOME") .. "/.gitlab_token", "r")  -- Open the file in read mode
    if not file then
        print("Error: GitLab token file not found.")
        return nil
    end
    local token = file:read("*all")  -- Read the entire file
    file:close()
    return vim.trim(token)  -- Trim any whitespace or newlines
end

-- Function to extract the GitLab remote URL from the current git repository
local function get_git_remote_url()
    local remote_url = run_command("git config --get remote.origin.url")
    return vim.trim(remote_url)
end

-- Function to convert the Git remote URL to a GitLab project path
local function convert_to_project_path(remote_url)
    -- Remove 'https://' or 'git@', then remove the domain and trailing .git
    local project_path = remote_url:gsub("^git@[^:]+:", ""):gsub("^https://[^/]+/", "")
    project_path = project_path:gsub("%.git$", "") -- Remove the .git suffix
    return project_path
end

-- Function to retrieve the latest pipeline ID from GitLab API
local function get_latest_pipeline_id(project_path)
    -- Read the token from the file
    local private_token = read_gitlab_token()
    if not private_token then
        print("Error: GitLab token not found in the file.")
        return nil
    end

    local api_url = gitlab_url .. "api/v4/projects/" .. project_path:gsub("/", "%%2F") .. "/pipelines?per_page=1"
    local curl_cmd = "curl -s --header \"PRIVATE-TOKEN: " .. private_token .. "\" \"" .. api_url .. "\""
    local result = run_command(curl_cmd)
    
    -- Parse the pipeline ID from the JSON response
    local latest_pipeline_id = result:match('"id":(%d+)')
    return latest_pipeline_id
end

-- Function to open the latest CloudBees build based on the latest GitLab pipeline
function open_latest_cloudbees_build()
    local remote_url = get_git_remote_url()

    if remote_url == "" then
        print("No remote repository found. Please run this in a git repository.")
        return
    end

    -- Convert the remote URL to a project path
    local project_path = convert_to_project_path(remote_url)

    -- Get the latest pipeline ID from GitLab
    local latest_pipeline_id = get_latest_pipeline_id(project_path)
    if not latest_pipeline_id then
        print("Could not retrieve the latest pipeline ID. Make sure the token is correct.")
        return
    end

    -- Construct the CloudBees build URL using the latest pipeline ID
    local cloudbees_url = cloudbees_base_url .. project_path .. "/pipeline/" .. latest_pipeline_id

    -- Open the CloudBees URL in the browser
    local open_command = "xdg-open " .. cloudbees_url
    if vim.fn.has("macunix") == 1 then
        open_command = "open " .. cloudbees_url
    end

    run_command(open_command)
    print("Opening CloudBees build URL: " .. cloudbees_url)
end

-- Function to open GitLab pipeline URL
function open_pipeline_url()
    local remote_url = get_git_remote_url()

    if remote_url == "" then
        print("No remote repository found. Please run this in a git repository.")
        return
    end
    local project_path = convert_to_project_path(remote_url)
    local pipeline_url = gitlab_url .. project_path .. "/pipelines"
    local open_command = "xdg-open " .. pipeline_url
    if vim.fn.has("macunix") == 1 then
        open_command = "open " .. pipeline_url
    end
    run_command(open_command)
    print("Opening pipeline URL: " .. pipeline_url)
end

-- Register Neovim command for GitLab pipelines
vim.api.nvim_create_user_command('GitlabPipeline', function() open_pipeline_url() end, { nargs = 0 })

-- Register Neovim command for CloudBees build
vim.api.nvim_create_user_command('CloudbeesBuild', function() open_latest_cloudbees_build() end, { nargs = 0 })

-- Key mappings for GitLab and CloudBees
vim.api.nvim_set_keymap('n', '<leader>gp', ':GitlabPipeline<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>go', ':CloudbeesBuild<CR>', { noremap = true, silent = true })

return {}

