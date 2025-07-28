return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    local line = require('lualine')
    line.setup({options = {theme = 'palenight'}})

  end
}
