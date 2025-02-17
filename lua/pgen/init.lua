require("pgen.remap")
require("pgen.set")
require("pgen.packer")
require('lualine').setup()
require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "rust_analyzer", "clangd", "pylsp"},
}
require("autoclose").setup()

