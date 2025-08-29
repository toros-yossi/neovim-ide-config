local keymap = vim.keymap

-- Better up/down
keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize window using <ctrl> arrow keys
keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move line down" })
keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move line up" })

-- Better indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Clear search with <esc>
keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Save file
keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Better paste
keymap.set("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Diagnostic keymaps
keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Multi-project workspace management
keymap.set("n", "<leader>wag", function()
  require("config.multi-project").add_sibling_projects()
end, { desc = "[W]orkspace [A]dd sibling [G]it projects" })

keymap.set("n", "<leader>wap", function()
  require("config.multi-project").add_related_projects()
end, { desc = "[W]orkspace [A]dd related [P]rojects" })

keymap.set("n", "<leader>wc", function()
  require("config.multi-project").clear_workspace()
end, { desc = "[W]orkspace [C]lear (reset to current dir)" })

-- Debugging keybindings
keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "[D]ebug [B]reakpoint" })
keymap.set("n", "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { desc = "[D]ebug [B]reakpoint with condition" })
keymap.set("n", "<leader>dc", function() require("dap").continue() end, { desc = "[D]ebug [C]ontinue" })
keymap.set("n", "<leader>ds", function() require("dap").step_over() end, { desc = "[D]ebug [S]tep over" })
keymap.set("n", "<leader>di", function() require("dap").step_into() end, { desc = "[D]ebug step [I]nto" })
keymap.set("n", "<leader>do", function() require("dap").step_out() end, { desc = "[D]ebug step [O]ut" })
keymap.set("n", "<leader>dr", function() require("dap").repl.open() end, { desc = "[D]ebug [R]EPL" })
keymap.set("n", "<leader>dl", function() require("dap").run_last() end, { desc = "[D]ebug [L]ast" })
keymap.set("n", "<leader>dt", function() require("dap").terminate() end, { desc = "[D]ebug [T]erminate" })
keymap.set("n", "<leader>du", function() require("dapui").toggle() end, { desc = "[D]ebug [U]I toggle" })

-- Claude Code integration (conversational AI experience)
local function claude_interactive()
  -- Start a new interactive Claude session
  vim.cmd("terminal claude")
end

local function claude_continue()
  -- Continue the most recent Claude conversation
  vim.cmd("terminal claude --continue")
end

local function claude_with_file()
  -- Start Claude with current file as context
  local current_file = vim.fn.expand("%:p")
  if current_file ~= "" then
    local cmd = string.format("terminal claude '@%s'", current_file)
    vim.cmd(cmd)
  else
    vim.cmd("terminal claude")
  end
end

local function claude_with_selection()
  -- Get selected text and start Claude with it as context
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.fn.getline(start_pos[2], end_pos[2])
  local selected_text = table.concat(lines, "\n")
  
  -- Create temporary file with selected content
  local temp_file = vim.fn.tempname() .. ".txt"
  vim.fn.writefile(vim.split(selected_text, "\n"), temp_file)
  
  local cmd = string.format("terminal claude '@%s'", temp_file)
  vim.cmd(cmd)
end

local function claude_project_context()
  -- Start Claude with current directory context
  local cmd = string.format("terminal claude --add-dir '%s'", vim.fn.getcwd())
  vim.cmd(cmd)
end

-- Claude Code keybindings for conversational experience
keymap.set("n", "<leader>cc", claude_interactive, { desc = "[C]laude [C]onversational session" })
keymap.set("n", "<leader>cr", claude_continue, { desc = "[C]laude [R]esume last conversation" })
keymap.set("n", "<leader>cf", claude_with_file, { desc = "[C]laude with current [F]ile context" })
keymap.set("v", "<leader>cs", claude_with_selection, { desc = "[C]laude with [S]election context" })
keymap.set("n", "<leader>cp", claude_project_context, { desc = "[C]laude with [P]roject context" })
keymap.set("n", "<leader>ch", function() 
  vim.cmd("terminal claude --help") 
end, { desc = "[C]laude [H]elp" })