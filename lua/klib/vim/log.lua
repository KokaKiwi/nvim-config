function vim.log.debug(value)
  if not os.getenv('NVIM_DEBUG') then
    return
  end

  if type(value) == 'string' then
    print('[DEBUG] ' .. value)
  else
    print('[DEBUG] ' .. vim.inspect(value))
  end
end
