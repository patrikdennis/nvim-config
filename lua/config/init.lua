require("config.remap")
require("config.packer")

require('lualine').setup()
require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "rust_analyzer", "clangd", "pylsp", "pyright", "ts_ls" },
}
require("autoclose").setup()

require("config.set")


vim.diagnostic.config({
  virtual_text = {
    spacing = 10,
  },
  signs = true,
  underline = false,
  update_in_insert = false,
})

