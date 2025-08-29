return {
  -- LSP Configuration & Plugins
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
    config = function()
      -- Setup neovim lua configuration
      require('neodev').setup()

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Ensure the servers above are installed
      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup {
        ensure_installed = {
          'lua_ls',
          'rust_analyzer',
          'pyright',
          'ts_ls',
          'gopls',
          'clangd',
          'jdtls',
          'kotlin_language_server',
        },
      }

      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = function(_, bufnr)
              local nmap = function(keys, func, desc)
                if desc then
                  desc = 'LSP: ' .. desc
                end
                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
              end

              nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
              nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
              nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
              nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
              nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
              nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
              nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
              nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
              nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
              nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
              nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
              nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
              nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
              nmap('<leader>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
              end, '[W]orkspace [L]ist Folders')

              -- Create a command `:Format` local to the LSP buffer
              vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                vim.lsp.buf.format()
              end, { desc = 'Format current buffer with LSP' })
            end,
          }
        end,
        ['rust_analyzer'] = function()
          require('lspconfig').rust_analyzer.setup {
            capabilities = capabilities,
            settings = {
              ['rust-analyzer'] = {
                imports = {
                  granularity = {
                    group = "module",
                  },
                  prefix = "self",
                },
                cargo = {
                  buildScripts = {
                    enable = true,
                  },
                },
                procMacro = {
                  enable = true
                },
              },
            },
          }
        end,
        ['lua_ls'] = function()
          require('lspconfig').lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
                diagnostics = { disable = { 'missing-fields' } },
              },
            },
          }
        end,
        ['jdtls'] = function()
          -- Java LSP is handled by nvim-jdtls plugin for better integration
        end,
      }
    end,
  },
  -- Enhanced Java support
  {
    'mfussenegger/nvim-jdtls',
    ft = { 'java' },
  },
}