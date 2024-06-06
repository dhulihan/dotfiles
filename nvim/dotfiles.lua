local Foo = function() print("hello") end

vim.api.nvim_create_user_command("Foo", Foo)
