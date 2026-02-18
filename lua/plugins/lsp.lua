return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
      -- LSP configurations
      local lspconfig = require('lspconfig')
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local luasnip = require('luasnip')

      require("fidget").setup({})

      -- Basic LSP setups
      -- vim.lsp.config('gopls', {})
      -- vim.lsp.config('angularls', {})
      -- vim.lsp.config('html', {})
      -- vim.lsp.config('tailwindcss', {})
      vim.lsp.enable('dartls')
      vim.lsp.enable('pyright')
      vim.lsp.enable('ts_ls')
      vim.lsp.enable('gopls')
      -- vim.lsp.enable('ts_ls')
      -- vim.lsp.config('pyright', {
      --   cmd = { 'pyright-langserver', '--stdio' },
      --   filetypes = { 'python' },
      --   capabilities = capabilities,
      --   root_markers = {
      --     'pyproject.toml',
      --     'setup.py',
      --     'setup.cfg',
      --     'requirements.txt',
      --     'Pipfile',
      --     'pyrightconfig.json',
      --     '.git',
      --   },
      -- })
      
      -- Vue setup
      -- lspconfig.volar.setup{
      --   filetypes = { 'vue' },
      -- }
      --
      -- LSP setups with capabilities
      -- lspconfig.angularls.setup {
      --   capabilities = capabilities,
      -- }

      -- lspconfig.tailwindcss.setup {
      --   filetypes = { 'css' },
      --   capabilities = capabilities,
      -- }

      -- lspconfig.html.setup {
      --   capabilities = capabilities,
      -- }

      -- vim.lsp.config('dartls', {
      --   capabilities = capabilities,
      -- }

      -- TypeScript setup
      -- lspconfig.ts_ls.setup {
      --   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact' },
      --   init_options = {
      --     plugins = {
      --       {
      --         name = "@vue/typescript-plugin",
      --         location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
      --         languages = {"javascript", "typescript", "vue"},
      --       },
      --     },
      --   },
      --   capabilities = capabilities,
      -- }

      -- Rust setup
      -- lspconfig.rust_analyzer.setup {
      --   capabilities = capabilities,
      -- }

      vim.api.nvim_create_autocmd('ModeChanged', {
        pattern = '*',
        callback = function()
          if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
              and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
              and not require('luasnip').session.jump_active
          then
            require('luasnip').unlink_current()
          end
        end
      })

      -- LSP keybindings
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<C-b>', vim.lsp.buf.format, opts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
          vim.keymap.set('n', '<space>cd', vim.diagnostic.open_float, opts)
        end,
      })

      local cmp = require('cmp')
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
          ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm {
            select = false,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif luasnip.jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = {
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
        },
      }
    end
}
