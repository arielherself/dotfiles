# vim:foldmethod=marker:foldmarker={{{,}}}:

vim.notify = require('notify')
vim.keymap.set('n', '<Del>', vim.notify.dismiss, {noremap=true})

vim.keymap.set('n', '<leader>ff', vim.lsp.buf.format)

require('todo-comments').setup {}

require("dapui").setup()
require('nvim-dap-virtual-text').setup {}

local dap = require('dap')
local ui = require('dapui')
vim.keymap.set('n', '<leader>bb', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>bc', dap.run_to_cursor)
vim.keymap.set('n', '<leader>bt', ui.toggle)
vim.keymap.set('n', '<F1>', dap.continue)
vim.keymap.set('n', '<F2>', dap.step_into)
vim.keymap.set('n', '<F3>', dap.step_over)
vim.keymap.set('n', '<F4>', dap.step_out)
vim.keymap.set('n', '<F5>', dap.step_back)
vim.keymap.set('n', '<F6>', dap.restart)
vim.keymap.set('n', '<F7>', dap.close)
vim.keymap.set('n', '<leader>?', function()
	require('dapui').eval(nil, { enter = true })
end)
dap.listeners.before.attach.dapui_config = ui.open
dap.listeners.before.launch.dapui_config = ui.open
dap.listeners.after.event_terminated.dapui_config = ui.close
dap.listeners.after.event_exited.dapui_config = ui.close

require('oil').setup {
    columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
    },
    keymaps = {
        ["<C-v>"] = { "actions.select", opts = { vertical = true } },
        ["<C-x>"] = { "actions.select", opts = { horizontal = true } },
    },
    view_options = {
        show_hidden = true,
    },
}

require('gitsigns').setup {
	signs = {
		add          = { text = '┃' },
		change       = { text = '┃' },
		delete       = { text = '_' },
		topdelete    = { text = '‾' },
		changedelete = { text = '~' },
		untracked    = { text = '┇' },
    },
    signs_staged = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┇' },
    }
}

require('fzf-lua').setup({'fzf-vim'})
require('fzf-lua').setup {
	winopts = { preview = { default = 'builtin' } },
}
vim.keymap.set('n', '<leader>g', '<Cmd>FzfLua live_grep<CR>', {noremap=true})
vim.keymap.set('n', '<leader>s', '<Cmd>FzfLua lsp_live_workspace_symbols<CR>', {noremap=true})

