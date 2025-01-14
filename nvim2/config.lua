# vim:foldmethod=marker:foldmarker={{{,}}}:

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

-- {{{ LSP Related
vim.diagnostic.config({ virtual_text = false })

--- {{{ nvim-treesitter setup
local config = require("nvim-treesitter.configs")
config.setup {
    ensure_installed = {"lua", "cpp", "rust", "javascript", "python", "typescript", "html", "css", "scss"},
    auto_install = true,
    highlight = { enable = true},
    indent = { enable = true},
}
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
lspconfig.nushell.setup {}
--- }}}

--- {{{ Smart inlay hints
vim.api.nvim_create_autocmd("LspAttach",  {
    callback = function()
        vim.lsp.inlay_hint.enable(true)
    end,
})

vim.api.nvim_create_autocmd('InsertEnter', {
  callback = function()
    vim.lsp.inlay_hint.enable(false)
  end
})

vim.api.nvim_create_autocmd('InsertLeave', {
  callback = function()
    vim.lsp.inlay_hint.enable(true)
  end
})
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
local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
for _, ls in ipairs(language_servers) do
    require('lspconfig')[ls].setup({
        capabilities = capabilities
        -- you can add other fields for setting up lsp server in this table
    })
end
require('ufo').setup()

-- }}}
