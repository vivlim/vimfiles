# viv's neovim config

it's a big pile of stuff I've grafted together. using [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management and which-key so I don't have to hold all the bindings in my head

## per-machine project dir config

Create `$HOME/.nvim_project_dirs.lua`

Example:

```
return {
    { path = os.getenv("home").."/notes/", alias="notes", },
    { path = "s:/scratch/", alias="scratch", },
}
```

