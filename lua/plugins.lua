-- ... (lazy.nvim setup) ...

-- Load basic Neovim options
require("options")

-- Load lazy.nvim plugin definitions
require("lazy").setup({
  -- ... (your plugins go here, or you can require a 'plugins' module)
  -- Example: if you put all plugin definitions in lua/plugins.lua:
  -- require("plugins")
})

-- Load keymaps (after plugins are set up, as keymaps might depend on plugins)
require("keymaps")

-- Setup autocompletion, LSP, treesitter, etc.
require("cmp")
require("lsp")
require("treesitter")
