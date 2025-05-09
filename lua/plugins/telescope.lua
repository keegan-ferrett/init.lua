return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({})

        local opts = { noremap = true, silent = true }
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, opts)
        vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
        vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
        vim.keymap.set('n', '<leader>fr', '<cmd>Telescope resume<cr>', opts)
        vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opts)

        vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
    end
}