-- {{{ LSP Related
vim.diagnostic.config {
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = true,
}

--- {{{ lsp_signature setup
require('lsp_signature').setup {
    handler_opts = { border = "none" },
    hint_prefix = "󰁔 ",
}
--- }}}

--- {{{ nvim-treesitter setup
-- Managed by home-manager
--
-- local config = require("nvim-treesitter.configs")
-- config.setup {
--     ensure_installed = {"lua", "cpp", "rust", "javascript", "python", "typescript", "html", "css", "scss"},
--     auto_install = true,
--     highlight = { enable = true},
--     indent = { enable = true},
-- }
--- }}}

--- {{{ nvim-cmp setup
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
    return
end

local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
    return
end

local compare = require('cmp.config.compare')

vim.opt.completeopt = "menu,menuone,noselect"

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local is_empty_line = function()
    unpack = unpack or table.unpack
    local line, _ = unpack(vim.api.nvim_win_get_cursor(0))
    return vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:match("%S") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local lspkind = require('lspkind')

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                if not is_empty_line() then
                    cmp.confirm({ select = true })
                else
                    fallback()
                end
            elseif luasnip_status and luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, { "i", "s" }),

        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<ESC>'] = cmp.mapping.abort(),
    },
    -- sources for autocompletion
    sources = cmp.config.sources({
        { name = "cody" },
        {
            name = "nvim_lsp",
            option = {
                markdown_oxide = { keyword_pattern = [[\(\k\| \|\/\|#\)\+]] }
            }
        }, -- LSP
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within the current buffer
        { name = "path" }, -- file system paths
        { name = "emoji" },
        { name = "nerdfont" },
        { name = "calc" },
    }),

    -- Temporary fix for slowdown on entering cmdline from a large file.
    -- See https://github.com/hrsh7th/nvim-cmp/issues/1841
    sorting = {
        priority_weight = 2,
        comparators = {
            compare.offset,
            compare.exact,
            compare.score,
            compare.recently_used,
            compare.kind,
            compare.length,
            compare.order,
        },
    },

    formatting = {
        fields = { cmp.ItemField.Abbr, cmp.ItemField.Kind, cmp.ItemField.Menu },
        format = lspkind.cmp_format({
            mode = 'symbol_text', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            -- can also be a function to dynamically calculate max width such as
            -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
            ellipsis_char = '…', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function (entry, vim_item)
                -- local word = entry:get_insert_text()
                -- if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
                --     word = word
                --     -- word = vim.lsp.util.parse_snippet(word)
                -- end
                -- word = str.oneline(word)
                -- if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet and string.sub(vim_item.abbr, -1, -1) == "~" then
                --     word = word .. "~"
                -- end
                -- vim_item.abbr = word
                return vim_item
            end
        })
    }
}
--- }}}

--- {{{ Configuration for specific LSPs
require('mason').setup {
	ui = {
		check_outdated_packages_on_open = false,
	},
}
require('java').setup {}

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- local extended_caps = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities)
-- lspconfig.svls.setup {
--     capabilities = capabilities
-- }
lspconfig.clangd.setup {
    capabilities = capabilities,
    root_dir = function(fname)
        return lspconfig.util.root_pattern('compile_commands.json')(fname) or lspconfig.util.find_git_ancestor(fname) or vim.fn.getcwd()
    end,
    cmd = {
        "clangd",
        -- "--header-insertion=never",
        "--clang-tidy",
        "--clang-tidy-checks=*",
    }
}
lspconfig.pyright.setup {
    capabilities = capabilities
}
lspconfig.ts_ls.setup {
	filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    capabilities = capabilities,
	init_options = {
		plugins = {
			{
				name = '@vue/typescript-plugin',
				-- WARN: you only need to install `@vue/language-server` as dev dependency:
				--       ```sh
				--       npm install @vue/language-server --save-dev
				--       ```
				--       Global installation doesn't work (at least for NixOS).
				location = '',
				languages = { 'vue' },
			},
		},
	},
}
lspconfig.rust_analyzer.setup {
    capabilities = capabilities,
    -- Server-specific settings. See `:help lspconfig-setup`
    settings = {
        ['rust-analyzer'] = {
            checkOnSave = {
                command = 'clippy',
            },
			bindingModeHints = {
				enable = true,
			},
			closureCaptureHints = {
				enable = true,
			},
			genericParameterHints = {
				lifetime = {
					enable = true,
				},
				type = {
					enable = true,
				},
			},
			implicitDrops = {
				enable = true,
			},
			implicitSizedBoundHints = {
				enable = true,
			},
			lifetimeElisionHints = {
				enable = true,
			},
			rangeExclusiveHints = {
				enable = true,
			},
        },
    },
}
lspconfig.hls.setup {}
lspconfig.lua_ls.setup {
    capabilities = capabilities
}
lspconfig.cmake.setup {}
lspconfig.asm_lsp.setup {
    capabilities = capabilities
}
lspconfig.nil_ls.setup {
    capabilities = capabilities
}
lspconfig.mojo.setup {}
lspconfig.nushell.setup {}
lspconfig.volar.setup {}
lspconfig.jdtls.setup {}
--- }}}

--- {{{ Manual inlay hints
local a = vim.api.nvim_create_autocmd("LspAttach",  {
	callback = function()
		vim.lsp.inlay_hint.enable(true)
	end,
})
vim.keymap.set('n', '<leader>i', function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)
--- }}}

--- {{{ trouble.nvim keybinds
require('trouble').setup()
vim.keymap.set('n', '<leader>dd', '<Cmd>Trouble diagnostics toggle focus=true filter.buf=0<CR>');
vim.keymap.set('n', '<leader>dw', '<Cmd>Trouble diagnostics toggle focus=true<CR>');
vim.keymap.set('n', '<leader>dq', '<Cmd>Trouble qflist toggle focus=true<CR>');
vim.keymap.set('n', '<leader>w', '<Cmd>Trouble lsp toggle focus=true<CR>');
--- }}}

--- {{{ Common diagnostics keybinds
vim.keymap.set('n', 'qq', vim.diagnostic.open_float);
vim.keymap.set('n', 'qn', vim.diagnostic.goto_next);
vim.keymap.set('n', 'qp', vim.diagnostic.goto_prev);
--- }}}

--- {{{ LSP keybinds
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    end,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {
        max_width = 100,
    }
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {
        max_width = 100,
    }
)
--- }}}

require('goto-preview').setup {
    default_mappings = true
}
-- }}}

