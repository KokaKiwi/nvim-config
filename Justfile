nvim := 'nvim -u init.lua'

_default:

_nvim-cmd COMMAND:
  NO_BOOTSTRAP=1 {{nvim}} \
    --noplugin --headless \
    -c "{{COMMAND}}" \
    -c quitall

run SCRIPT_NAME: (_nvim-cmd 'lua loadfile(\"scripts/' + SCRIPT_NAME + '.lua\")()')

gen-readme: (run 'gen-readme')
