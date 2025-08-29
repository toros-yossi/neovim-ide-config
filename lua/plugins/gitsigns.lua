return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup {
      signs = {
        add          = { text = '+' },
        change       = { text = '~' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      signcolumn = true,
      numhl      = false,
      linehl     = false,
      word_diff  = false,
      watch_gitdir = {
        follow_files = true
      },
      attach_to_untracked = true,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      max_file_length = 40000,
      preview_config = {
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, {expr=true})

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true})

        -- Actions
        map('n', '<leader>hs', gs.stage_hunk, {desc = 'Git stage hunk'})
        map('n', '<leader>hr', gs.reset_hunk, {desc = 'Git reset hunk'})
        map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc = 'Git stage hunk'})
        map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc = 'Git reset hunk'})
        map('n', '<leader>hS', gs.stage_buffer, {desc = 'Git stage buffer'})
        map('n', '<leader>hu', gs.undo_stage_hunk, {desc = 'Git undo stage hunk'})
        map('n', '<leader>hR', gs.reset_buffer, {desc = 'Git reset buffer'})
        map('n', '<leader>hp', gs.preview_hunk, {desc = 'Git preview hunk'})
        map('n', '<leader>hb', function() gs.blame_line{full=true} end, {desc = 'Git blame line'})
        map('n', '<leader>tb', gs.toggle_current_line_blame, {desc = 'Toggle git blame line'})
        map('n', '<leader>hd', gs.diffthis, {desc = 'Git diff against index'})
        map('n', '<leader>hD', function() gs.diffthis('~') end, {desc = 'Git diff against last commit'})
        map('n', '<leader>td', gs.toggle_deleted, {desc = 'Toggle git show deleted'})

        -- Text object
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end
    }
  end,
}