" Vim filetype plugin file
" Language:       systemd files
" Maintainer:     KokaKiwi <kokakiwi+vim@kokakiwi.net›

if exists('b:did_ftplugin')
  finish
end
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

let b:undo_ftplugin = 'setlocal comments< commentstring< formatoptions<'
setlocal comments=:# commentstring=#\ %s formatoptions-=t formatoptions+=croql

let &cpo = s:cpo_save
unlet s:cpo_save
