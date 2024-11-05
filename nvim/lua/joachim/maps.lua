vim.g.mapleader = " "

-- General mappings
local function map(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

-- Save and Quit
map("n", "<leader>w", "<CMD>update<CR>", "Save file")
map("n", "<leader>q", "<CMD>q<CR>", "Quit Neovim")

-- Exit insert mode
map("i", "jk", "<ESC>", "Exit insert mode")

-- NeoTree
map("n", "<leader>e", "<CMD>Neotree toggle<CR>", "Toggle NeoTree")
map("n", "<leader>r", "<CMD>Neotree focus<CR>", "Focus NeoTree")

-- New Windows
map("n", "<leader>o", "<CMD>vsplit<CR>", "Vertical split")
map("n", "<leader>p", "<CMD>split<CR>", "Horizontal split")

-- Window Navigation
map("n", "<C-h>", "<C-w>h", "Navigate left")
map("n", "<C-l>", "<C-w>l", "Navigate right")
map("n", "<C-k>", "<C-w>k", "Navigate up")
map("n", "<C-j>", "<C-w>j", "Navigate down")

-- Resize Windows
map("n", "<C-Left>", "<C-w><", "Resize left")
map("n", "<C-Right>", "<C-w>>", "Resize right")
map("n", "<C-Up>", "<C-w>+", "Resize up")
map("n", "<C-Down>", "<C-w>-", "Resize down")

-- LSP-specific mappings
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local function lsp_map(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		lsp_map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
		lsp_map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
		lsp_map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
		lsp_map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
		lsp_map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
		lsp_map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
		lsp_map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
		lsp_map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		lsp_map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	end,
})
