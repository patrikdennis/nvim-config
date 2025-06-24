local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")
local mason = require("mason")
--local null_ls = require("null-ls")

-- Common LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

-- Keybindings for LSP features (on_attach function)
local on_attach = function(client, bufnr)
  -- Enable completion on attach
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Set up keybindings for LSP actions
  local buf_set_keymap = vim.api.nvim_buf_set_keymap
  local opts = { noremap = true, silent = true }

  buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
  buf_set_keymap(bufnr, 'n', '[d', '<cmd>vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap(bufnr, 'n', ']d', '<cmd>vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>vim.diagnostic.setloclist()<CR>', opts)

  -- Autoformat on save (optional, but convenient)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end

-- Setup Mason
mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

-- Configure Mason to install LSP servers automatically
mason_lspconfig.setup({
  ensure_installed = {
    "pyright",      -- Python
    "clangd",       -- C/C++
    "gopls",        -- Go
    "lua_ls",       -- Lua
    --"typescript",   -- JavaScript/TypeScript (if you use it)
    "jsonls",       -- JSON
    "html",         -- HTML
    "cssls",        -- CSS
    "yamlls",       -- YAML
    -- Add more language servers here as needed
  },
  handlers = {
    -- Default handler for all LSP servers installed by Mason
    function(server_name)
      lspconfig[server_name].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  },
})

-- Null-ls for linters and formatters not covered by LSP servers
--    null_ls.setup({
--      sources = {
    --    -- Python
    --    null_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
    --    null_ls.builtins.diagnostics.flake8,
    --    -- Go
--        null_ls.builtins.formatting.gofumpt,
--        null_ls.builtins.formatting.goimports,
        -- C/C++ (clang-format is often provided by clangd)
        -- If clang-format is not picked up by clangd, you might add it here:
        -- null_ls.builtins.formatting.clang_format,
        -- General (e.g., Prettier for web files, markdownlint)
--        null_ls.builtins.formatting.prettier,
--        null_ls.builtins.diagnostics.markdownlint,
--      },
--    })

-- Diagnostics configuration (how errors/warnings are displayed)
vim.diagnostic.config({
  virtual_text = true, -- Show diagnostics inline 
--  virtual_text = {
--      enable = true,
--      align = "right",
--  },
  signs = true,        -- Show signs in the sign column
  update_in_insert = false, -- Don't update diagnostics in insert mode
  float = {            -- Floating window for hover details
    border = "single",
    source = "always",
    header = "",
    prefix = "",
  },
})
