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
vim.g.mapleader = " ";
vim.g['cph#dir'] = '/home/user/RustIsBestLang/';
vim.filetype.add({
    extension = {
        ct = 'cpp',
    },
})

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
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                "isak102/telescope-git-file-history.nvim",
                dependencies = { "tpope/vim-fugitive" }
            }
        }
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
    },
    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim", -- required by telescope
            "MunifTanjim/nui.nvim",

            -- optional
            "nvim-treesitter/nvim-treesitter",
            "rcarriga/nvim-notify",
            "nvim-tree/nvim-web-devicons",
            "3rd/image.nvim",
        },
        opts = {
            ---@type string
            arg = "leetcode.nvim",

            ---@type lc.lang
            lang = "cpp",

            cn = { -- leetcode.cn
                enabled = true, ---@type boolean
                translator = true, ---@type boolean
                translate_problems = true, ---@type boolean
            },

            ---@type lc.storage
            storage = {
                home = vim.fn.stdpath("data") .. "/.leetcode",
                cache = vim.fn.stdpath("cache") .. "/.leetcode",
            },

            ---@type table<string, boolean>
            plugins = {
                non_standalone = false,
            },

            ---@type boolean
            logging = true,

            injector = {
                ['cpp'] = {
                    before = [[
                    ]],
                },
            }, ---@type table<lc.lang, lc.inject>

            cache = {
                update_interval = 60 * 60 * 24 * 7, ---@type integer 7 days
            },

            console = {
                open_on_runcode = true, ---@type boolean

                dir = "row", ---@type lc.direction

                size = { ---@type lc.size
                    width = "90%",
                    height = "75%",
                },

                result = {
                    size = "60%", ---@type lc.size
                },

                testcase = {
                    virt_text = true, ---@type boolean

                    size = "40%", ---@type lc.size
                },
            },

            description = {
                position = "left", ---@type lc.position

                width = "35%", ---@type lc.size

                show_stats = true, ---@type boolean
            },

            hooks = {
                ---@type fun()[]
                ["enter"] = {},

                ---@type fun(question: lc.ui.Question)[]
                ["question_enter"] = {},

                ---@type fun()[]
                ["leave"] = {},
            },

            keys = {
                toggle = { "q" }, ---@type string|string[]
                confirm = { "<CR>" }, ---@type string|string[]

                reset_testcases = "r", ---@type string
                use_testcase = "U", ---@type string
                focus_testcases = "H", ---@type string
                focus_result = "L", ---@type string
            },

            ---@type lc.highlights
            theme = {},

            ---@type boolean
            image_support = false,
        }
    },
    { 'Civitasv/cmake-tools.nvim' },
    { 'p00f/cphelper.nvim' },
    { "savq/melange-nvim" },
    { 'hrsh7th/vim-vsnip' },
    { 'octarect/telescope-menu.nvim' },
    {
      "NeogitOrg/neogit",
      dependencies = {
        "nvim-lua/plenary.nvim",         -- required
        "sindrets/diffview.nvim",        -- optional - Diff integration

        -- Only one of these is needed, not both.
        "nvim-telescope/telescope.nvim", -- optional
        "ibhagwan/fzf-lua",              -- optional
      },
      config = true
    },
    { 'Exafunction/codeium.vim' },
    { "mistricky/codesnap.nvim", build = "make" },
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

