_default:

commit:
  git add lazy-lock.json
  -git commit -m 'chore: Update plugins'

amend:
  git add lazy-lock.json
  git commit --amend --no-edit

push:
  git push -f origin main
