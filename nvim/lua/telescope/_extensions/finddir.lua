local telescope = require "telescope"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local directories = function(opts)
  if vim.fn.executable('fd') == 0 then
    vim.api.nvim_echo({{"You must have 'fd' installed to use directory find."}}, false, {err=true})
    return
  end
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Directory",
    finder = finders.new_oneshot_job({"fd", "--type=d"}, opts),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.cmd("Vex " .. selection[1])
      end)
      return true
    end,
  }):find()
end

return telescope.register_extension {
  exports = {
    finddir = directories
  }
}
