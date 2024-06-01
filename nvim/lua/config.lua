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
-- vim.cmd("set guicursor=i:ver25-blinkon500-blinkoff500,a:ver25-iCursor")
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
    { 'nvim-lua/plenary.nvim' },
    { 'rcarriga/nvim-notify' },
    {"loctvl842/monokai-pro.nvim", name="monokai", priority=1000},
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        dependencies = {
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
        opts = {
            inlay_hints = { enabled = true, },
            -- codelens = { enabled = true, },
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
    -- {
    --   "EdenEast/nightfox.nvim",
    -- },
    {
    	"arielherself/arshamiser.nvim",
        branch = "dev",
	    dependencies = {
		    "arsham/arshlib.nvim",
		    "famiu/feline.nvim",
		    "rebelot/heirline.nvim",
		    "kyazdani42/nvim-web-devicons",
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
    { 'hedyhli/outline.nvim' },
    {
        "folke/todo-comments.nvim",
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
    { 'Civitasv/cmake-tools.nvim' },
    { 'p00f/cphelper.nvim' },
    -- { dir = '/home/user/Documents/melange-nvim' },
    { "arielherself/melange-nvim" },
    { 'hrsh7th/vim-vsnip' },
    {
      "NeogitOrg/neogit",
      dependencies = {
        "sindrets/diffview.nvim",        -- optional - Diff integration

        -- Only one of these is needed, not both.
        "nvim-telescope/telescope.nvim", -- optional
        "ibhagwan/fzf-lua",              -- optional
      },
      config = true
    },
    -- { 'Exafunction/codeium.vim' },
    { "mistricky/codesnap.nvim", build = "make" },
    { 'rmagatti/goto-preview' },
    {
        "FabianWirth/search.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" }
    },
    { 'NvChad/nvim-colorizer.lua' },
    { 'debugloop/telescope-undo.nvim' },
    { "arielherself/neodev.nvim", opts = {} },
    {
      "AckslD/nvim-neoclip.lua",
    },
    {
      "danielfalk/smart-open.nvim",
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
}
require("lazy").setup(plugins, {})

vim.notify = require("notify")

require("monokai-pro").setup({
  transparent_background = true,
  terminal_colors = true,
  devicons = true, -- highlight the icons of `nvim-web-devicons`
  styles = {
    comment = { italic = true },
    keyword = { italic = false }, -- any other keyword
    type = { italic = false }, -- (preferred) int, long, char, etc
    storageclass = { italic = false }, -- static, register, volatile, etc
    structure = { italic = false }, -- struct, union, enum, etc
    parameter = { italic = false }, -- parameter pass in function
    annotation = { italic = false },
    tag_attribute = { italic = false }, -- attribute of tag in reactjs
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
-- vim.cmd.colorscheme("duskfox")

local builtin = require("telescope.builtin")
require('search').setup {
    append_tabs = {
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
    }
}
vim.keymap.set('n', '<leader>o', require("telescope").extensions.smart_open.smart_open, {})
-- vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>g', '<Cmd>lua require("search").open({ tab_name = "Grep" })<CR>')

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
    { name = "emoji" },
    { name = "nerdfont" },
    { name = "calc" },
  }),
})

-- Setup language servers.
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
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
    ['rust-analyzer'] = {},
  },
}
lspconfig.lua_ls.setup {
    capabilities = capabilities
}

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
})

