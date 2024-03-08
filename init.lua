vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set splitright")
vim.cmd("set splitbelow")
vim.cmd("set selectmode=key")
vim.cmd("set keymodel=startsel")
vim.cmd("set number")
vim.cmd("set cursorline")
vim.cmd("set termguicolors")
vim.cmd("set clipboard+=unnamedplus")
vim.cmd("set updatetime=700")
vim.cmd("set whichwrap+=<,>,[,]")
vim.cmd("set relativenumber")
vim.cmd("set signcolumn=yes")
-- vim.cmd("set iskeyword-=_")
vim.cmd("set list")
vim.cmd("set noequalalways")
vim.opt.guicursor = {
    "i:ver25-blinkon500-blinkoff500,a:ver25-iCursor",
}
vim.opt.listchars = {
    eol = "↵",
    tab = "→ ",
    trail = "␣",
    precedes = "«",
    extends = "»"
}
vim.diagnostic.config({
    update_in_insert = true,
    float = { border = "single" },
})
vim.cmd([[au CursorHold * lua vim.diagnostic.open_float(0,{scope = "cursor"})]])
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    {"loctvl842/monokai-pro.nvim", name="monokai", priority=1000},
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {
    	"nvim-neo-tree/neo-tree.nvim",
    	branch = "v3.x",
    	dependencies = {
      	    "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            "3rd/image.nvim"
        }
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            {'williamboman/mason.nvim', config = true},
            'williamboman/mason-lspconfig.nvim',
            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
            -- Additional lua configuration, makes nvim stuff amazing!
            'folke/neodev.nvim',
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-emoji",
        },
    },
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
        -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
        -- animation = true,
        -- insert_at_start = true,
        -- …etc.
        },
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },
    { 'lvimuser/lsp-inlayhints.nvim' },
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {},
        config = function(_, opts) require'lsp_signature'.setup(opts) end
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    { 'jdhao/better-escape.vim' },
    { 
        'Pocco81/auto-save.nvim',
        opts = {
            enabled = true,
        }
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {}
    },
    {
        "dhruvasagar/vim-prosession",
        dependencies = {
            "tpope/vim-obsession",
        },
    },
    {
    	"arsham/arshamiser.nvim",
	    dependencies = {
		    "arsham/arshlib.nvim",
		    "famiu/feline.nvim",
		    "rebelot/heirline.nvim",
		    "kyazdani42/nvim-web-devicons",
	    },
	    config = function()
		    -- ignore any parts you don't want to use
		    vim.cmd.colorscheme("arshamiser_light")
		    require("arshamiser.feliniser")
		    -- or:
		    -- require("arshamiser.heirliniser")

		    _G.custom_foldtext = require("arshamiser.folding").foldtext
		    vim.opt.foldtext = "v:lua.custom_foldtext()"
		    -- if you want to draw a tabline:
		    vim.api.nvim_set_option("tabline", [[%{%v:lua.require("arshamiser.tabline").draw()%}]])
	    end,
    },
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        lazy = false,
    },
    { 'onsails/lspkind.nvim' },
    {
        'MunifTanjim/eslint.nvim',
        dependencies = {
            'jose-elias-alvarez/null-ls.nvim'
        }
    },
    {
        'MunifTanjim/prettier.nvim',
        dependencies = {
            'jose-elias-alvarez/null-ls.nvim'
        }
    },
    { 'simrat39/symbols-outline.nvim' },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    { 'nvim-treesitter/nvim-treesitter-context' },
    { 'mg979/vim-visual-multi' },
    { 'sindrets/diffview.nvim' },
    { 'sitiom/nvim-numbertoggle' },
    { 'mawkler/modicator.nvim' },
    {
      "ecthelionvi/NeoColumn.nvim",
      opts = {}
    },
    {
      "utilyre/barbecue.nvim",
      name = "barbecue",
      version = "*",
      dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional dependency
      },
      opts = {
        -- configurations go here
      },
    },
    {'akinsho/git-conflict.nvim', version = "*", config = true },
    {
      'mrjones2014/legendary.nvim',
      -- since legendary.nvim handles all your keymaps/commands,
      -- its recommended to load legendary.nvim before other plugins
      priority = 10000,
      lazy = false,
      -- sqlite is only needed if you want to use frecency sorting
      -- dependencies = { 'kkharji/sqlite.lua' }
    },
    {
      'stevearc/dressing.nvim',
      opts = {},
    },
    {
      "folke/twilight.nvim",
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    { 'arielherself/vim-cursorword' },
    { 'm-demare/hlargs.nvim' },
    { 'chentoast/marks.nvim' },
    {
      "sontungexpt/sttusline",
      dependencies = {
          "nvim-tree/nvim-web-devicons",
      },
      event = { "BufEnter" },
      config = function(_, opts)
          require("sttusline").setup {
              -- statusline_color = "#000000",
              statusline_color = "StatusLine",

              -- | 1 | 2 | 3
              -- recommended: 3
              laststatus = 3,
              disabled = {
                  filetypes = {
                      -- "NvimTree",
                      -- "lazy",
                  },
                  buftypes = {
                      -- "terminal",
                  },
              },
              components = {
                  "mode",
                  "filename",
                  "git-branch",
                  "git-diff",
                  "%=",
                  "diagnostics",
                  "lsps-formatters",
                  "copilot",
                  "indent",
                  "encoding",
                  "pos-cursor",
                  "pos-cursor-progress",
              },
          }
      end,
    },
    { 'gaborvecsei/usage-tracker.nvim' },
    { 'wakatime/vim-wakatime', lazy = false },
    {
        'smoka7/hop.nvim',
        version = "*",
        opts = {},
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
     "folke/trouble.nvim",
     dependencies = { "nvim-tree/nvim-web-devicons" },
     opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
     },
    }
}
local opts = { 
}

