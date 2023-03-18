_default:

sync:
  nvim --headless "+Lazy! sync" +qa

commit:
  yadm add lazy-lock.json
  -yadm commit -m 'nvim: Update plugins'

amend:
  yadm add lazy-lock.json
  yadm commit --amend --no-edit

upgrade: sync commit
aupgrade: sync amend

update:
  nvim --headless +TSUpdateSync +qa

push:
  yadm push -f origin main
  env -C $HOME yadm subtree split -P .config/nvim -b split/nvim
  yadm push -f nvim split/nvim:main
  yadm branch -D split/nvim
