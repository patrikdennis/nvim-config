

function ColorMyPencils(color)
	color = color or "tokyonight-night" 
    --color = color or "gruvbox-material"
	vim.cmd.colorscheme(color)

 
	

    vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
    vim.api.nvim_set_hl(0, "EndOfBuffer",  { bg = "none" })
-- or, if the colorscheme sets it automatically, you may not need to override

end

ColorMyPencils()