-- vim.cmd([[colorscheme monokai-pro]])
vim.cmd([[colorscheme melange]])

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

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = true })
      elseif vim.fn.exists('b:_codeium_completions') ~= 0 then
        vim.fn['codeium#Accept']()
        fallback()
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
        -- "--header-insertion=never"
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
vim.keymap.set('n', '<leader>n', '<Cmd>tabnew<CR>')
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
vim.keymap.set('n', '<leader>1', '<Cmd>CphReceive<CR>');
vim.keymap.set('n', '<leader>2', '<Cmd>CphTest<CR>');
vim.keymap.set('n', '<leader>3', '<Cmd>r ~/RustIsBestLang/src/bin/template.cc<CR>G');
vim.keymap.set('n', '<A-t>', '<Cmd>BufferPick<CR>', {noremap=true});
vim.keymap.set('n', '<C-g>p', '<Cmd>Telescope menu git<CR>', {noremap=true});
vim.keymap.set('n', '<C-g>g', '<Cmd>Neogit kind=split_above<CR>', {noremap=true});
vim.keymap.set('n', '<leader>y', '<Cmd>!ctext -i $(gcc -xc++ /dev/null -E -Wp,-v 2>&1 | sed -n "s,^ ,,p" | tr "\\n" ",") < % > ctext_out.cc<CR><Cmd>split ctext_out.cc<CR>:%%y+<CR><Cmd>q<CR>')
vim.keymap.set({'v', 'x'}, '<leader>cc', '<Cmd>CodeSnap<CR>', {noremap=true});

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
        vim.api.nvim_buf_set_keymap(0, 'n', "<leader>b", '<Cmd>10sp<CR><Cmd>te ctext -i $(gcc -xc++ /dev/null -E -Wp,-v 2>&1 | sed -n "s,^ ,,p" | tr "\\n" ",") < % > ctext_out.cc && clang++ -std=c++17 -DONLINE_JUDGE -Wl,-z,stack-size=268435456 -Wall -Ofast -g -fsanitize=address -fsanitize=undefined ctext_out.cc && ./a.out < std.in<CR>i', {
            silent = true,
            noremap = true
        })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, 'n', "<leader>b", "<Cmd>10sp<CR><Cmd>te python3 %<CR>i", {
            silent = true,
            noremap = true
        })
    end,
})

vim.api.nvim_create_user_command('Backup', '!git add . && git commit -S -m "backup" && git push', {})

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

local function lines(str)
  local result = {}
  for line in str:gmatch '[^\n]+' do
    table.insert(result, line)
  end
  return result
end
local ls = require('luasnip')
local snip = ls.snippet
local text = ls.text_node

