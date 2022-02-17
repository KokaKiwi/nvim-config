" Vim syntax file
" Language:     grapeconf
" Maintainer:   KokaKiwi <kokakiwi+dev@kokakiwi.net>
" Last Change:  2020 April

finish
if exists('b:current_syntax')
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

let s:ident_regex = '\<[a-zA-Z_][a-zA-Z0-9_\-]*\>'
let s:path_regex = s:ident_regex . '\(\.' . s:ident_regex . '\)*'

let s:number_regex = '-\?\(0\|[1-9][0-9_]*\)'
let s:float_regex = s:number_regex . '\(\.[0-9_]\+\)\?\([eE][+\-]\?[0-9]\+\)\?'
let s:range_regex = s:number_regex . '\.\.\.\?' . s:number_regex . '\(\.\.' . s:number_regex . '\)\?'

syn cluster grapeConfValue    contains=grapeConfBoolean,grapeConfConstant
syn cluster grapeConfValue    add=grapeConfNumber,grapeConfFloat,grapConfRange
syn cluster grapeConfValue    add=grapeConfTag,grapeConfString
syn cluster grapeConfValue    add=grapeConfList,grapeConfTuple

syn keyword grapeConfBoolean  true false
syn keyword grapeConfConstant nil null none

call kiwi#syntax#match('grapeConfNumber', '/' . s:number_regex . '/')
call kiwi#syntax#match('grapeConfFloat', '/' . s:float_regex . '/')
call kiwi#syntax#match('grapeConfRange', '/' . s:range_regex . '/')

call kiwi#syntax#match('grapeConfTag', '/:' . s:ident_regex . '/')

syn region  grapeConfString       start='"' end='"' contains=grapeConfStringEscape
syn match   grapeConfStringEscape /\\\%(["\\bfnrt]\|u[[:xdigit:]]\{4}\)/ contained

call kiwi#syntax#match('grapeConfIdent', '/' . s:ident_regex . '/')
call kiwi#syntax#match('grapeConfPath', '/' . s:path_regex . '/')
call kiwi#syntax#match('grapeConfTagPath', '/:' . s:path_regex . '/')

syn region  grapeConfDict         start='{'  end='}'  fold transparent
syn region  grapeConfList         start='\[' end='\]' fold contains=@grapeConfValue
syn region  grapeConfTuple        start='('  end=')'       contains=@grapeConfValue

call kiwi#syntax#region('grapeConfMeta',
      \ 'matchgroup=grapeConfMetaTag',
      \ 'start=/\$' . s:ident_regex . '/',
      \ 'end=/$/',
      \ 'contains=grapeConfMetaNamedArg,@grapeConfValue',
      \ 'oneline'
      \)
call kiwi#syntax#match('grapeConfMetaNamedArg', '/' . s:ident_regex . '\s*:/',
      \ 'nextgroup=@grapeConfValue',
      \ 'contains=grapeConfIdent'
      \)

syn match   grapeConfComment      /#.*/ contains=@Spell,grapeConfTodo
syn keyword grapeConfTodo         TODO FIXME XXX BUG contained

hi def link grapeConfBoolean      Boolean
hi def link grapeConfConstant     Constant

hi def link grapeConfNumber       Number
hi def link grapeConfFloat        Float
hi def link grapeConfRange        grapeConfNumber

hi def link grapeConfTag          Constant

hi def link grapeConfString       String
hi def link grapeConfStringEscape SpecialChar

hi def link grapeConfIdent        Identifier
hi def link grapeConfPath         grapeConfIdent
hi def link grapeConfTagPath      Boolean

hi def link grapeConfMetaTag      Macro

hi def link grapeConfComment      Comment
hi def link grapeConfTodo         Todo

unlet s:ident_regex s:path_regex s:number_regex s:float_regex

let b:current_syntax = 'grapeconf'

let &cpo = s:cpo_save
unlet s:cpo_save