vim.keymap.set({'i', 'n', 'v', 'x'}, '<C-z>', '<Nop>', {noremap=true})
vim.keymap.set({'i', 'n', 'v', 'x'}, '<C-c>', '<ESC>', {noremap=true})
vim.keymap.set('i', '<C-x>', '<ESC>ddi')
vim.keymap.set('i', '<Home>', '<ESC>^i')
vim.keymap.set('i', '<C-a>', '<ESC>ggVG')
vim.keymap.set('n', '<C-a>', 'ggVG')
vim.keymap.set('n', '<leader>`', '<Cmd>split<CR><Cmd>terminal zsh<CR>i')
vim.keymap.set('n', '<leader>n', '<Cmd>tabnew<CR>')
vim.keymap.set('t', '<ESC>', '<C-\\><C-n>', {noremap=true})
vim.keymap.set('n', '<leader>s', '<Cmd>Outline<CR>')
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")
vim.keymap.set('n', '<leader>t', '<Cmd>TodoTelescope<CR>')
vim.keymap.set('n', '<leader>m', '<Cmd>Tele marks<CR>')
vim.keymap.set('v', "<C-S-j>", "dpV`]")
vim.keymap.set('v', "<C-S-k>", "dkPV`]")
vim.keymap.set('n', '<C-p>', '<Cmd>Legendary<CR>', {noremap=true})
vim.keymap.set({'n', 'v', 'x'}, '<leader>h', '<Cmd>HopWord<CR>')
vim.keymap.set('n', '<leader>dd', '<Cmd>TroubleToggle document_diagnostics<CR>');
vim.keymap.set('n', '<leader>dw', '<Cmd>TroubleToggle workspace_diagnostics<CR>');
vim.keymap.set('n', '<leader>dq', '<Cmd>TroubleToggle quickfix<CR>');
vim.keymap.set('n', '<leader>w', '<Cmd>TroubleToggle lsp_definitions<CR>');
vim.keymap.set('n', '<leader>r', '<Cmd>TroubleToggle lsp_references<CR>');
vim.keymap.set('n', '<A-t>', '<Cmd>BufferPick<CR>', {noremap=true});
vim.keymap.set('n', '<C-g>', '<Cmd>Neogit kind=split_above<CR>', {noremap=true});
vim.keymap.set({'v', 'x'}, '<leader>cc', '<Cmd>CodeSnap<CR>', {noremap=true});
vim.keymap.set('n', '<C-s>', '<Cmd>PopupSaveas<CR>', {noremap=true});
vim.keymap.set('n', '<S-U>', '<Cmd>Telescope undo<CR>', {noremap=true})
vim.keymap.set('n', '<C-CR>', 'i{<ESC>A}<ESC>%li<CR><ESC>$i<CR><ESC>k^', {noremap=true})
vim.keymap.set('n', '<C-BS>', 'd0i<BS><ESC>l', {noremap=true})
vim.keymap.set('i', '<C-BS>', '<C-u><BS>', {noremap=true})
vim.keymap.set('n', '<leader><leader>', '<Cmd>Telescope help_tags<CR>', {noremap=true})
vim.keymap.set('n', '<leader>p', '<Cmd>Telescope neoclip a extra=plus,unnamedplus<CR>', {noremap=true})

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
  end)end, {})

require("nvim-treesitter.configs").setup {
    incremental_selection = {
        enable = true,
        keymaps = {
            node_incremental = "v",
            node_decremental = "V",
        },
    },
}

vim.api.nvim_create_user_command('Backup', '!git add . && git commit -S -m "backup" && git push', {})
vim.api.nvim_create_user_command('Config', 'Explore ~/.config/nvim', {})

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
                    word = word
                    -- word = vim.lsp.util.parse_snippet(word)
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

require("outline").setup()

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
map('n', '<M-S-,>', '<Cmd>BufferMovePrevious<CR>', opts)  -- Configuration for kitty
map('n', '<M-S-.>', '<Cmd>BufferMoveNext<CR>', opts)
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


-- my snippets
require('snippets')

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
require('telescope').load_extension('undo')

require('codesnap').setup {
    code_font_family = "Fira Code",
    has_line_number = true,
}

require('goto-preview').setup {
    default_mappings = true;
}

require('colorizer').setup {}

require('ibl').setup {}

vim.api.nvim_create_autocmd("LspAttach",  {
    callback = function(ev)
        vim.lsp.inlay_hint.enable(true)
    end,
})

require('neoclip').setup {}

