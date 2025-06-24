-- BOOTSTRAP LAZY.NVIM FIRST
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

-- BASIC GLOBAL OPTIONS (independent of plugins)
-- These should be set early and only once.
-- Ensure these don't conflict with any plugin setup that might override them.

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.opt.nu = true              -- Line numbers
vim.opt.relativenumber = true  -- Relative line numbers
vim.opt.tabstop = 4            -- Tab size
vim.opt.shiftwidth = 4         -- Shift (indent) size
vim.opt.expandtab = true       -- Use spaces instead of tabs
vim.opt.smartindent = true     -- Smart auto-indent
vim.opt.hlsearch = true        -- Highlight search results
vim.opt.incsearch = true       -- Incremental search
vim.opt.mouse = "a"            -- Enable mouse in all modes
vim.opt.termguicolors = true   -- Enable true color support
vim.opt.conceallevel = 0       -- Show actual characters, not concealed ones
vim.opt.fileencoding = "utf-8" -- Set file encoding
vim.opt.undofile = true        -- Persist undo history
vim.opt.swapfile = false       -- Don't create swap files
vim.opt.signcolumn = "yes"     -- Always show the sign column
vim.opt.guicursor = ""
vim.opt.scrolloff = 8
vim.opt.cursorline = true
-- Set leader key (commonly used for custom keybindings)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.colorcolumn = "100"

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv-gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", '<leader>n', ':Neotree filesystem reveal left<CR>', {})

-- Each plugin will have its own table with config = function() ... end
-- This ensures plugin setup only runs AFTER the plugin itself is loaded by lazy.nvim.

require("lazy").setup({

    { "folke/lazy.nvim",            version = "*" },
    {
        --"catppuccin/nvim",
        -- "EdenEast/nightfox.nvim" ,
        -- "savq/melange-nvim",
        "folke/tokyonight.nvim",
        name = "tokyonight",
        priority = 1000,
        config = function()
            -- Set the colorscheme AFTER the plugin has been loaded
            vim.cmd.colorscheme("tokyonight-night")
        end,
    },

    -- Autopairs
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({}) -- Basic setup
        end,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind-nvim",
        },
        -- Call the cmp.lua configuration file
        config = function()
            require("my_cmp_config") -- This calls lua/cmp.lua to set up nvim-cmp
        end,
    },

    -- Git integration
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({}) -- Basic setup
        end,
    },
    -- Status Line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            -- Load the custom Eviline configuration from your lua/evillualine.lua file
            require("evillualine")
        end,
    },
    --    {
    --        "jose-elias-alvarez/null-ls.nvim",
    --        branch       = "main", -- makes sure you get the fix
    --        dependencies = { "nvim-lua/plenary.nvim" },
    --    },

    -- LSP Support
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            --         "jose-elias-alvarez/null-ls.nvim",
        },
        -- Call the lsp.lua configuration file
        config = function()
            require("lsp") -- This calls lua/lsp.lua to set up LSP
        end,
    },

    -- File Explorer
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        config = function()
            require("nvim-tree").setup({
                sort_by = "case_sensitive",
                view = {
                    width = 30,
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = true,
                },
            })
        end,
    },

    -- Icons (dependency for nvim-tree and lualine, put it before them if possible)
    { "nvim-tree/nvim-web-devicons" },

    -- Fuzzy Finder
    {
        "nvim-telescope/telescope.nvim",
        branch       = "master",
        dependencies = { "nvim-lua/plenary.nvim" },
        config       = function()
            require("telescope").setup({
                -- Your telescope config here (optional)
            })
        end,
    },

    -- Tree-sitter for syntax highlighting and more
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        -- Call the treesitter.lua configuration file
        config = function()
            require("treesitter") -- This calls lua/treesitter.lua to set up treesitter
        end,
    },

    {
        "rafamadriz/friendly-snippets",
        dependencies = { "nvim-cmp", "LuaSnip" }, -- Ensure these are loaded first
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },

}, {
    -- Lazy.nvim options, if any
    -- For example, to ensure all plugins are loaded on startup:
    -- lazy = true,
})

-- KEYBINDINGS (dependent on plugins, so loaded after lazy.setup completes)
-- Ensure this is after lazy.setup to allow plugins to register commands/functions
-- that keymaps might call.
require("keymaps")
