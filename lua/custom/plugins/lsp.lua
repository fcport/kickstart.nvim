return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      local lspconfig = require 'lspconfig'

      -- Configurazione keymaps LSP
      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      end

      -- Configurazione Angular
      lspconfig.angularls.setup {
        on_attach = on_attach,
        root_dir = lspconfig.util.root_pattern('angular.json', 'project.json'),
        cmd = {
          'ngserver',
          '--stdio',
          '--tsProbeLocations',
          vim.fn.getcwd() .. '/node_modules',
          '--ngProbeLocations',
          vim.fn.getcwd() .. '/node_modules/@angular/language-server/node_modules',
        },
      }

      -- Configurazione TypeScript
      lspconfig.tsserver.setup {
        on_attach = on_attach,
        root_dir = lspconfig.util.root_pattern('package.json', 'tsconfig.json'),
        init_options = {
          preferences = {
            includeInlayParameterNameHints = 'all',
            includeInlayEnumMemberValueHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayVariableTypeHints = true,
          },
        },
      }
    end,
  },
}
