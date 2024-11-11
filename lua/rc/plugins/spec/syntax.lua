local util = require('rc.plugins.util')

return util.module('syntax', function(use)
  use { 'sheerun/vim-polyglot',
    init = util.setup.rc('polyglot', 'syntax'),
  }

  use { 'PProvost/vim-ps1', ft = { 'ps1', 'ps1xml' } }
  use { 'bytecodealliance/cranelift.vim', ft = 'clif', branch = 'main' }
  use { 'cstrahan/vim-capnp', ft = 'capnp' }
  use { 'eiginn/iptables-vim', ft = 'iptables' }
  use { 'gisphm/vim-gitignore', ft = 'gitignore'}
  use { 'gleam-lang/gleam.vim', ft = 'gleam' }
  use { 'hail2u/vim-css3-syntax', ft = 'css' }
  use { 'hjson/vim-hjson', ft = 'hjson'}
  use { 'jceb/vim-orgmode', ft = 'orgmode'}
  use { 'kaarmu/typst.vim', ft = 'typst' }
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
  use { 'fladson/vim-kitty', ft = { 'kitty', 'kitty-session' } }
  use { 'Olical/nfnl', ft = { 'fennel' }, config = true }
  use { 'IndianBoy42/tree-sitter-just', config = true }
end)
