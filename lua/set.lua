-- Line Number Settings:
-- Show absolute line numbers on the left and relative numbers for easier movement with commands like 'j' and 'k'.
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation and Tabs:
-- Set the width of a tab character to 4 spaces.
-- When indenting with '>', '<', or autoindent, use 4 spaces.
-- Convert tabs to spaces for consistent formatting across different editors.
-- Enable smart indentation based on the syntax and context of the code.
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- File Backup and Undo:
-- Disable creation of swap and backup files to avoid clutter and potential conflicts.
-- Set a custom directory for storing undo history and enable persistent undo so changes can be reverted even after closing files.
vim.opt.swapfile = false
-- vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Search Behavior:
-- Enable incremental search so matches are shown as you type.
-- Make searches case-insensitive unless the search pattern contains uppercase letters, in which case the search becomes case-sensitive.
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- UI Enhancements:
-- Always show the sign column (used for git, diagnostics, etc.) to prevent text shifting.
-- Highlight the 80th column to encourage line length discipline.
-- Reduce the time (in ms) before triggering the swap file write or CursorHold event, making the editor more responsive.
-- Keep at least 8 lines visible above and below the cursor when scrolling for better context.
-- Display the current mode (e.g., -- INSERT --) in the command area.
-- vim.opt.signcolumn = "yes"
-- vim.opt.colorcolumn = "80"
-- vim.opt.updatetime = 50
vim.opt.scrolloff = 8
-- vim.opt.showmode = true
vim.g.mapleader = ' '               -- Set leader key to space
vim.opt.clipboard="unnamed"

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


