return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig", },

	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = { },

			handlers = {
				function(server_name)
					local capabilities = require('cmp_nvim_lsp').default_capabilities()
					if (server_name == "emmet_language_server")
					then
						require("customconfigs.emmet_setup")
						-- elseif (server_name == "jdtls")
						-- then
						-- 	return
					end
					require("lspconfig")[server_name].setup({ capabilities = capabilities })
				end,
			},
		})
	end,
}
