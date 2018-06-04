-- Rust
vim.g.rustfmt_autosave = 1

-- Elixir
vim.g.mix_format_on_save = 1

-- deoplete.nvim
vim.g['deoplete#enable_at_startup'] = 1

-- neosnippet
if vim.fn.has('conceal') == 1 then
  vim.opt.conceallevel = 2
  vim.opt.concealcursor = 'niv'
end

-- Neoformat
prefixed(vim.g, 'neoformat') {
  enabled_c = { 'clang-format' },
  enabled_cpp = { 'clang-format' },
  enabled_python = { 'yapf', 'isort' },
}
