---@diagnostic disable: redefined-local
local util = require('rc.plugins.util')

-- Setup
local packer = util.require_packer()

util.handlers.register(nil, function(plugin_spec)
  local name = util.plugin_name(plugin_spec)
  local local_plugin_path = string.format('%s/local/%s', vim.fn.stdpath('data'), name)

  if vim.loop.fs_stat(local_plugin_path) then
    plugin_spec[1] = local_plugin_path
  end
end)

util.handlers.register('git_host', function(plugin_spec, host)
  local path = plugin_spec[1]
  if vim.fn.isdirectory(path) then
    return
  end

  plugin_spec[1] = string.format('https://%s/%s', host, path)
end)

return packer.startup {
  config = {
    max_jobs = 8,
    git = {
      subcommands = {
        update = 'pull --progress --rebase',
        update_branch = 'merge @{u}',
      },
    },
    display = {
      open_fn = function()
        return require('packer.util').float {}
      end,
    },
  },
  function(use_plugin, use_rocks)
    local function use(plugin_spec)
      if type(plugin_spec) == 'string' then
        plugin_spec = { plugin_spec }
      end

      util.handlers.handle(plugin_spec)
      use_plugin(plugin_spec)
    end

    local function group(spec)
      local block = spec[1]

      local meta = {}
      for key, value in pairs(spec) do
        if type(key) == 'string' then
          meta[key] = value
        end
      end

      local function _use(plugin_spec)
        if type(plugin_spec) == 'string' then
          plugin_spec = { plugin_spec }
        end

        plugin_spec = vim.tbl_extend('force', plugin_spec, meta)
        use(plugin_spec)
      end

      block(_use)
    end

    use 'wbthomason/packer.nvim'

    -- Utils
    group { group = 'utils', function(use)
      use 'editorconfig/editorconfig-vim'
      use { 'glts/vim-radical',
        requires = { 'glts/vim-magnum' },
        keys = {
          { 'n', 'gA' },
          { 'n', 'crd' },
          { 'n', 'crx' },
          { 'n', 'cro' },
          { 'n', 'crb' },
        }
      }
      use 'hynek/vim-python-pep8-indent'
      use { 'jamessan/vim-gnupg',
        config = util.setup.rc('gnupg'),
      }
      use 'mattn/emmet-vim'
      use { 'ntpeters/vim-better-whitespace',
        config = util.setup.rc('better_whitespace'),
      }
      use { 'nvim-lua/plenary.nvim',
        module = { 'plenary' },
      }
      use { 'nvim-lua/popup.nvim',
        module = { 'popup' },
      }
      use 'prabirshrestha/async.vim'
      use 'mg979/vim-visual-multi'
      use 'tpope/vim-repeat'
      use 'tpope/vim-sensible'
      use 'tpope/vim-surround'
      use 'stsewd/isort.nvim'
      use { 'famiu/bufdelete.nvim',
        cmd = { 'Bdelete', 'Bwipeout' },
        module = { 'bufdelete' },
      }
      use { 'jghauser/mkdir.nvim',
        config = util.setup.mod('mkdir'),
      }
      use { 'numToStr/Comment.nvim',
        config = util.setup.rc('Comment', 'utils'),
      }
      use { 'andweeb/presence.nvim',
        config = util.setup.rc('presence'),
      }

      use 'inkarkat/vim-ingo-library'
      use 'LucHermitte/lh-vim-lib'

      use { 'rafcamlet/nvim-luapad',
        cmd = { 'Luapad', 'Luarun' },
      }
      use { 'metakirby5/codi.vim',
        cmd = { 'Codi' },
      }
      use { 'sQVe/sort.nvim',
        config = util.setup.rc('sort', 'utils'),
        cmd = { 'Sort' },
      }

      use { 'iamcco/markdown-preview.nvim',
        ft = { 'markdown', 'pandoc.markdown', 'rmd' },
        run = util.action.call('mkdp#util#install'),
      }
      use { 'ellisonleao/glow.nvim',
        config = util.setup.rc('glow'),
        cmd = { 'Glow' },
        cond = util.cond.is_executable('glow'),
      }
      use { 'ray-x/viewdoc.nvim',
        requires = { 'ray-x/guihua.lua' },
        config = util.setup.rc('viewdoc', 'utils'),
        cmd = { 'Viewdoc' },
        cond = util.cond.all(
          util.cond.is_executable('fd'),
          util.cond.is_executable('glow')
        ),
      }
      use { 'nvim-neorg/neorg',
        config = util.setup.rc('neorg', 'utils'),
        requires = { 'nvim-lua/plenary.nvim' },
        ft = { 'norg' },
      }
      use { 'thazelart/figban.nvim',
        cmd = { 'Figban' },
        cond = util.cond.is_executable('figlet'),
      }
      use { 'tonyfettes/fcitx5.nvim',
        disable = true,
        config = util.setup.rc('fcitx5', 'utils'),
        -- rocks = { 'dbus_proxy', 'lgi' },
      }

      use 'lewis6991/impatient.nvim'
    end }

    -- Helpers (autocomplete, lint, format, snippets)
    group { group = 'helpers', function(use)
      use 'mhinz/vim-mix-format'

      use { 'saecki/crates.nvim',
        branch = 'main',
        requires = { 'nvim-lua/plenary.nvim' },
        event = { 'BufRead Cargo.toml' },
        config = util.setup.rc('crates'),
      }
      use { 'vuki656/package-info.nvim',
        requires = { 'MunifTanjim/nui.nvim' },
        config = util.setup.rc('package_info', 'helpers'),
        event = { 'BufRead package.json' },
      }

      use { 'hrsh7th/nvim-cmp',
        requires = { 'onsails/lspkind-nvim' },
        config = util.setup.rc_mod_call('cmp'),
      }
      local CMP_SOURCES = {
        'nvim-lsp', 'nvim-lua',
        'buffer', 'path', 'emoji', 'cmdline', 'calc',
        'ray-x/cmp-treesitter', 'David-Kunz/cmp-npm', 'kdheepak/cmp-latex-symbols',
        'dcampos/cmp-snippy',
      }
      for _, spec in ipairs(CMP_SOURCES) do
        if type(spec) == 'string' then
          if spec:find('/') == nil then
            spec = 'hrsh7th/cmp-' .. spec
          end
          spec = { spec }
        end

        spec.after = spec.after or {}
        table.insert(spec.after, 'nvim-cmp')

        use(spec)
      end

      use { 'simrat39/rust-tools.nvim',
        config = util.setup.rc('rust_tools', 'helpers'),
        after = { 'nvim-lspconfig' },
        ft = { 'rust' },
      }
      use 'b0o/SchemaStore.nvim'
      use 'folke/lua-dev.nvim'
      use { 'jose-elias-alvarez/null-ls.nvim',
        config = util.setup.rc('null_ls', 'helpers'),
        requires = { 'nvim-lua/plenary.nvim' },
        module = { 'null-ls' },
      }

      use { 'neovim/nvim-lspconfig',
        config = util.setup.mod_setup('kiwi.lsp'),
        after = { 'cmp-nvim-lsp', 'SchemaStore.nvim', 'lua-dev.nvim' },
      }
      use { 'folke/trouble.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = util.setup.rc('trouble'),
        cmd = { 'Trouble', 'TroubleToggle' },
      }
      use { 'mfussenegger/nvim-lint',
        config = util.setup.rc('lint'),
      }

      use { 'nvim-treesitter/nvim-treesitter',
        run = util.action.cmd('TSUpdate'),
        config = util.setup.rc('treesitter', 'helpers'),
        requires = { 'JoosepAlviste/nvim-ts-context-commentstring' },
      }
      use { 'nvim-treesitter/playground',
        requires = { 'nvim-treesitter/nvim-treesitter' },
      }
      use { 'Julian/lean.nvim',
        config = util.setup.rc('lean'),
        after = { 'nvim-lspconfig' },
      }
      use { 'lukas-reineke/headlines.nvim',
        config = util.setup.rc('headlines', 'helpers'),
        ft = { 'markdown', 'rmd', 'vimwiki', 'org' },
      }
      use { 'klen/nvim-config-local',
        config = util.setup.rc('config_local', 'helpers'),
      }

      use { 'dcampos/nvim-snippy',
        config = util.setup.rc('snippy', 'helpers'),
      }

      use { 'sbdchd/neoformat',
        config = util.setup.rc('neoformat'),
        cmd = { 'Neoformat' },
      }

      use 'jiangmiao/auto-pairs'
      use { 'junegunn/vim-easy-align',
        cmd = { 'EasyAlign' },
      }
    end }

    -- UI
    -- UI > Colorschemes
    group { group = 'colorscheme', function(use)
      use { 'rktjmp/lush.nvim',
        module = { 'lush' },
      }
      use { 'kokakiwi/themer.lua',
        branch = 'kiwi',
        git_host = 'gitlab.kokakiwi.net',
        config = util.setup.mod_call('kiwi.ui.colorscheme'),
      }
    end }

    -- UI > Misc
    group { group = 'ui', function(use)
      use { 'RRethy/vim-illuminate',
        config = util.setup.rc('illuminate'),
        module = { 'illuminate' },
      }
      use { 'norcalli/nvim-colorizer.lua',
        config = util.setup.rc('colorizer'),
      }
      use { 'lukas-reineke/indent-blankline.nvim',
        event = { 'BufReadPre' },
        config = util.setup.rc('blankline'),
      }
      use { 'folke/todo-comments.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = util.setup.rc('todo_comments'),
      }

      use { 'lotabout/skim.vim',
        cmd = { 'Ag', 'Rg' },
      }

      use { 'ctrlpvim/ctrlp.vim',
        config = util.setup.rc('ctrlp'),
        cmd = { 'ctrlp' },
        keys = {
          { 'n', '<C-p>' },
        },
      }
      use 'ripxorip/aerojump.nvim'
      use { 'numToStr/FTerm.nvim',
        config = util.setup.rc('fterm', 'ui'),
        cmd = { 'FTerm', 'Gitui', 'Top', 'Neofetch' },
      }

      use { 'mbbill/undotree',
        config = util.setup.rc('undotree'),
        cmd = { 'UndotreeToggle' },
      }

      use { 'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = util.setup.rc('nvim_tree', 'ui'),
      }
      use { 'luukvbaal/nnn.nvim',
        config = util.setup.rc('nnn', 'ui'),
        condition = util.cond.is_executable('nnn'),
        cmd = { 'NnnExplorer', 'NnnPicker' },
      }
      use { 'LudoPinelli/comment-box.nvim',
        config = util.setup.rc('comment_box', 'ui'),
      }

      use 'tpope/vim-fugitive'
      use { 'kyazdani42/nvim-web-devicons',
        config = util.setup.rc('devicons', 'ui'),
      }

      use { 'akinsho/nvim-bufferline.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = util.setup.mod_call('kiwi.ui.tabline'),
        event = { 'VimEnter' },
      }
      use { 'glepnir/galaxyline.nvim',
        branch = 'main',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = util.setup.mod_call('kiwi.ui.statusline'),
      }
      use { 'nvim-lua/lsp-status.nvim',
        config = util.setup.rc('lsp_status'),
        module = { 'lsp-status' },
      }
      use { 'ray-x/lsp_signature.nvim',
        config = util.setup.rc('lsp_signature', 'ui'),
      }
      use { 'weilbith/nvim-code-action-menu',
        cmd = { 'CodeActionMenu' },
      }
      use { 'folke/which-key.nvim' }
      use { 'mrjones2014/legendary.nvim' }
      use { 'rcarriga/nvim-notify',
        config = util.setup.rc('notify', 'ui'),
        after = { 'nvim-bufferline.lua' },
      }
      use { 'chentau/marks.nvim',
        config = util.setup.rc('marks'),
      }
      use { 'wfxr/minimap.vim',
        config = util.setup.rc('minimap', 'ui'),
        cond = util.cond.is_executable('code-minimap'),
        cmd = { 'Minimap', 'MinimapToggle' },
      }
      use { 'stevearc/aerial.nvim',
        config = util.setup.rc('aerial', 'ui'),
      }

      use { 'xeluxee/competitest.nvim',
        requires = { 'MunifTanjim/nui.nvim' },
        config = util.setup.rc('competitest', 'ui'),
      }

      use { 'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
        module = { 'telescope' },
        cmd = { 'Telescope' },
        config = util.setup.rc('telescope', 'ui'),
        after = { 'aerial.nvim', 'nvim-notify', 'telescope-gradle.nvim' },
      }
      use { 'ray-x/navigator.lua',
        config = util.setup.rc('navigator'),
        requires = {
          { 'ray-x/guihua.lua',
            run = util.action.shell.make('lua/fzy'),
          },
          'neovim/nvim-lspconfig',
        },
        after = { 'nvim-lspconfig' },
      }
      use { 'stevearc/dressing.nvim',
        config = util.setup.rc('dressing', 'ui'),
      }
      use { 'CosmicNvim/cosmic-ui',
        config = util.setup.rc('cosmic', 'ui'),
        requires = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim', 'ray-x/lsp_signature.nvim' },
        after = { 'nvim-lspconfig' },
      }
      use { 'aloussase/telescope-gradle.nvim' }

      use { 'rhysd/committia.vim',
        config = util.setup.rc('committia'),
        event = { 'BufReadPost COMMIT_EDITMSG,MERGE_MSG' },
      }
      use { 'tanvirtin/vgit.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = util.setup.rc('vgit'),
        event = { 'BufWinEnter' },
        cmd = { 'VGit' },
      }

      use { 'goolord/alpha-nvim',
        config = util.setup.mod_call('kiwi.ui.dashboard'),
        event = { 'VimEnter' },
      }

      use { 'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = util.setup.rc('gitsigns', 'ui'),
      }
      use { 'romgrk/nvim-treesitter-context',
        config = util.setup.rc('treesitter_context'),
        requires = { 'nvim-treesitter/nvim-treesitter' },
      }
      use { 'lukas-reineke/virt-column.nvim',
        config = util.setup.rc('virt_column', 'ui'),
      }
      use { 'petertriho/nvim-scrollbar',
        config = util.setup.rc('scrollbar', 'ui'),
      }
    end }

    -- Syntax / Languages
    group { group = 'syntax', function(use)
      use 'godlygeek/tabular'

      use { 'sheerun/vim-polyglot',
        setup = util.setup.rc('polyglot'),
        commit = '2c5af8f89d3e61e04e761c07a1f043b0f35203c6',
      }

      use { 'PProvost/vim-ps1', ft = { 'ps1', 'ps1xml' } }
      use { 'bytecodealliance/cranelift.vim', ft = 'clif', branch = 'main' }
      use { 'cstrahan/vim-capnp', ft = 'capnp' }
      use { 'eiginn/iptables-vim', ft = 'iptables' }
      use { 'ericvw/vim-fish', ft = { 'fish' } }
      use { 'gisphm/vim-gitignore', ft = 'gitignore'}
      use { 'gleam-lang/gleam.vim', ft = 'gleam' }
      use { 'hail2u/vim-css3-syntax', ft = 'css' }
      use { 'hjson/vim-hjson', ft = 'hjson'}
      use { 'jceb/vim-orgmode', ft = 'orgmode'}
      use { 'justinj/vim-pico8-syntax', ft = 'pico8' }
      use { 'kelwin/vim-smali', ft = 'smali' }
      use { 'killphi/vim-ebnf', ft = 'ebnf' }
      use { 'leanprover/lean.vim', ft = 'lean' }
      use { 'moon-musick/vim-logrotate', ft = 'logrotate' }
      use { 'niklasl/vim-rdf', ft = 'rdf' }
      use { 'nikvdp/ejs-syntax', ft = { 'ejs' } }
      use { 'projectfluent/fluent.vim', ft = 'fluent' }
      use { 'ron-rs/ron.vim', ft = 'ron' }
      use { 'thyrgle/vim-dyon', ft = 'dyon' }
    end }

    -- LuaRocks
    use_rocks { 'luasocket', 'luaposix', 'http' }

    -- Automatically setup config after bootstraping packer.nvim
    if packer._bootstrap then
      packer.sync()
    end
  end
}
