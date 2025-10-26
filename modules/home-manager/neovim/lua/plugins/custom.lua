-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
	-- add gruvbox
	{ "ellisonleao/gruvbox.nvim" },

	-- Configure LazyVim to load gruvbox
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "gruvbox",
		},
	},

	-- lazygit integration
	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
			{ "<leader>gf", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit Current File" },
			{ "<leader>gl", "<cmd>LazyGitFilter<cr>", desc = "LazyGit Log" },
		},
		config = function()
			vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
			vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
			vim.g.lazygit_floating_window_border_chars = {'╭','─', '╮', '│', '╯','─', '╰', '│'} -- customize lazygit popup window border characters
			vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
			vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed
			vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
			vim.g.lazygit_config_file_path = "" -- custom config file path
		end,
	},

	-- Enhanced git integration
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

				-- Navigation
				map("n", "]h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gs.nav_hunk("next")
					end
				end, "Next Hunk")
				map("n", "[h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gs.nav_hunk("prev")
					end
				end, "Prev Hunk")
				map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
				map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")

				-- Actions
				map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
				map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
				map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
				map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
				map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
				map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
				map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
				map("n", "<leader>ghd", gs.diffthis, "Diff This")
				map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,
		},
	},

	-- Git blame and history
	{
		"f-person/git-blame.nvim",
		event = "BufRead",
		config = function()
			vim.cmd("highlight default link gitblame SpecialComment")
			vim.g.gitblame_enabled = 0
		end,
		keys = {
			{ "<leader>gb", "<cmd>GitBlameToggle<cr>", desc = "Git Blame Toggle" },
		},
	},

	-- change trouble config
	{
		"folke/trouble.nvim",
		-- opts will be merged with the parent spec
		opts = { use_diagnostic_signs = true },
	},

	-- disable trouble
	{ "folke/trouble.nvim", enabled = true },

	-- override nvim-cmp and add cmp-emoji
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-emoji" },
		---@param opts cmp.ConfigSchema
		opts = function(_, opts)
			table.insert(opts.sources, { name = "emoji" })
		end,
	},

	-- change some telescope options and a keymap to browse plugin files
	{
		"nvim-telescope/telescope.nvim",
		keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
		},
		-- change some options
		opts = {
			defaults = {
				layout_strategy = "horizontal",
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				winblend = 0,
			},
		},
	},

	-- add pyright to lspconfig
	{
		"neovim/nvim-lspconfig",
		---@class PluginLspOpts
		opts = {
			---@type lspconfig.options
			servers = {
				-- pyright will be automatically installed with mason and loaded with lspconfig
				pyright = {},
			},
		},
	},

	-- add tsserver and setup with typescript.nvim instead of lspconfig
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"jose-elias-alvarez/typescript.nvim",
			init = function()
				require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
					vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
				end)
			end,
		},
		---@class PluginLspOpts
		opts = {
			---@type lspconfig.options
			servers = {
				-- tsserver will be automatically installed with mason and loaded with lspconfig
				tsserver = {},
			},
			-- you can do any additional lsp server setup here
			-- return true if you don't want this server to be setup with lspconfig
			---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
			setup = {
				-- example to setup with typescript.nvim
				tsserver = function(_, opts)
					require("typescript").setup({ server = opts })
					return true
				end,
				-- Specify * to use this function as a fallback for any server
				-- ["*"] = function(server, opts) end,
			},
		},
	},

	-- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
	-- treesitter, mason and typescript.nvim. So instead of the above, you can use:
	-- { import = "lazyvim.plugins.extras.lang.typescript" }, -- moved to lazy.lua

	-- add more treesitter parsers
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"bash",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"rust",
				"tsx",
				"typescript",
				"vim",
				"yaml",
			},
		},
	},

	-- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
	-- would overwrite `ensure_installed` with the new value.
	-- If you'd rather extend the default config, use the code below instead:
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			-- add tsx and treesitter
			vim.list_extend(opts.ensure_installed, {
				"tsx",
				"typescript",
			})
		end,
	},

	-- the opts function can also be used to change the default opts:
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function(_, opts)
			table.insert(opts.sections.lualine_x, "😄")
		end,
	},

	-- or you can return new options to override all the defaults
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function()
			return {
				--[[add your custom lualine config here]]
			}
		end,
	},

	-- use mini.starter instead of alpha
	-- { import = "lazyvim.plugins.extras.ui.mini-starter" }, -- moved to lazy.lua

	-- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
	-- { import = "lazyvim.plugins.extras.lang.json" }, -- moved to lazy.lua

	-- add any tools you want to have installed below
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"shellcheck",
				"shfmt",
				"flake8",
			},
		},
	},

	-- Use <tab> for completion and snippets (supertab)
	-- first: disable default <tab> and <s-tab> behavior in LuaSnip
	{
		"L3MON4D3/LuaSnip",
		keys = function()
			return {}
		end,
	},
	-- then: setup supertab in cmp
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-emoji",
		},
		---@param opts cmp.ConfigSchema
		opts = function(_, opts)
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local luasnip = require("luasnip")
			local cmp = require("cmp")

			opts.mapping = vim.tbl_extend("force", opts.mapping, {
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
					-- this way you will only jump inside the snippet region
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			})
		end,
	},
}
