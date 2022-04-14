local BASE_SOURCES = {
  { name = 'path' },
  { name = 'buffer' },
  { name = 'emoji' },
  { name = 'latex_symbols' },
}

return function()
  local cmp = require('cmp')
  local lspkind = require('lspkind')

  cmp.setup {
    sources = cmp.config.sources(
      {
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_document_symbol' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'snippy' },
      },
      BASE_SOURCES
    ),
    snippet = {
      expand = function(args)
        require('snippy').expand_snippet(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert {
      ['<Tab>'] = cmp.mapping {
        i = cmp.mapping.confirm { select = true },
      },
      ['<CR>'] = cmp.mapping {
        i = cmp.mapping.confirm {},
        c = cmp.mapping.confirm { select = false },
      },
      ['<C-e>'] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      ['<C-Up>'] = cmp.mapping {
        c = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
      },
      ['<C-Down>'] = cmp.mapping {
        c = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
      },
    },
    formatting = {
      format = lspkind.cmp_format {},
    },
    preselect = cmp.PreselectMode.None,
    view = {
      entries = 'native',
    },
  }

  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    },
  })
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
      {
        { name = 'path' },
      },
      {
        {
          name = 'cmdline',
          max_item_count = 25,
        },
      }
    ),
    completion = {
      keyword_length = 2,
    },
  })

  vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'noselect', 'preview' }

  vim.aufiletype('lua', function()
    cmp.setup.buffer {
      sources = cmp.config.sources(
        {
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' },
          { name = 'snippy' },
        },
        BASE_SOURCES
      ),
    }
  end)
  vim.aufiletype('norg', function()
    cmp.setup.buffer {
      sources = cmp.config.sources(
        {
          { name = 'neorg' },
        },
        BASE_SOURCES
      ),
    }
  end)

  vim.autocmd('BufRead', 'Cargo.toml', function()
    cmp.setup.buffer {
      sources = cmp.config.sources(
        {
          { name = 'crates' },
        },
        BASE_SOURCES
      ),
    }
  end)
  vim.autocmd('BufRead', 'package.json', function()
    cmp.setup.buffer {
      sources = cmp.config.sources(
        {
          { name = 'npm' },
        },
        BASE_SOURCES
      )
    }
  end)
end
