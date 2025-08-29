-- Multi-project workspace management utilities

local M = {}

-- Auto-add all git repositories in parent directory as workspace folders
function M.add_sibling_projects()
  local parent_dir = vim.fn.expand("%:p:h:h") -- Go up one level from current file
  local current_dir = vim.fn.getcwd()
  
  -- Find all directories with .git folders
  local handle = vim.loop.fs_scandir(parent_dir)
  if handle then
    local projects_added = 0
    while true do
      local name, type = vim.loop.fs_scandir_next(handle)
      if not name then break end
      
      if type == "directory" then
        local project_path = parent_dir .. "/" .. name
        local git_path = project_path .. "/.git"
        
        -- Check if it's a git repository and not the current directory
        if vim.fn.isdirectory(git_path) == 1 and project_path ~= current_dir then
          vim.lsp.buf.add_workspace_folder(project_path)
          projects_added = projects_added + 1
        end
      end
    end
    print("Added " .. projects_added .. " sibling projects to workspace")
  else
    print("Could not scan parent directory: " .. parent_dir)
  end
end

-- Auto-add projects based on common patterns
function M.add_related_projects()
  local patterns = {
    "pyproject.toml",
    "poetry.lock",
    "uv.lock",
    "requirements.txt",
    "package.json", 
    "Cargo.toml",
    "go.mod",
    "pom.xml",
    "build.gradle",
  }
  
  local parent_dir = vim.fn.expand("%:p:h:h")
  local handle = vim.loop.fs_scandir(parent_dir)
  
  if handle then
    local projects_added = 0
    while true do
      local name, type = vim.loop.fs_scandir_next(handle)
      if not name then break end
      
      if type == "directory" then
        local project_path = parent_dir .. "/" .. name
        
        -- Check if directory contains any project markers
        for _, pattern in ipairs(patterns) do
          if vim.fn.filereadable(project_path .. "/" .. pattern) == 1 then
            vim.lsp.buf.add_workspace_folder(project_path)
            projects_added = projects_added + 1
            break
          end
        end
      end
    end
    print("Added " .. projects_added .. " related projects to workspace")
  end
end

-- Clear all workspace folders except current
function M.clear_workspace()
  local folders = vim.lsp.buf.list_workspace_folders()
  for _, folder in ipairs(folders) do
    vim.lsp.buf.remove_workspace_folder(folder)
  end
  vim.lsp.buf.add_workspace_folder(vim.fn.getcwd())
  print("Reset workspace to current directory only")
end

return M