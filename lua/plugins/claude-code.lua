return {
  -- Claude Code CLI integration (no API key needed)
  {
    "vim-test/vim-test",
    config = function()
      -- Claude Code integration
      local function ask_claude()
        local question = vim.fn.input("Ask Claude: ")
        if question and question ~= "" then
          local cmd = string.format("claude --print '%s'", question)
          vim.cmd(string.format("terminal %s", cmd))
        end
      end
      
      local function claude_edit_selection()
        -- Get selected text
        local start_pos = vim.fn.getpos("'<")
        local end_pos = vim.fn.getpos("'>")
        local lines = vim.fn.getline(start_pos[2], end_pos[2])
        local selected_text = table.concat(lines, "\n")
        
        local instruction = vim.fn.input("How to modify this code: ")
        if instruction and instruction ~= "" then
          local prompt = string.format("Here's the code:\n```\n%s\n```\n\n%s", selected_text, instruction)
          local cmd = string.format("claude --print '%s'", prompt)
          vim.cmd(string.format("terminal %s", cmd))
        end
      end
      
      -- Claude Code keybindings (no API key required)
      vim.keymap.set("n", "<leader>cc", ask_claude, { desc = "[C]laude [C]hat" })
      vim.keymap.set("v", "<leader>ce", claude_edit_selection, { desc = "[C]laude [E]dit selection" })
      vim.keymap.set("n", "<leader>ch", function() 
        vim.cmd("terminal claude --help") 
      end, { desc = "[C]laude [H]elp" })
    end,
  },
}