local include_snippet = [[
#pragma GCC optimize("Ofast")
/////////////////////////////////////////////////////////
/**
 * Useful Macros
 *   by subcrip
 * (requires C++17)
 */

#include<bits/stdc++.h>
using namespace std;

/* macro helpers */
#define __NARGS(...) std::tuple_size<decltype(std::make_tuple(__VA_ARGS__))>::value
#define __DECOMPOSE_S(a, x) auto x = a;
#define __DECOMPOSE_N(a, ...) auto [__VA_ARGS__] = a;
constexpr void __() {}
#define __AS_PROCEDURE(...) __(); __VA_ARGS__; __()
#define __as_typeof(container) decltype(container)::value_type

/* type aliases */
using ll = int64_t;
using ull = uint64_t;
using pii = pair<int, int>;
using pil = pair<int, ll>;
using pli = pair<ll, int>;
using pll = pair<ll, ll>;

/* constants */
constexpr int INF = 0x3f3f3f3f;
constexpr ll INFLL = 0x3f3f3f3f3f3f3f3fLL;
constexpr ll MDL = 1e9 + 7;
constexpr ll PRIME = 998'244'353;
constexpr ll MDL1 = 8784491;
constexpr ll MDL2 = PRIME;

/* random */

mt19937 rd(chrono::duration_cast<chrono::milliseconds>(chrono::system_clock::now().time_since_epoch()).count());

/* bit-wise operations */
#define lowbit(x) ((x) & -(x))
#define popcount(x) (__builtin_popcountll(ll(x)))
#define parity(x) (__builtin_parityll(ll(x)))
#define msp(x) (63LL - __builtin_clzll(ll(x)))
#define lsp(x) (__builtin_ctzll(ll(x)))

/* arithmetic operations */
#define mod(x, y) ((((x) % (y)) + (y)) % (y))

/* fast pairs */
#define upair ull
#define umake(x, y) (ull(x) << 32 | (ull(y) & ((1ULL << 32) - 1)))
#define u1(p) ((p) >> 32)
#define u2(p) ((p) & ((1ULL << 32) - 1))
#define ult std::less<upair>
#define ugt std::greater<upair>

#define ipair ull
#define imake(x, y) (umake(x, y))
#define i1(p) (int(u1(ll(p))))
#define i2(p) (ll(u2(p) << 32) >> 32)
struct ilt {
    bool operator()(const ipair& a, const ipair& b) const {
        if (i1(a) == i1(b)) return i2(a) < i2(b);
        else return i1(a) < i1(b);
    }
};
struct igt {
    bool operator()(const ipair& a, const ipair& b) const {
        if (i1(a) == i1(b)) return i2(a) > i2(b);
        else return i1(a) > i1(b);
    }
};

/* conditions */
#define loop while (1)
#define if_or(var, val) if (!(var == val)) var = val; else
#define continue_or(var, val) __AS_PROCEDURE(if (var == val) continue; var = val;)
#define break_or(var, val) __AS_PROCEDURE(if (var == val) break; var = val;)

/* hash */
struct safe_hash {
    // https://codeforces.com/blog/entry/62393
    static uint64_t splitmix64(uint64_t x) {
        // http://xorshift.di.unimi.it/splitmix64.c
        x += 0x9e3779b97f4a7c15;
        x = (x ^ (x >> 30)) * 0xbf58476d1ce4e5b9;
        x = (x ^ (x >> 27)) * 0x94d049bb133111eb;
        return x ^ (x >> 31);
    }

    size_t operator()(uint64_t x) const {
        static const uint64_t FIXED_RANDOM = chrono::steady_clock::now().time_since_epoch().count();
        return splitmix64(x + FIXED_RANDOM);
    }
};

struct pair_hash {
    template <typename T, typename U>
    size_t operator()(const pair<T, U>& a) const {
        auto hash1 = safe_hash()(a.first);
        auto hash2 = safe_hash()(a.second);
        if (hash1 != hash2) {
            return hash1 ^ hash2;
        }
        return hash1;
    }
};

/* build data structures */
#define unordered_counter(from, to) __AS_PROCEDURE(unordered_map<__as_typeof(from), size_t, safe_hash> to; for (auto&& x : from) ++to[x];)
#define counter(from, to, cmp) __AS_PROCEDURE(map<__as_typeof(from), size_t, cmp> to; for (auto&& x : from) ++to[x];)
#define pa(a) __AS_PROCEDURE(__typeof(a) pa; pa.push_back({}); for (auto&&x : a) pa.push_back(pa.back() + x);)
#define sa(a) __AS_PROCEDURE(__typeof(a) sa(a.size() + 1); {int n = a.size(); for (int i = n - 1; i >= 0; --i) sa[i] = sa[i + 1] + a[i];};)
#define adj(ch, n) __AS_PROCEDURE(vector<vector<int>> ch((n) + 1);)
#define edge(ch, u, v) __AS_PROCEDURE(ch[u].push_back(v), ch[v].push_back(u);)
#define Edge(ch, u, v) __AS_PROCEDURE(ch[u].push_back(v);)
template <typename T, typename Iterator> pair<size_t, map<T, size_t>> discretize(Iterator __first, Iterator __last) {
    set<T> st(__first, __last);
    size_t N = 0;
    map<T, size_t> mp;
    for (auto&& x : st) mp[x] = ++N;
    return {N, mp};
}
template <typename T, typename Iterator> pair<size_t, unordered_map<T, size_t, safe_hash>> unordered_discretize(Iterator __first, Iterator __last) {
    set<T> st(__first, __last);
    size_t N = 0;
    unordered_map<T, size_t, safe_hash> mp;
    for (auto&& x : st) mp[x] = ++N;
    return {N, mp};
}

/* io */
#define untie __AS_PROCEDURE(ios_base::sync_with_stdio(0), cin.tie(NULL))
template<typename T> void __read(T& x) { cin >> x; }
template<typename T, typename... U> void __read(T& x, U&... args) { cin >> x; __read(args...); }
#define read(type, ...) __AS_PROCEDURE(type __VA_ARGS__; __read(__VA_ARGS__);)
#define readvec(type, a, n) __AS_PROCEDURE(vector<type> a(n); for (int i = 0; i < (n); ++i) cin >> a[i];)
#define putvec(a) __AS_PROCEDURE(for (auto&& x : a) cout << x << ' '; cout << endl;)
#define debug(x) __AS_PROCEDURE(cerr << #x" = " << (x) << endl;)
#define debugvec(a) __AS_PROCEDURE(cerr << #a" = "; for (auto&& x : a) cerr << x << ' '; cerr << endl;)
template<typename T, typename U> ostream& operator<<(ostream& out, const pair<T, U>& p) {
    out << "{" << p.first << ", " << p.second << "}";
    return out;
}
template<typename Char, typename Traits, typename Tuple, std::size_t... Index>
void print_tuple_impl(std::basic_ostream<Char, Traits>& os, const Tuple& t, std::index_sequence<Index...>) {
    using swallow = int[]; // guaranties left to right order
    (void)swallow { 0, (void(os << (Index == 0 ? "" : ", ") << std::get<Index>(t)), 0)... };
}
template<typename Char, typename Traits, typename... Args>
decltype(auto) operator<<(std::basic_ostream<Char, Traits>& os, const std::tuple<Args...>& t) {
    os << "{";
    print_tuple_impl(os, t, std::index_sequence_for<Args...>{});
    return os << "}";
}
template<typename T> ostream& operator<<(ostream& out, const vector<T>& vec) {
    for (auto&& i : vec) out << i << ' ';
    return out;
}

/* pops */
#define poptop(q, ...) __AS_PROCEDURE(auto [__VA_ARGS__] = q.top(); q.pop();)
#define popback(q, ...) __AS_PROCEDURE(auto [__VA_ARGS__] = q.back(); q.pop_back();)
#define popfront(q, ...) __AS_PROCEDURE(auto [__VA_ARGS__] = q.front();q.pop_front();)

/* math */
constexpr inline int lg2(ll x) { return x == 0 ? -1 : sizeof(ll) * 8 - 1 - __builtin_clzll(x); }

void __exgcd(ll a, ll b, ll& x, ll& y) {
  if (b == 0) {
    x = 1, y = 0;
    return;
  }
  __exgcd(b, a % b, y, x);
  y -= a / b * x;
}

ll inverse(ll a, ll b) {
    ll x, y;
    __exgcd(a, b, x, y);
    return mod(x, b);
}

/* string algorithms */
vector<int> calc_next(string t) {  // pi function of t
  int n = (int)t.length();
  vector<int> pi(n);
  for (int i = 1; i < n; i++) {
    int j = pi[i - 1];
    while (j > 0 && t[i] != t[j]) j = pi[j - 1];
    if (t[i] == t[j]) j++;
    pi[i] = j;
  }
  return pi;
}
vector<int> calc_z(string t) {  // z function of t
    int m = t.length();
    vector<int> z;
    z.push_back(m);
    pair<int, int> prev = {1, -1};
    for (int i = 1; i < m; ++i) {
        if (z[i - prev.first] + i <= prev.second) {
            z.push_back(z[i - prev.first]);
        } else {
            int j = max(i, prev.second + 1);
            while (j < m && t[j] == t[j - i]) ++j;
            z.push_back(j - i);
            prev = {i, j - 1};
        }
    }
    return z;
}
vector<int> kmp(string s, string t) {  // find all t in s
  string cur = t + '#' + s;
  int sz1 = s.size(), sz2 = t.size();
  vector<int> v;
  vector<int> lps = calc_next(cur);
  for (int i = sz2 + 1; i <= sz1 + sz2; i++) {
    if (lps[i] == sz2) v.push_back(i - 2 * sz2);
  }
  return v;
}
int period(string s) {  // find the length of shortest recurring period
    int n = s.length();
    auto z = calc_z(s);
    for (int i = 1; i <= n / 2; ++i) {
        if (n % i == 0 && z[i] == n - i) {
            return i;
        }
    }
    return n;
}
/////////////////////////////////////////////////////////
]]

ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'include',
            namr = 'Useful Macros',
            dscr = 'Useful Macros',
        },{
            text(lines(include_snippet))
        })
    }
})

