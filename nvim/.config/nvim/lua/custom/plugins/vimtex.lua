return {
	"lervag/vimtex",
	lazy = false, -- lazy-loading will disable inverse search
	config = function()
		vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
		vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
		-- Set Zathura as the PDF viewer
		vim.g.vimtex_view_method = "zathura"
		vim.g["vimtex_indent_enabled"] = 0 -- Auto Indent
		vim.g["tex_flavor"] = "latex" -- how to read tex files
		vim.g["tex_indent_items"] = 0 -- turn off enumerate indent
		vim.g["tex_indent_brace"] = 0 -- turn off brace indent
		vim.g["vimtex_context_pdf_viewer"] = "okular" -- external PDF viewer run from vimtex menu command
		vim.g["vimtex_log_ignore"] = { -- Error suppression:
			"Underfull",
			"Overfull",
			"specifier changed to",
			"Token not allowed in a PDF string",
		}
	end,
}
