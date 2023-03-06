_default:

upgrade:
  nvim --headless "+Lazy! sync" +qa
  yadm add lazy-lock.json
  -yadm commit -m 'nvim: Update plugins'

aupgrade:
  nvim --headless "+Lazy! sync" +qa
  yadm add lazy-lock.json
  yadm commit --amend --no-edit

update:
  nvim --headless +TSUpdateSync +qa

push:
  yadm push -f origin main
  env -C $HOME yadm subtree split -P .config/nvim -b split/nvim
  yadm push -f nvim split/nvim:main
  yadm branch -D split/nvim