require('neo-tree').setup {
    filesystem = {
        filtered_items = {
          visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
          hide_dotfiles = false,
          hide_gitignored = false,
        },
    }
}

require("cmake-tools").setup {
  cmake_command = "cmake", -- this is used to specify cmake command path
  ctest_command = "ctest", -- this is used to specify ctest command path
  cmake_regenerate_on_save = true, -- auto generate when save CMakeLists.txt
  cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }, -- this will be passed when invoke `CMakeGenerate`
  cmake_build_options = {}, -- this will be passed when invoke `CMakeBuild`
  -- support macro expansion:
  --       ${kit}
  --       ${kitGenerator}
  --       ${variant:xx}
  cmake_build_directory = "out/${variant:buildType}", -- this is used to specify generate directory for cmake, allows macro expansion, relative to vim.loop.cwd()
  cmake_soft_link_compile_commands = true, -- this will automatically make a soft link from compile commands file to project root dir
  cmake_compile_commands_from_lsp = false, -- this will automatically set compile commands file location using lsp, to use it, please set `cmake_soft_link_compile_commands` to false
  cmake_kits_path = nil, -- this is used to specify global cmake kits path, see CMakeKits for detailed usage
  cmake_variants_message = {
    short = { show = true }, -- whether to show short message
    long = { show = true, max_length = 40 }, -- whether to show long message
  },
  cmake_dap_configuration = { -- debug settings for cmake
    name = "cpp",
    type = "codelldb",
    request = "launch",
    stopOnEntry = false,
    runInTerminal = true,
    console = "integratedTerminal",
  },
  cmake_executor = { -- executor to use
    name = "quickfix", -- name of the executor
    opts = {}, -- the options the executor will get, possible values depend on the executor type. See `default_opts` for possible values.
    default_opts = { -- a list of default and possible values for executors
      quickfix = {
        show = "always", -- "always", "only_on_error"
        position = "belowright", -- "vertical", "horizontal", "leftabove", "aboveleft", "rightbelow", "belowright", "topleft", "botright", use `:h vertical` for example to see help on them
        size = 10,
        encoding = "utf-8", -- if encoding is not "utf-8", it will be converted to "utf-8" using `vim.fn.iconv`
        auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
      },
      toggleterm = {
        direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
        close_on_exit = false, -- whether close the terminal when exit
        auto_scroll = true, -- whether auto scroll to the bottom
      },
      overseer = {
        new_task_opts = {
            strategy = {
                "toggleterm",
                direction = "horizontal",
                autos_croll = true,
                quit_on_exit = "success"
            }
        }, -- options to pass into the `overseer.new_task` command
        on_new_task = function(task)
            require("overseer").open(
                { enter = false, direction = "right" }
            )
        end,   -- a function that gets overseer.Task when it is created, before calling `task:start`
      },
      terminal = {
        name = "Main Terminal",
        prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
        split_direction = "horizontal", -- "horizontal", "vertical"
        split_size = 11,

        -- Window handling
        single_terminal_per_instance = true, -- Single viewport, multiple windows
        single_terminal_per_tab = true, -- Single viewport per tab
        keep_terminal_static_location = true, -- Static location of the viewport if avialable

        -- Running Tasks
        start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
        focus = false, -- Focus on terminal when cmake task is launched.
        do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
      }, -- terminal executor uses the values in cmake_terminal
    },
  },
  cmake_runner = { -- runner to use
    name = "terminal", -- name of the runner
    opts = {}, -- the options the runner will get, possible values depend on the runner type. See `default_opts` for possible values.
    default_opts = { -- a list of default and possible values for runners
      quickfix = {
        show = "always", -- "always", "only_on_error"
        position = "belowright", -- "bottom", "top"
        size = 10,
        encoding = "utf-8",
        auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
      },
      toggleterm = {
        direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
        close_on_exit = false, -- whether close the terminal when exit
        auto_scroll = true, -- whether auto scroll to the bottom
      },
      overseer = {
        new_task_opts = {
            strategy = {
                "toggleterm",
                direction = "horizontal",
                autos_croll = true,
                quit_on_exit = "success"
            }
        }, -- options to pass into the `overseer.new_task` command
        on_new_task = function(task)
        end,   -- a function that gets overseer.Task when it is created, before calling `task:start`
      },
      terminal = {
        name = "Main Terminal",
        prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
        split_direction = "horizontal", -- "horizontal", "vertical"
        split_size = 11,

        -- Window handling
        single_terminal_per_instance = true, -- Single viewport, multiple windows
        single_terminal_per_tab = true, -- Single viewport per tab
        keep_terminal_static_location = true, -- Static location of the viewport if avialable

        -- Running Tasks
        start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
        focus = false, -- Focus on terminal when cmake task is launched.
        do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
      },
    },
  },
  cmake_notifications = {
    runner = { enabled = true },
    executor = { enabled = true },
    spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
    refresh_rate_ms = 100, -- how often to iterate icons
  },
}

require('telescope').load_extension('git_file_history')

require("telescope").setup {
  extensions = {
    menu = {
      default = {
        items = {
          -- You can add an item of menu in the form of { "<display>", "<command>" }
          { "Checkhealth", "checkhealth" },
          { "Show LSP Info", "LspInfo" },
          { "Files", "Telescope find_files" },

          -- The above examples are syntax-sugars of the following;
          { display = "Change colorscheme", value = "Telescope colorscheme" },
        },
      },
      git = {
        items = {
          { "File History", "Telescope git_file_history" },
          { "Branches", "Telescope git_branches" },
          { "Commits", "Telescope git_commits" },
          { "Stash", "Telescope git_stash" },
          { "Status", "Telescope git_status" },
          { "Files", "Telescope git_files" },
        }
      },
    },
  },
}

require("telescope").load_extension("menu")

require('codesnap').setup {
    code_font_family = "Fira Code",
    has_line_number = true,
}
