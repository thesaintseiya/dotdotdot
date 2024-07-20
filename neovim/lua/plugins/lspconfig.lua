return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "folke/lazydev.nvim", ft = "lua", opts = {} },
    { "williamboman/mason.nvim", opts = {} },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local lspconfig = require "lspconfig"

    local on_attach = function()
      local telescope = require "telescope.builtin"

      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration)

      vim.keymap.set("n", "gd", telescope.lsp_definitions)
      vim.keymap.set("n", "gr", telescope.lsp_references)
      vim.keymap.set("n", "gD", telescope.lsp_type_definitions)
      vim.keymap.set("n", "gI", telescope.lsp_implementations)
      vim.keymap.set("n", "<leader>ds", telescope.lsp_document_symbols)
      vim.keymap.set("n", "<leader>ws", telescope.lsp_dynamic_workspace_symbols)
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    local servers = {
      "gopls",
      "lua_ls",
      "rust_analyzer",
      "volar",
    }

    require("mason-tool-installer").setup { ensure_installed = servers }

    require("mason-lspconfig").setup_handlers {
      function(server_name)
        lspconfig[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
        }
      end,

      ["lua_ls"] = function()
        lspconfig.lua_ls.setup {
          settings = {
            Lua = {
              completion = {
                displayContext = 1,
                callSnippet = "Both",
              },
              diagnostics = { disable = { "missing-fields" } },
            },
          },
        }
      end,
    }
  end,
}
