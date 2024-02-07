_default:

commit:
  yadm add lazy-lock.json
  -yadm commit -m 'nvim: Update plugins'

amend:
  yadm add lazy-lock.json
  yadm commit --amend --no-edit

push:
  yadm push -f origin main
  -yadm -C $HOME subtree -P .config/nvim split -b split/nvim && yadm push -f nvim split/nvim:main
  -yadm branch -D split/nvim

gc:
  yadm gc --aggressive
