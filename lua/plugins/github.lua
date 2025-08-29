return {
  -- GitHub integration
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require"octo".setup()
      vim.keymap.set("n", "<leader>ghi", "<cmd>Octo issue list<CR>", { desc = "[G]it[H]ub [I]ssues" })
      vim.keymap.set("n", "<leader>ghp", "<cmd>Octo pr list<CR>", { desc = "[G]it[H]ub [P]Rs" })
      vim.keymap.set("n", "<leader>ghr", "<cmd>Octo repo view<CR>", { desc = "[G]it[H]ub [R]epo" })
    end,
  },
  
  -- Git worktree support
  {
    "ThePrimeagen/git-worktree.nvim",
    config = function()
      require("git-worktree").setup()
      require("telescope").load_extension("git_worktree")
      
      vim.keymap.set("n", "<leader>gww", require('telescope').extensions.git_worktree.git_worktrees, { desc = "Git worktrees" })
      vim.keymap.set("n", "<leader>gwc", require('telescope').extensions.git_worktree.create_git_worktree, { desc = "Create git worktree" })
    end,
  },
  
  -- Fugitive for advanced git operations
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status" })
      vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<CR>", { desc = "Git blame" })
      vim.keymap.set("n", "<leader>gd", "<cmd>Gdiffsplit<CR>", { desc = "Git diff split" })
      vim.keymap.set("n", "<leader>gl", "<cmd>Git log<CR>", { desc = "Git log" })
    end,
  }
}