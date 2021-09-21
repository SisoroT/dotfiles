local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
    completion = {
      completeopt = "menuone,noinsert",
    },
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),
    },
    formatting = {
        format = function(entry, vim_item)
          vim_item.kind = lspkind.presets.default[vim_item.kind]
          return vim_item
        end
    },
    -- You should specify your *installed* sources.
    sources = {
        { name = 'buffer' },
        { name = 'path' },
        { name = 'vsnip' },
        { name = 'calc' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
    },
})