require("lazy").setup(plugins, opts)

require("monokai-pro").setup({
  transparent_background = true,
  terminal_colors = true,
  devicons = true, -- highlight the icons of `nvim-web-devicons`
  styles = {
    comment = { italic = true },
    keyword = { italic = true }, -- any other keyword
    type = { italic = false }, -- (preferred) int, long, char, etc
    storageclass = { italic = true }, -- static, register, volatile, etc
    structure = { italic = true }, -- struct, union, enum, etc
    parameter = { italic = true }, -- parameter pass in function
    annotation = { italic = true },
    tag_attribute = { italic = true }, -- attribute of tag in reactjs
  },
  filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
  -- Enable this will disable filter option
  day_night = {
    enable = false, -- turn off by default
    day_filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
    night_filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
  },
  inc_search = "background", -- underline | background
  background_clear = {
    -- "float_win",
    "toggleterm",
    -- "telescope",
    -- "which-key",
    "renamer",
    "notify",
    -- "nvim-tree",
    -- "neo-tree",
    -- "bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
  },-- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
  plugins = {
    bufferline = {
      underline_selected = false,
      underline_visible = false,
    },
    indent_blankline = {
      context_highlight = "default", -- default | pro
      context_start_underline = false,
    },
  },
})

vim.cmd([[colorscheme monokai-pro]])

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>p', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})

local config = require("nvim-treesitter.configs")
config.setup({
    ensure_installed = {"lua", "cpp", "rust", "javascript", "python", "typescript", "html", "css", "scss"},
    auto_install = true,
    highlight = { enable = true},
    indent = { enable = true},
})
vim.keymap.set('n', '<leader>f', '<Cmd>Neotree . toggle left<CR>', {})

-- import nvim-cmp plugin safely
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
  return
end

-- import luasnip plugin safely
local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
  return
end

vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
    ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
    ["<ESC>"] = cmp.mapping.abort(), -- close completion window
    ["<tab>"] = cmp.mapping.confirm({ select = true }),
  }),
  -- sources for autocompletion
  sources = cmp.config.sources({
    { name = "nvim_lsp" }, -- LSP
    { name = "luasnip" }, -- snippets
    { name = "buffer" }, -- text within the current buffer
    { name = "path" }, -- file system paths
  }),
})

-- Setup language servers.
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.svls.setup {
    capabilities = capabilities
}
lspconfig.clangd.setup {
    capabilities = capabilities,
    cmd = {
        "clangd",
        "--header-insertion=never"
    }
}
lspconfig.pyright.setup {
    capabilities = capabilities
}
lspconfig.tsserver.setup {
    capabilities = capabilities
}
lspconfig.rust_analyzer.setup {
    capabilities = capabilities,
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

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

require("lsp-inlayhints").setup()
vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = "LspAttach_inlayhints",
  callback = function(args)
    if not (args.data and args.data.client_id) then
      return
    end

    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    require("lsp-inlayhints").on_attach(client, bufnr)
  end,
})

require("lsp_signature").setup({})

