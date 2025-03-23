-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.1',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
}

use 'm4xshen/autoclose.nvim'
use 'nvim-tree/nvim-web-devicons'

use {
  --  "savq/melange-nvim",
    "folke/tokyonight.nvim",
  --"rose-pine/neovim",
 --'f4z3r/gruvbox-material.nvim',
 -- 'sainnhe/everforest',
  --as = 'gruvbox-material',
 -- as = 'rose-pine',
    as = 'tokyonight',
  config = function()
     vim.cmd('colorscheme tokyonight-night')
     --vim.cmd('colorscheme gruvbox-material')
  end
}




--use {
-- "folke/trouble.nvim",
-- config = function()
--   -- Setup Trouble with default (or custom) options:
--   require("trouble").setup({
--     -- Put any custom options here; leave empty for defaults.
--   })
--
--   -- Define your key mappings:
--   vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { noremap = true, silent = true, desc = "Diagnostics (Trouble)" })
--   vim.api.nvim_set_keymap("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { noremap = true, silent = true, desc = "Buffer Diagnostics (Trouble)" })
--   vim.api.nvim_set_keymap("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { noremap = true, silent = true, desc = "Symbols (Trouble)" })
--   vim.api.nvim_set_keymap("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { noremap = true, silent = true, desc = "LSP Definitions / references / ... (Trouble)" })
--   vim.api.nvim_set_keymap("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { noremap = true, silent = true, desc = "Location List (Trouble)" })
--   vim.api.nvim_set_keymap("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { noremap = true, silent = true, desc = "Quickfix List (Trouble)" })
-- end,
--}

  use {
  'folke/todo-comments.nvim',
  event = 'VimEnter',           -- Lazy-load on VimEnter
  requires = { 'nvim-lua/plenary.nvim' },
  config = function()
    require("todo-comments").setup {
      -- ... add other config options here ...
    }
  end
}

use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
use('ThePrimeagen/harpoon')
use('mbbill/undotree')
use('tpope/vim-fugitive')
use('hrsh7th/nvim-cmp')
use('hrsh7th/cmp-nvim-lsp')



use {
	  "VonHeikemen/lsp-zero.nvim",
	  branch = "v1.x",
	  requires = {
		  -- LSP Support
		  {"neovim/nvim-lspconfig"},
		  {"williamboman/mason.nvim"},
		  {"williamboman/mason-lspconfig.nvim"},

		  -- Autocompletion
		  {"hrsh7th/nvim-cmp"},
		  {"hrsh7th/cmp-buffer"},
		  {"hrsh7th/cmp-path"},
		  {"saadparwaiz1/cmp_luasnip"},
		  {"hrsh7th/cmp-nvim-lsp"},
		  {"hrsh7th/cmp-nvim-lua"},

		  -- Snippets
		  {"L3MON4D3/LuaSnip"},
		  {"rafamadriz/friendly-snippets"},
	  }
  }

use {
  "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = { 
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  }

use {
  'nvim-lualine/lualine.nvim',
  requires = { 'nvim-tree/nvim-web-devicons', opt = true }
}

end)
