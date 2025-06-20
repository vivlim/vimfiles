-- Create an autocommand for "BufRead" events
vim.api.nvim_create_autocmd("BufRead", {
  -- This autocommand will only trigger if the buffer name matches the following patterns
  pattern = { "*wireplumber.conf.d/*.conf" },
  -- The autocommand will trigger the following lua function
  callback = function()
        -- vim.b.makeprg = "systemctl --user --now restart wireplumber"
  end
})

return {}
