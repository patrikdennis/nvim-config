-- Define a local variable for cleaner keymap setting
local map = vim.keymap.set

-- Normal mode keymaps
map("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer (Ex)" }) -- Ex mode (default file explorer)
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" }) -- NvimTree file explorer
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "List buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })

-- LSP keymaps (these will be set up when an LSP server attaches)
-- See lsp.lua for on_attach function
