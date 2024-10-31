return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup()

		require("mason-lspconfig").setup({
			automatic_installation = true,
			ensure_installed = {
				"html",
				"jsonls",
				"pyright",
				"rust_analyzer", -- Rust
				"clangd", -- C/C++
				"jdtls", -- Java
				"gopls", -- Go
				"omnisharp", -- C#
			},
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"stylua",
				"black",
				"rustfmt", -- Rust formatter
				"clang-format", -- C/C++ formatter
				"golangci-lint", -- Go linter
				"csharpier", -- C# formatter
			},
		})
	end,
}
