require("render-markdown").setup({
	completions = { lsp = { enabled = true } },
	file_types = { "markdown", "quarto" },
	render_modes = { "n", "c", "t" },
})
