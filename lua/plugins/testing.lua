return {
  -- Universal test runner
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- Language specific test adapters
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-jest",
      "rouge8/neotest-rust",
      "nvim-neotest/neotest-go",
      "rcasia/neotest-java",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          -- Python testing
          require("neotest-python")({
            dap = { justMyCode = false },
            runner = "pytest",
            python = function()
              -- Auto-detect Python interpreter
              if vim.fn.executable("poetry") == 1 then
                local handle = io.popen("poetry env info --path 2>/dev/null")
                if handle then
                  local venv_path = handle:read("*a"):gsub("%s+", "")
                  handle:close()
                  if venv_path ~= "" then
                    return venv_path .. "/bin/python"
                  end
                end
              end
              return vim.fn.exepath("python3") or vim.fn.exepath("python")
            end,
          }),
          
          -- JavaScript/TypeScript testing
          require("neotest-jest")({
            jestCommand = "npm test --",
            jestConfigFile = "jest.config.js",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),
          
          -- Rust testing
          require("neotest-rust")({
            args = { "--no-capture" },
          }),
          
          -- Go testing
          require("neotest-go")({
            experimental = {
              test_table = true,
            },
            args = { "-count=1", "-timeout=60s" }
          }),
          
          -- Java testing
          require("neotest-java")({
            ignore_wrapper = false,
          }),
        },
        
        -- Test discovery
        discovery = {
          enabled = true,
          concurrent = 1,
        },
        
        -- Output configuration
        output = {
          enabled = true,
          open_on_run = "short",
        },
        
        -- Status signs
        status = {
          enabled = true,
          signs = true,
          virtual_text = false,
        },
        
        -- Quickfix integration
        quickfix = {
          enabled = true,
          open = false,
        },
      })

      -- Test keybindings
      local neotest = require("neotest")
      
      vim.keymap.set("n", "<leader>tt", function() neotest.run.run() end, { desc = "[T]est [T]est under cursor" })
      vim.keymap.set("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "[T]est [F]ile" })
      vim.keymap.set("n", "<leader>ts", function() neotest.run.run({ suite = true }) end, { desc = "[T]est [S]uite" })
      vim.keymap.set("n", "<leader>tl", function() neotest.run.run_last() end, { desc = "[T]est [L]ast" })
      vim.keymap.set("n", "<leader>to", function() neotest.output.open({ enter = true, auto_close = true }) end, { desc = "[T]est [O]utput" })
      vim.keymap.set("n", "<leader>tO", function() neotest.output_panel.toggle() end, { desc = "[T]est [O]utput panel" })
      vim.keymap.set("n", "<leader>tS", function() neotest.summary.toggle() end, { desc = "[T]est [S]ummary" })
      vim.keymap.set("n", "<leader>tw", function() neotest.watch.toggle(vim.fn.expand("%")) end, { desc = "[T]est [W]atch" })
      
      -- Debug test
      vim.keymap.set("n", "<leader>td", function() neotest.run.run({ strategy = "dap" }) end, { desc = "[T]est [D]ebug" })
    end,
  },
  
  -- Alternative simple test runner for quick execution
  {
    "vim-test/vim-test",
    config = function()
      -- Test strategy
      vim.g["test#strategy"] = "neovim"
      vim.g["test#neovim#term_position"] = "belowright"
      vim.g["test#neovim#preserve_screen"] = 1
      
      -- Python test configuration
      vim.g["test#python#runner"] = "pytest"
      vim.g["test#python#pytest#options"] = "-v"
      
      -- JavaScript test configuration
      vim.g["test#javascript#runner"] = "jest"
      
      -- Alternative test keybindings (vim-test)
      vim.keymap.set("n", "<leader>tn", "<cmd>TestNearest<CR>", { desc = "[T]est [N]earest (vim-test)" })
      vim.keymap.set("n", "<leader>tF", "<cmd>TestFile<CR>", { desc = "[T]est [F]ile (vim-test)" })
      vim.keymap.set("n", "<leader>ta", "<cmd>TestSuite<CR>", { desc = "[T]est [A]ll (vim-test)" })
      vim.keymap.set("n", "<leader>tL", "<cmd>TestLast<CR>", { desc = "[T]est [L]ast (vim-test)" })
      vim.keymap.set("n", "<leader>tv", "<cmd>TestVisit<CR>", { desc = "[T]est [V]isit last test file" })
    end,
  },
}