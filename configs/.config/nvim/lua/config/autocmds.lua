-- [[ Basic Autocommands ]].
-- Sync clipboard between OS and Neovim. Schedule the setting after `UiEnter` because it can
-- increase startup-time. Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.o.clipboard = 'unnamedplus'
  end,
})
-- See `:h lua-guide-autocommands`, `:h autocmd`, `:h nvim_create_autocmd()`

-- Highlight when yanking (copying) text.
-- Try it with `yap` in normal mode. See `:h vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank()
  end,
})
-- This was provided in the vim manual but we're using lua not vimscript. I have yet to translate this one TODO
   -- augroup RestoreCursor
   -- autocmd!
   --   autocmd BufReadPre * autocmd FileType <buffer> ++once
   --     \ let s:line = line("'\"")
   --     \ | if s:line >= 1 && s:line <= line("$") && &filetype !~# 'commit'
   --     \      && index(['xxd', 'gitrebase'], &filetype) == -1
   --     \ |   execute "normal! g`\""
   --     \ | endif
   -- augroup END
   --