-- {{{ Fold Management
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

-- Option 2: nvim lsp as LSP client
-- Tell the server the capability of foldingRange,
-- Neovim hasn't added foldingRange to default capabilities, users must add it manually
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
local language_servers = vim.lsp.get_clients() -- or list servers manually like {'gopls', 'clangd'}
for _, ls in ipairs(language_servers) do
    require('lspconfig')[ls].setup({
        capabilities = capabilities
        -- you can add other fields for setting up lsp server in this table
    })
end
require('ufo').setup()

-- }}}

-- {{{ Treesitter Text Objects
--- {{{ select
require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        -- You can optionally set descriptions to the mappings (used in the desc parameter of
        -- nvim_buf_set_keymap) which plugins like which-key display
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        -- You can also use captures from other query groups like `locals.scm`
        ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
      },
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true or false
      include_surrounding_whitespace = true,
    },
  },
}
--- }}}
--- {{{ swap
require'nvim-treesitter.configs'.setup {
  textobjects = {
    swap = {
      enable = true,
      swap_next = {
        ["]]"] = "@parameter.inner",
      },
      swap_previous = {
        ["[["] = "@parameter.inner",
      },
    },
  },
}
--- }}}
--- {{{ move
require'nvim-treesitter.configs'.setup {
  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]c"] = { query = "@class.outer", desc = "Next class start" },
        --
        -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
        ["]o"] = "@loop.*",
        -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
        --
        -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
        -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
        ["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]C"] = "@class.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[c"] = "@class.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[C"] = "@class.outer",
      },
      -- Below will go to either the start or the end, whichever is closer.
      -- Use if you want more granular movements
      -- Make it even more gradual by adding multiple queries and regex.
      goto_next = {
        ["]d"] = "@conditional.outer",
      },
      goto_previous = {
        ["[d"] = "@conditional.outer",
      }
    },
  },
}
--- }}}
-- }}}

require('avante_lib').load()
require('avante').setup {
	provider = "claude-nekoapi",
	auto_suggestions_provider = "gpt-4o-mini",
	openai = {
		endpoint = "https://api.nekoapi.com/v1",
		api_key_name = "NEKOAPI_KEY",
	},
	claude = {
		endpoint = "https://api.nekoapi.com",
		-- api_key_name = "NEKOAPI_CLAUDE_KEY",
		api_key_name = "NEKOAPI_KEY",
	},
	vendors = {
		["gpt-4o-mini"] = {
			__inherited_from = "openai",
			model = "gpt-4o-mini",
			max_tokens = 8192,
		},
		["o3-mini"] = {
			__inherited_from = "openai",
			model = "o3-mini",
			max_tokens = 16384,
		},
		["o3-mini-high"] = {
			__inherited_from = "openai",
			model = "o3-mini-high",
			max_tokens = 16384,
		},
		["claude-nekoapi"] = {
			__inherited_from = "claude",
			model = "claude-3-5-sonnet-latest",
			max_tokens = 8192,
		},
	},
}

