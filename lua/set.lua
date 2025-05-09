-- Indentation
vim.opt.tabstop = 2                 -- Number of spaces a tab counts for
vim.opt.shiftwidth = 2              -- Number of spaces to use for autoindent
vim.opt.expandtab = true            -- Use spaces instead of tabs
vim.opt.smartindent = true          -- Smart autoindenting when starting a new line

-- UI settings
vim.opt.number = true               -- Show line numbers
vim.opt.relativenumber = true       -- Show relative line numbers
vim.opt.scrolloff = 8               -- Keep 8 lines above/below cursor when scrolling

-- Behavior
vim.opt.clipboard = 'unnamedplus'   -- Use system clipboard
vim.opt.cpoptions = 'aABceFs_'      -- Vi compatibility options

vim.api.nvim_create_autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 200,
        })
    end,
})

-- Leader key
vim.g.mapleader = ' '               -- Set leader key to space


