" Vim syntax helpers
" Author:   KokaKiwi
" License:  BSD-3-Clause
" Version:  0.1.0

function kiwi#syntax#yamlFrontmatter()
  syn include @Yaml syntax/yaml.vim
  syn region yamlFrontmatter start='\%^---$' end='^---$' contains=@Yaml
endfunction

function kiwi#syntax#match(name, pattern, ...)
  exec kiwi#command#make('syntax', 'match', a:name, a:pattern, a:000)
endfunction

function kiwi#syntax#region(name, ...)
  exec kiwi#command#make('syntax', 'region', a:name, a:000)
endfunction

function kiwi#syntax#keyword(name, ...)
  exec kiwi#command#make('syntax', 'keyword', a:name, a:000)
endfunction