vim.keymap.set({'i', 'n', 'v', 'x'}, '<C-z>', '<Nop>', {noremap=true})
vim.keymap.set({'i', 'n', 'v', 'x'}, '<C-c>', '<ESC>', {noremap=true})
vim.keymap.set('i', '<C-v>', '<ESC>PA')
vim.keymap.set('i', '<C-x>', '<ESC>ddi')
vim.keymap.set('i', '<Home>', '<ESC>^i')
vim.keymap.set('i', '<C-a>', '<ESC>ggVG')
vim.keymap.set('n', '<C-a>', 'ggVG')
vim.keymap.set('n', '<leader>`', '<Cmd>split<CR><Cmd>terminal<CR>i')
vim.keymap.set('n', '<leader>l', '<Cmd>40vs std.in<CR>')
vim.keymap.set('n', '<leader>n', '<Cmd>tabnew')
vim.keymap.set('t', '<ESC>', '<C-\\><C-n>', {noremap=true})
vim.keymap.set('n', '<leader>s', '<Cmd>SymbolsOutline<CR>')
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")
vim.keymap.set('n', '<leader>t', '<Cmd>TodoTelescope<CR>')
vim.keymap.set('v', "<C-S-Down>", "dpV`]")
vim.keymap.set('v', "<C-S-Up>", "dkPV`]")
vim.keymap.set('n', '<C-p>', '<Cmd>Legendary<CR>', {noremap=true})
vim.keymap.set({'n', 'v', 'x'}, '<leader>h', '<Cmd>HopWord<CR>')
vim.keymap.set('n', '<leader>dd', '<Cmd>TroubleToggle document_diagnostics<CR>');
vim.keymap.set('n', '<leader>dw', '<Cmd>TroubleToggle workspace_diagnostics<CR>');
vim.keymap.set('n', '<leader>dq', '<Cmd>TroubleToggle quickfix<CR>');
vim.keymap.set('n', '<leader>w', '<Cmd>TroubleToggle lsp_definitions<CR>');
vim.keymap.set('n', '<leader>r', '<Cmd>TroubleToggle lsp_references<CR>');
require("nvim-treesitter.configs").setup {
    incremental_selection = {
        enable = true,
        keymaps = {
            node_incremental = "v",
            node_decremental = "V",
        },
    },
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = "cpp",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, 'n', "<leader>b", "<Cmd>10sp<CR><Cmd>te g++ -std=c++17 -Wall -Ofast -g -fsanitize=address -fsanitize=undefined % && ./a.out < std.in<CR>i", {
            silent = true,
            noremap = true
        })
    end,
})

vim.api.nvim_create_user_command('Backup', '!git add . && git commit -m "backup" && git push', {})

require('Comment').setup()
local str = require("cmp.utils.str")
local types = require("cmp.types")
local lspkind = require('lspkind')
cmp.setup {
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                            -- can also be a function to dynamically calculate max width such as 
                            -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function (entry, vim_item)
                local word = entry:get_insert_text()
                if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
                    word = vim.lsp.util.parse_snippet(word)
                end
                word = str.oneline(word)
                if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet and string.sub(vim_item.abbr, -1, -1) == "~" then
                    word = word .. "~"
                end
                vim_item.abbr = word
                return vim_item
            end
        })
    }
}

local null_ls = require("null-ls")
local eslint = require("eslint")

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

null_ls.setup()

eslint.setup({
  bin = 'eslint', -- or `eslint_d`
  code_actions = {
    enable = true,
    apply_on_save = {
      enable = true,
      types = { "directive", "problem", "suggestion", "layout" },
    },
    disable_rule_comment = {
      enable = true,
      location = "separate_line", -- or `same_line`
    },
  },
  diagnostics = {
    enable = true,
    report_unused_disable_directives = false,
    run_on = "type", -- or `save`
  },
})

local prettier = require("prettier")

prettier.setup({
  bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
    "vue",
  },
})

require("symbols-outline").setup()

require("todo-comments").setup()

lspconfig.volar.setup{
  filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'}
}

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts);
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts);

require('diffview').setup()

require('modicator').setup()

require("barbecue.ui").toggle(true)

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}
local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup {
    indent = { highlight = highlight, char = "▏" },
    scope = { enabled = true },
}

require('hlargs').setup()

require('marks').setup()

require('usage-tracker').setup({
    keep_eventlog_days = 31,
    cleanup_freq_days = 7,
    event_wait_period_in_sec = 5,
    inactivity_threshold_in_min = 5,
    inactivity_check_freq_in_sec = 5,
    verbose = 0,
    telemetry_endpoint = "" -- you'll need to start the restapi for this feature
})
