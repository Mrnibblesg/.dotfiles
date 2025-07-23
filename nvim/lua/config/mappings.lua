local telescope = require('telescope.builtin')

-- [[ Set up keymaps ]] See `:h vim.keymap.set()`, `:h mapping`, `:h keycodes`
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

vim.keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-n><C-w>l')
vim.keymap.set({ 'n' }, '<A-h>', '<C-w>h')
vim.keymap.set({ 'n' }, '<A-j>', '<C-w>j')
vim.keymap.set({ 'n' }, '<A-k>', '<C-w>k')
vim.keymap.set({ 'n' }, '<A-l>', '<C-w>l')

--Helpful for changing configs
vim.keymap.set({ 'n' }, '<leader><leader>x', '<cmd>source %<CR>')
vim.keymap.set({ 'n' }, '<leader>x', '<cmd>.lua<CR>')
vim.keymap.set({ 'v' }, '<leader>x', ':lua<CR>')

-- [[ Create user commands ]]
-- See `:h nvim_create_user_command()` and `:h user-commands`
-- Create a command `:GitBlameLine` that print the git blame for the current line
vim.api.nvim_create_user_command('GitBlameLine', function()
  local line_number = vim.fn.line('.') -- Get the current line number. See `:h line()`
  local filename = vim.api.nvim_buf_get_name(0)
  print(vim.fn.system({ 'git', 'blame', '-L', line_number .. ',+1', filename }))
end, { desc = 'Print the git blame for the current line' })

vim.api.nvim_create_user_command('DiffOrig', function()
  vim.cmd([[
  vert new
  setlocal buftype=nofile
  read ++edit #
  0delete _
  diffthis
  wincmd p
  diffthis
  ]])
end, {})
