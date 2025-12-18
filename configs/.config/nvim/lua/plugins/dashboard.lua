return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      shuffle_letter = true
    }
  end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
}
