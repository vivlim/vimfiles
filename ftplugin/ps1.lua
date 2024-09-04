vim.keymap.set("n", "<leader>le", function() require("powershell").eval() end)
vim.keymap.set("v", "<leader>le", function() require("powershell").eval() end)
vim.keymap.set("n", "<leader>lt", function() require("powershell").toggle_term() end)
