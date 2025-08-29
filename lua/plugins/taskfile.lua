return {
  -- Taskfile.yml support
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "yaml" })
      end
    end,
  },
  
  -- Task runner integration
  {
    "stevearc/overseer.nvim",
    cmd = { "OverseerRun", "OverseerToggle", "OverseerInfo" },
    opts = {
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1
      },
      templates = { "builtin", "task" },
    },
    config = function(_, opts)
      require("overseer").setup(opts)
      
      -- Auto-detect Taskfile tasks
      local function register_taskfile_tasks()
        local taskfiles = vim.fn.glob("Taskfile*.yml", false, true)
        if #taskfiles > 0 then
          require("overseer").register_template({
            name = "task",
            builder = function()
              local tasks = {}
              
              -- Parse taskfile for available tasks
              for _, taskfile in ipairs(taskfiles) do
                local cmd = string.format("task --list-all --taskfile=%s", taskfile)
                local handle = io.popen(cmd .. " 2>/dev/null")
                if handle then
                  local result = handle:read("*a")
                  handle:close()
                  
                  if result and result ~= "" then
                    for line in result:gmatch("[^\r\n]+") do
                      local task_name = line:match("^([%w%-_:]+)")
                      if task_name and not task_name:match("^task:") then
                        table.insert(tasks, {
                          name = string.format("task %s", task_name),
                          cmd = { "task", task_name },
                          cwd = vim.fn.getcwd(),
                        })
                      end
                    end
                  end
                end
              end
              
              return tasks
            end,
          })
        end
      end
      
      -- Register tasks on startup
      vim.defer_fn(register_taskfile_tasks, 1000)
      
      -- Keybindings for task management
      vim.keymap.set("n", "<leader>tr", "<cmd>OverseerRun<cr>", { desc = "[T]ask [R]un" })
      vim.keymap.set("n", "<leader>tt", "<cmd>OverseerToggle<cr>", { desc = "[T]ask [T]oggle panel" })
      vim.keymap.set("n", "<leader>ti", "<cmd>OverseerInfo<cr>", { desc = "[T]ask [I]nfo" })
      vim.keymap.set("n", "<leader>ta", "<cmd>OverseerTaskAction<cr>", { desc = "[T]ask [A]ctions" })
    end,
  },

  -- Direct Taskfile execution
  {
    "vim-test/vim-test",
    config = function()
      -- Add Taskfile support to vim-test
      vim.g["test#custom_runners"] = { taskfile = { "task" } }
      
      -- Custom task runner function
      local function run_task()
        local task_name = vim.fn.input("Task name: ")
        if task_name and task_name ~= "" then
          local cmd = string.format("task %s", task_name)
          vim.cmd(string.format("terminal %s", cmd))
        end
      end
      
      local function list_tasks()
        local taskfiles = vim.fn.glob("Taskfile*.yml", false, true)
        if #taskfiles > 0 then
          vim.cmd("terminal task --list-all")
        else
          print("No Taskfile found in current directory")
        end
      end
      
      -- Taskfile-specific keybindings
      vim.keymap.set("n", "<leader>tk", run_task, { desc = "[T]as[k] run specific task" })
      vim.keymap.set("n", "<leader>tl", list_tasks, { desc = "[T]ask [L]ist all tasks" })
      
      -- Quick access to common tasks
      vim.keymap.set("n", "<leader>tb", function() vim.cmd("terminal task build") end, { desc = "[T]ask [B]uild" })
      vim.keymap.set("n", "<leader>ts", function() vim.cmd("terminal task start") end, { desc = "[T]ask [S]tart" })
      vim.keymap.set("n", "<leader>td", function() vim.cmd("terminal task dev") end, { desc = "[T]ask [D]ev" })
      vim.keymap.set("n", "<leader>te", function() vim.cmd("terminal task test") end, { desc = "[T]ask t[E]st" })
    end,
  },

  -- YAML syntax and validation
  {
    "someone-stole-my-name/yaml-companion.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("yaml-companion").setup({
        schemas = {
          {
            name = "Taskfile",
            uri = "https://taskfile.dev/schema.json",
          },
        },
        lspconfig = {
          cmd = { "yaml-language-server", "--stdio" },
          settings = {
            yaml = {
              validate = true,
              schemaStore = {
                enable = true,
              },
            }
          }
        },
      })
    end,
  },
}