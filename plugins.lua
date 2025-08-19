local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	
	-- colorscheme 
	{ "shaunsingh/nord.nvim" },


	-- auto closing brackets 
	{
		"windwp/nvim-autopairs",
		event= "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	
	-- autocomplete
	{
		"Saghen/blink.cmp",

		dependencies = { "rafamadriz/friendly-snippets" },
		version = "*",

		opts = {
			keymap = {
				preset = "none",

				["<Tab>"] = { "accept", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },

				-- scrolling documentation
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },

				["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		}

	},

	-- mason for lsp 
	{ "mason-org/mason.nvim", opts = {} },
		{
			"mason-org/mason-lspconfig.nvim",
			dependencies = {
				"mason-org/mason.nvim",
				"neovim/nvim-lspconfig",
			},

			opts = {
				ensure_installed = {
					"pylsp",
					"html",
					"cssls",
					"ts_ls",
					"clangd",
				},
			},

		},



		-- lsp config 
	{
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")
    local on_attach = function(_, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    end

    lspconfig.pylsp.setup({
			cmd = { vim.fn.stdpath("data") .. "/mason/bin/pylsp" },
      on_attach = on_attach,
      settings = {
        pylsp = {
          plugins = {
            pyflakes = { enabled = true },
            pycodestyle = {
              enabled = true,
              ignore = { "E501", "E302", "E305" },
              maxLineLength = 120,
            },
            mccabe = { enabled = false },
            pylint = { enabled = false },

            -- rope: disable old, enable new
            rope_rename = { enabled = false },
            pylsp_rope = { rename = true },
          },
        },
      },
    })

    lspconfig.html.setup({ on_attach = on_attach })
    lspconfig.cssls.setup({ on_attach = on_attach })
    lspconfig.ts_ls.setup({ on_attach = on_attach })
    lspconfig.clangd.setup({ on_attach = on_attach })
  end,
},
	
	--nvim.tree
	{
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("nvim-tree").setup({})
		vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true})
	end,
},

  --claude-code 
  {
		"greggh/claude-code.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("claude-code").setup({
				refresh = {
					enable = true,
					updatetime = 100,
					timer_interval = 1000,
					show_notifications = true,
				},
			})
		end
	}	


})
