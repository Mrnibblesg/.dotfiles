return {
  'neovim/nvim-lspconfig',
  branch='master',
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
    local configs = require("lspconfig")
    -- Remember to get your language servers!!! Check :h lspconfig-all and find the section for your specific language.
    -- If it's not there, you can also define your own.
    configs.lua_ls.setup {}
    configs.clangd.setup {}

  end,
}
