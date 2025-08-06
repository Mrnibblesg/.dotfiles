return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      local builtin = require('telescope.builtin')
      local finddir = require('telescope').load_extension('finddir')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
      vim.keymap.set('n', '<leader>fi', builtin.builtin, { desc = 'Telescope finders' })
      vim.keymap.set('n', '<leader>fe', builtin.diagnostics, { desc = 'Telescope diagnostics' })
      vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recently opened files' })
      vim.keymap.set('n', '<leader>fd', finddir.finddir, {desc = 'Directories'})

      vim.keymap.set('n', "<leader>en", function()
        builtin.find_files {
          cwd = vim.fn.stdpath("config")
        }
      end)
      -- Edit config files of this dotfiles repo.
      -- Use a hard-coded relative path.
      vim.keymap.set('n', "<leader>ec", function()
        builtin.find_files {
          cwd = vim.fn.stdpath("config") .. '/..'
          --Configs in this repo use links from the $XDG_CONFIG_DIRS to this repo, so pwd won't represent the correct path upwards.
        }
      end)
    end
  }
}
