vim.cmd("set encoding=utf-8")
vim.cmd("set exrc")
vim.cmd("set pumblend=40")
vim.cmd("set winblend=40")
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
vim.cmd("set noequalalways")
vim.cmd("set cmdheight=0")
vim.cmd("set scrolloff=10")
vim.cmd("set foldmethod=expr")
vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")
vim.cmd("set foldlevelstart=99")
vim.cmd("set list")
vim.cmd("set listchars=trail:█")
vim.cmd("set guicursor=n-v-c:block,i:ver25,a:blinkon0")
vim.cmd("set noshowmode")
vim.diagnostic.config({
    update_in_insert = true,
    float = {
        border = "none",
        focusable = false,
    },
})
vim.cmd([[au CursorHold * lua vim.diagnostic.open_float(0,{scope = "cursor"})]])
vim.g.mapleader = " ";
vim.filetype.add({
    extension = {
        ct = 'cpp',
    },
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
    { 'nvim-lua/plenary.nvim' },
    { 'rcarriga/nvim-notify' },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        dependencies = {
            {
                "isak102/telescope-git-file-history.nvim",
                dependencies = { "tpope/vim-fugitive" }
            }
        },
    },
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    -- {
    -- 	"nvim-neo-tree/neo-tree.nvim",
    -- 	branch = "v3.x",
    -- 	dependencies = {
    --         "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    --         "MunifTanjim/nui.nvim",
    --         "3rd/image.nvim",
    --     }
    -- },
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
            -- 'folke/neodev.nvim',
        },
        config = function(_, servers)
            for server, opts in pairs(servers) do
                require('lspconfig')[server].setup(opts)
            end
        end,
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
            "chrisgrieser/cmp-nerdfont",
            "hrsh7th/cmp-calc",
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
            animation = false,
            -- insert_at_start = true,
            -- …etc.
        },
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },
    {
        "ray-x/lsp_signature.nvim",  -- Show signature on `K` stroke
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
    {
        'jdhao/better-escape.vim'  -- `jk` without causing `j` to have delay
    },
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
        "dhruvasagar/vim-prosession",  -- save sessions
        dependencies = {
            "tpope/vim-obsession",
        },
    },
    {
        "arielherself/arshamiser.nvim",  -- status bar
        branch = "dev",
        dependencies = {
            "arsham/arshlib.nvim",
            "famiu/feline.nvim",
            "rebelot/heirline.nvim",
            "nvim-tree/nvim-web-devicons",
            "lewis6991/gitsigns.nvim",
            "nanotee/sqls.nvim",
            "arsham/listish.nvim",
        },
        config = function()
            require('gitsigns').setup()

            -- ignore any parts you don't want to use
            vim.cmd.colorscheme("arshamiser_dark")
            -- require("arshamiser.feliniser")
            -- or:
            require("arshamiser.heirliniser")

            _G.custom_foldtext = require("arshamiser.folding").foldtext
            vim.opt.foldtext = "v:lua.custom_foldtext()"
            -- if you want to draw a tabline:
            -- vim.api.nvim_set_option("tabline", [[%{%v:lua.require("arshamiser.tabline").draw()%}]])
        end,
    },
    {
        'numToStr/Comment.nvim',  -- `gc` for commenting
        opts = {
            -- add any options here
        },
        lazy = false,
    },
    {
        -- dir = "/home/user/lspkind.nvim/",
        'arielherself/lspkind.nvim' -- icon in completion menu
    },
    {
        'MunifTanjim/eslint.nvim',
        dependencies = {
            'nvimtools/none-ls.nvim'
        }
    },
    {
        'MunifTanjim/prettier.nvim',
        dependencies = {
            'nvimtools/none-ls.nvim'
        }
    },
    {
        'hedyhli/outline.nvim'  -- Show symbol outline on `<leader>s`
    },
    {
        "folke/todo-comments.nvim",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    { 'nvim-treesitter/nvim-treesitter-context' },
    { 'nvim-treesitter/nvim-treesitter-refactor' },
    { 'nvim-treesitter/nvim-treesitter-textobjects' },
    { 'mg979/vim-visual-multi' },
    { 'sindrets/diffview.nvim' },
    {
        'sitiom/nvim-numbertoggle'  -- Automatically switch between relative and absolute line number
    },
    {
        'mawkler/modicator.nvim'  -- highlight current line number
    },
    {
        "ecthelionvi/NeoColumn.nvim",  -- highlight overflow columns?
        opts = {}
    },
    {
        "utilyre/barbecue.nvim",  -- LSP winbar
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
    {
        'akinsho/git-conflict.nvim',  -- `GitConflictChooseOurs`
        version = "*",
        config = true,
    },
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
        'stevearc/dressing.nvim',  -- better UI
        opts = {},
    },
    {
        "folke/twilight.nvim",  -- Focus on parts that's being edited
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    { 'arielherself/vim-cursorword' },
    { 'm-demare/hlargs.nvim' },
    {
        'chentoast/marks.nvim'  -- Visualize marks
    },
    { 'wakatime/vim-wakatime', lazy = false },
    {
        'smoka7/hop.nvim',
        version = "*",
        opts = {},
    },
    {
        "kylechui/nvim-surround",  -- `ysiw)`
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        "folke/trouble.nvim",  -- TroubleToggle
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
    { "arielherself/melange-nvim" },
    { 'hrsh7th/vim-vsnip' },
    {
        "NeogitOrg/neogit",  -- <C-g>
        dependencies = {
            "sindrets/diffview.nvim",        -- optional - Diff integration

            -- Only one of these is needed, not both.
            "nvim-telescope/telescope.nvim", -- optional
            "ibhagwan/fzf-lua",              -- optional
        },
        config = true
    },
    -- { 'Exafunction/codeium.vim' },
    {
        "mistricky/codesnap.nvim",  -- code snapshot
        build = "make"
    },
    { 'rmagatti/goto-preview' },
    {
        -- dir = '/home/user/Documents/search.nvim',
        "arielherself/search.nvim",  -- Add tabs to Telescope search
        dependencies = { "nvim-telescope/telescope.nvim" }
    },
    {
        'NvChad/nvim-colorizer.lua'  -- Color green
    },
    { 'debugloop/telescope-undo.nvim' },
    {
        "folke/lazydev.nvim",  -- Autocompletion when editing Neovim configs or developing plugins
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- lazypath .. "/luvit-meta/library", -- see below
                -- You can also add plugins you always want to have loaded.
                -- Useful if the plugin has globals or types you want to use
                -- vim.env.LAZY .. "/LazyVim", -- see below
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true },
    {
        "AckslD/nvim-neoclip.lua",  -- `<leader>p`
    },
    {
        "danielfalk/smart-open.nvim",  -- sort file search results by frequency
        branch = "0.2.x",
        config = function()
            require("telescope").load_extension("smart_open")
        end,
        dependencies = {
            "kkharji/sqlite.lua",
            -- Only required if using match_algorithm fzf
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            -- Optional.  If installed, native fzy will be used when match_algorithm is fzy
            { "nvim-telescope/telescope-fzy-native.nvim" },
        },
    },
    {
        "chrisgrieser/nvim-origami",  -- Fold keymap
        event = "BufReadPost", -- later or on keypress would prevent saving folds
        opts = true, -- needed even when using default config
    },
    {
        dir = '/home/user/Documents/ultimate-autopair.nvim',
        -- 'altermo/ultimate-autopair.nvim',
        event={'InsertEnter','CmdlineEnter'},
        branch='v0.6', --recommended as each new version will have breaking changes
        opts={
            --Config goes here
            bs = {
                single_delete = true,
            },
            cr = {
                autoclose = true,
            },
            close = {
                enable = false,
            },
            tabout = {
                enable = true,
                map = '<M-Tab>',
                hopout = true,
            }
        },
    },
    {
        'RRethy/nvim-treesitter-endwise'  -- lua `end`
    },
    {
        'rachartier/tiny-devicons-auto-colors.nvim',
        dependencies = "nvim-tree/nvim-web-devicons",
        event = "VeryLazy",
        config = function()
            require('tiny-devicons-auto-colors').setup {}
        end,
    },
    {
        'stevearc/oil.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "aznhe21/actions-preview.nvim",
        config = function()
            vim.keymap.set({ "v", "n" }, "<leader>a", require("actions-preview").code_actions)
        end,
    },
    { "neovimhaskell/haskell-vim" },
    {
        "hedyhli/markdown-toc.nvim",
        ft = "markdown",  -- Lazy load on markdown filetype
        cmd = { "Mtoc" }, -- Or, lazy load on "Mtoc" command
        opts = {
            -- Your configuration here (optional)
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    {
        'preservim/vim-markdown',
        dependencies = { 'godlygeek/tabular' },
    },
    {
        'sourcegraph/sg.nvim',
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
        },
        opts = {
            -- configuration goes here
        },
    },
    {
        'MeanderingProgrammer/markdown.nvim',
        main = "render-markdown",
        opts = {},
        name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    },
}
require("lazy").setup(plugins, {})

vim.notify = require("notify")

vim.cmd([[colorscheme melange]])

local builtin = require("telescope.builtin")
local ext = require("telescope").extensions
require('search').setup {
    append_tabs = {
        {
            'Symbols',
            builtin.lsp_dynamic_workspace_symbols,
        },
        {
            'Commits',
            builtin.git_commits,
            available = function()
                return vim.fn.isdirectory('.git') == 1
            end
        },
        {
            'File History',
            builtin.git_file_history,
            available = function()
                return vim.fn.isdirectory('.git') == 1
            end
        },
        {
            'Branches',
            builtin.git_branches,
            available = function()
                return vim.fn.isdirectory('.git') == 1
            end
        },
        {
            'Stash',
            builtin.git_stash,
            available = function()
                return vim.fn.isdirectory('.git') == 1
            end
        },
        {
            'Status',
            builtin.git_status,
            available = function()
                return vim.fn.isdirectory('.git') == 1
            end
        },
        {
            'Smart Open',
            ext.smart_open.smart_open,
        },
        {
            'Buffers',
            builtin.buffers,
        },
    }
}
vim.keymap.set('n', '<leader>o', '<Cmd>lua require("search").open({ tab_name = "Smart Open" })<CR>')
vim.keymap.set('n', '<leader>f', '<Cmd>lua require("search").open({ tab_name = "Symbols" })<CR>')
vim.keymap.set('n', '<leader>g', '<Cmd>lua require("search").open({ tab_name = "Grep" })<CR>')

local config = require("nvim-treesitter.configs")
config.setup({
    ensure_installed = {"lua", "cpp", "rust", "javascript", "python", "typescript", "html", "css", "scss"},
    auto_install = true,
    highlight = { enable = true},
    indent = { enable = true},
})

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

local is_empty_line = function()
    unpack = unpack or table.unpack
    local line, _ = unpack(vim.api.nvim_win_get_cursor(0))
    return vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:match("%S") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

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
}

-- Setup language servers.
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- local extended_caps = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities)
-- lspconfig.svls.setup {
--     capabilities = capabilities
-- }
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
        ['rust-analyzer'] = {
            checkOnSave = {
                command = 'clippy',
            }
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

capabilities.workspace = {
    didChangeWatchedFiles = {
        dynamicRegistration = true,
    },
}
require("lspconfig").markdown_oxide.setup({
    capabilities = capabilities, -- again, ensure that capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
})

local lspconfutil = require 'lspconfig/util'
local root_pattern = lspconfutil.root_pattern("veridian.yml", ".git")
require('lspconfig').veridian.setup {
    cmd = { 'veridian' },
    root_dir = function(fname)
        local filename = lspconfutil.path.is_absolute(fname) and fname
        or lspconfutil.path.join(vim.loop.cwd(), fname)
        return root_pattern(filename) or lspconfutil.path.dirname(filename)
    end;
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

require("lsp_signature").setup({
    handler_opts = { border = "none" },
    hint_prefix = "󰁔 ",
})

vim.keymap.set({'i', 'n', 'v', 'x'}, '<C-c>', '<ESC>', {noremap=true})
vim.keymap.set('i', '<C-x>', '<ESC>ddi')
vim.keymap.set('i', '<Home>', '<ESC>^i')
vim.keymap.set('i', '<C-a>', '<ESC>ggVG')
vim.keymap.set('n', '<C-a>', 'ggVG')
vim.keymap.set('n', '<leader>`', '<Cmd>split<CR><Cmd>terminal zsh<CR>i')
vim.keymap.set('n', '<leader>n', '<Cmd>tabnew<CR>')
vim.keymap.set('n', '<leader><tab>', '<Cmd>tabnext<CR>')
vim.keymap.set('t', '<ESC>', '<C-\\><C-n>', {noremap=true})
vim.keymap.set('n', '<leader>s', '<Cmd>Outline<CR>')
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")
vim.keymap.set('n', '<leader>t', '<Cmd>TodoTelescope<CR>')
vim.keymap.set('n', '<leader>m', '<Cmd>Tele marks<CR>')
vim.keymap.set('v', "<C-j>", "dpV`]", {noremap=true})
vim.keymap.set('v', "<C-k>", "dkPV`]", {noremap=true})
vim.keymap.set('n', '<C-p>', '<Cmd>Legendary<CR>', {noremap=true})
vim.keymap.set({'n', 'v', 'x'}, '<leader>h', '<Cmd>HopWord<CR>')
vim.keymap.set('n', '<leader>dd', '<Cmd>Trouble diagnostics toggle focus=true filter.buf=0<CR>');
vim.keymap.set('n', '<leader>dw', '<Cmd>Trouble diagnostics toggle focus=true<CR>');
vim.keymap.set('n', '<leader>dq', '<Cmd>Trouble qflist toggle focus=true<CR>');
vim.keymap.set('n', '<leader>w', '<Cmd>Trouble lsp toggle focus=true<CR>');
vim.keymap.set('n', '<A-t>', '<Cmd>BufferPick<CR>', {noremap=true});
vim.keymap.set('n', '<C-g>', '<Cmd>Neogit kind=split_above<CR>', {noremap=true});
vim.keymap.set({'v', 'x'}, '<leader>cc', '<Cmd>CodeSnap<CR>', {noremap=true});
vim.keymap.set('n', '<C-s>', '<Cmd>PopupSaveas<CR>', {noremap=true});
vim.keymap.set('n', '<S-U>', '<Cmd>Telescope undo<CR>', {noremap=true})
vim.keymap.set('i', '<C-E>', '{<ESC>A}<ESC>%li<CR><ESC>$i<CR><ESC>k^i', {noremap=true})
vim.keymap.set('n', '<C-BS>', 'd0i<BS><ESC>l', {noremap=true})
vim.keymap.set('i', '<C-BS>', '<C-u><BS>', {noremap=true})
vim.keymap.set('n', '<leader><leader>', '<Cmd>Telescope help_tags<CR>', {noremap=true})
vim.keymap.set('n', '<leader>p', '<Cmd>Telescope neoclip a extra=plus,unnamedplus<CR>', {noremap=true})
vim.keymap.set('n', '<leader>k', '<Cmd>SearchInCurrentFile<CR>')
vim.keymap.set('c', '<C-j>', '<Down>')
vim.keymap.set('c', '<C-k>', '<Up>')
vim.keymap.set('n', '<leader>x', [[:%s/\s\+$//e<cr>]], {noremap=true})
vim.keymap.set('n', '<Del>', vim.notify.dismiss, {noremap=true})
-- vim.keymap.set('n', )

vim.api.nvim_create_user_command('SearchInCurrentFile', function()
    vim.ui.input({ prompt = 'Grep ...'}, function(input)
        if input ~= nil then
            vim.cmd('vimgrep /' .. input .. '/j %')
            vim.cmd('horizontal copen')
        end
    end)
end, {})

vim.api.nvim_create_user_command('PopupSaveas', function()
    vim.ui.input({ prompt = 'Save As: ' }, function(input)
        if input ~= nil then
            if vim.fn.filereadable(input) == 1 then
                local choice = vim.fn.input('File exists. Overwrite? ([y]/n): ')
                if choice ~= 'n' then
                    vim.cmd('saveas! ' .. input)
                    print('File overwritten: ' .. input)
                else
                    print('Cancelled')
                end
            else
                vim.cmd('saveas ' .. input)
                print('File saved as: ' .. input)
            end
        else
            print('Save As cancelled')
        end
    end)
end, {})

require("nvim-treesitter.configs").setup {
    incremental_selection = {
        enable = true,
        keymaps = {
            node_incremental = "v",
            node_decremental = "V",
        },
    },
    refactor = {
        smart_rename = {
            enable = true,
            keymaps = { smart_rename = "grr" },
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = false,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                -- You can optionally set descriptions to the mappings (used in the desc parameter of
                -- nvim_buf_set_keymap) which plugins like which-key display
                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                -- You can also use captures from other query groups like `locals.scm`
                ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
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
            include_surrounding_whitespace = false,
        },
        swap = {
            enable = true,
            swap_next = {
                ["]]"] = "@parameter.inner",
            },
            swap_previous = {
                ["[["] = "@parameter.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]c"] = { query = "@class.outer", desc = "Next class start" },
                --
                -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
                ["]o"] = "@loop.*",
                -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
                --
                -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
                ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]C"] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[c"] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
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
    endwise = { enable = true, },
}

local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- vim way: ; goes to the direction you were moving.
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })


vim.api.nvim_create_user_command('Backup', '!git add . && git commit -S -m "backup" && git push', {})
vim.api.nvim_create_user_command('Config', 'e ~/.config/nvim', {})

require('Comment').setup()
local str = require("cmp.utils.str")
local types = require("cmp.types")
local lspkind = require('lspkind')
cmp.setup {
    formatting = {
        fields = { cmp.ItemField.Abbr, cmp.ItemField.Kind, cmp.ItemField.Menu },
        format = lspkind.cmp_format({
            mode = 'symbol_text', -- show only symbol annotations
            maxwidth = 30, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
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

local null_ls = require("null-ls")
local eslint = require("eslint")

-- local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
-- local event = "BufWritePre" -- or "BufWritePost"
-- local async = event == "BufWritePost"

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

require("outline").setup()

require("todo-comments").setup()

lspconfig.volar.setup{
    filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'}
}

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<M-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<M-.>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<M-S-,>', '<Cmd>BufferMovePrevious<CR>', opts)  -- Configuration for kitty
map('n', '<M-S-.>', '<Cmd>BufferMoveNext<CR>', opts)
map('n', '<M-p>', '<Cmd>BufferPin<CR>', opts);
map('n', '<M-c>', '<Cmd>BufferClose<CR>', opts)

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

-- my snippets
require('snippets')

-- require('neo-tree').setup {
--     filesystem = {
--         filtered_items = {
--           visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
--           hide_dotfiles = true,
--           hide_gitignored = true,
--         },
--     }
-- }

require('telescope').load_extension('git_file_history')
require('telescope').load_extension('undo')

require('codesnap').setup {
    code_font_family = "BerkeleyMono Nerd Font",
    has_line_number = true,
}

require('goto-preview').setup {
    default_mappings = true;
}

require('colorizer').setup {}

require('ibl').setup {}

vim.api.nvim_create_autocmd("LspAttach",  {
    callback = function()
        vim.lsp.inlay_hint.enable(true)
    end,
})

require('neoclip').setup {}

require("oil").setup{
    columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
    },
    win_options = {
        signcolumn = "yes",
    },
    view_options = {
        show_hidden = true,
    },
    constrain_cursor = "editable",
    keymaps = {
        ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
        ["<C-x>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
        ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
    },
}

-- refresh codelens on TextChanged and InsertLeave as well
vim.api.nvim_create_autocmd({ 'TextChanged', 'InsertLeave', 'CursorHold', 'LspAttach' }, {
    pattern = { "*.md" },
    callback = vim.lsp.codelens.refresh,
})

-- trigger codelens refresh
vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })

require("telescope").setup {
    defaults = {
        layout_config = {
            prompt_position = 'top',
        },
        sorting_strategy = 'ascending',
        mappings = {
            i = {
                ["<C-j>"] = require("telescope.actions").move_selection_next,
                ["<C-k>"] = require("telescope.actions").move_selection_previous,
            },
        },
    },
}

vim.env.SRC_ENDPOINT = 'https://sourcegraph.com/'
vim.env.SRC_ACCESS_TOKEN = ''  -- TODO: fill in the token before using it

require('sg').setup {}

-- vim.diagnostic.config({ virtual_text = false })
