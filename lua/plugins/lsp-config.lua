return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "tsserver" }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { 'j-hui/fidget.nvim', opts = {} },
      'folke/neodev.nvim'
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      lspconfig.tsserver.setup({
        capabilities = capabilities
      })
      lspconfig.html.setup({
        capabilities = capabilities
      })
      lspconfig.angularls.setup({
        capabilities = capabilities
      })
      lspconfig.tailwindcss.setup({
        capabilities = capabilities
      })
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities
      })
      local cwd = vim.fn.getcwd()
      local project_library_path = cwd .. "/node_modules"
      local cmd = { "ngserver", "--stdio", "--tsProbeLocations", project_library_path, "--ngProbeLocations",
        project_library_path }
      local new_root_dir = require('lspconfig.util').root_pattern('angular.json')

      lspconfig.angularls.setup {
        capabilities = capabilities,
        cmd = cmd,
        root_dir = new_root_dir,
        on_new_config = function(new_config)
          new_config.cmd = cmd
        end,
      }
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "LSP: hover over code" })
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "LSP: Go to definition" })
      vim.keymap.set({ 'n' }, '<leader>ca', vim.lsp.buf.code_action, { desc = "LSP: Show code action" })
      vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
          underline = true,
          virtual_text = {
            spacing = 5,
            severity_limit = 'Warning',
          },
          update_in_insert = true,
        })
    end
  }
}
