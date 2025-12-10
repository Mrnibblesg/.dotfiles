return {
  'neovim/nvim-lspconfig',
  branch = 'master',
  dependencies = {
    {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      }
      -- { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim
    },
  },
  config = function()
    local on_attach = {on_attach = function(client, bufnr)
        vim.api.nvim_set_option_value("signcolumn", "yes", {scope="local"})
    end}
    -- Remember to get your language servers!!! Check :h lspconfig-all and find the section for your specific language.
    -- If it's not there, you can also define your own.
    vim.lsp.config('lua_ls', {
      on_attach = on_attach
    })
    vim.lsp.enable('lua_ls')
    vim.lsp.config('clangd', {
      on_attach = on_attach
    })
    vim.lsp.enable('clangd')
    vim.lsp.config('bashls', {
      on_attach = on_attach
    })
    vim.lsp.enable('bashls')
    vim.lsp.config('pylsp', {
      on_attach = on_attach,
      settings = {
        pylsp = {
          plugins = {
            pycodestyle = {
              ignore = {'E265', 'E501'},
            }
          }
        }
      }
    })
    vim.lsp.enable('pylsp')

  end,
}
