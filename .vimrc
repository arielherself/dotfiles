" Fix cursor shape
" Reference: https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes#For_VTE_compatible_terminals_(urxvt,_st,_xterm,_gnome-terminal_3.x,_Konsole_KDE5_and_others),_wsltty_and_Windows_Terminal
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" Fix color in some environments
" if exists('+termguicolors')
" 	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" 	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" 	" maybe need to remove this in gnu screen
" 	set termguicolors
" endif

" Add this if color doesn't work
" set term=xterm-256color

" Common stuff
set encoding=utf-8
set exrc
set undofile
set undodir=~/.vim/undofiles-vanilla  " you have to manually create this directory
set undolevels=10000
set undoreload=50000
" filetype off
set noexpandtab
set tabstop=4
" set softtabstop=4
set shiftwidth=0  " use tabstop value
set splitright
set splitbelow
set selectmode=key
set keymodel=startsel
set number
set cursorline
set clipboard=unnamedplus  " not `+=` in vim
set updatetime=1000
set whichwrap+=<,>,[,]
set relativenumber
set signcolumn=yes
set noequalalways
set scrolloff=10
set list
set listchars=tab:┆\ ,trail:╌
set noshowmode
set guicursor=n-v-c:block,i:ver25,a:blinkon0
set incsearch
set hlsearch
set mouse=a
set ttimeoutlen=0
set wildmenu
set wildoptions=fuzzy,pum
if has('nvim')
	" set signcolumn=yes:2
	" set cmdheight=0
	set pumblend=40
	set winblend=40
endif
if !has('nvim')
	set noesckeys
endif
" set updatetime=0
set ignorecase
set smartcase
set nofixeol

" legacy
set nocompatible
set backspace=indent,eol,start
set history=50
set ruler
" set nomodeline
" set clipboard=unnamed,unnamedplus
syntax on

" set number
" set relativenumber
" set cursorline
" set expandtab
" set tabstop=4
" set softtabstop=4
" set shiftwidth=4
set autoindent
set smartindent

let g:mapleader = " "

" Install vim-plug
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'
Plug 'embark-theme/vim'
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'vim-airline/vim-airline'
Plug 'itchyny/vim-cursorword'
Plug 'wakatime/vim-wakatime'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
" Plug 'arielherself/vim-lsp'
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Plug 'Shougo/ddc.vim'
" Plug 'shun/ddc-vim-lsp'
" Plug 'mattn/vim-lsp-settings'
Plug 'jdhao/better-escape.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'easymotion/vim-easymotion'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'ibhagwan/fzf-lua'
Plug 'rhysd/conflict-marker.vim'
Plug 'ryanoasis/vim-devicons'
" this plugin slows vim down when dealing
" with large files, so I switch to the Nvim version
" Plug 'airblade/vim-gitgutter'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/indentLine'
Plug '907th/vim-auto-save'
Plug 'markonm/traces.vim'
Plug 'stevearc/oil.nvim'
Plug 'vim-scripts/LargeFile'
Plug 'lambdalisue/vim-fern'
	Plug 'lambdalisue/vim-fern-git-status'
	Plug 'lambdalisue/vim-fern-renderer-nerdfont'
Plug 'lambdalisue/nerdfont.vim'

Plug 'folke/todo-comments.nvim'
	Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Use Neovim LSP
Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'hrsh7th/nvim-cmp'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'saadparwaiz1/cmp_luasnip'
		Plug 'L3MON4D3/LuaSnip'
	Plug 'hrsh7th/cmp-emoji'
	Plug 'chrisgrieser/cmp-nerdfont'
	Plug 'hrsh7th/cmp-calc'
Plug 'arielherself/lspkind.nvim'
	Plug 'nvim-tree/nvim-web-devicons'
Plug 'folke/trouble.nvim'
Plug 'kevinhwang91/nvim-ufo'
	Plug 'kevinhwang91/promise-async'
Plug 'rmagatti/goto-preview'
Plug 'ray-x/lsp_signature.nvim'
Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make' }
	" Deps
	Plug 'stevearc/dressing.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'MunifTanjim/nui.nvim'
	Plug 'MeanderingProgrammer/render-markdown.nvim'
	
	" Optional deps
	Plug 'hrsh7th/nvim-cmp'
	Plug 'nvim-tree/nvim-web-devicons' "or Plug 'echasnovski/mini.icons'
	Plug 'HakonHarnes/img-clip.nvim'
	Plug 'zbirenbaum/copilot.lua'
Plug 'MunifTanjim/prettier.nvim'
Plug 'nvim-java/nvim-java'
	Plug 'nvim-java/lua-async-await'
    Plug 'nvim-java/nvim-java-refactor'
    Plug 'nvim-java/nvim-java-core'
    Plug 'nvim-java/nvim-java-test'
    Plug 'nvim-java/nvim-java-dap'
	Plug 'MunifTanjim/nui.nvim'
	Plug 'mfussenegger/nvim-dap'
	Plug 'JavaHello/spring-boot.nvim', { 'commit': '218c0c26c14d99feca778e4d13f5ec3e8b1b60f0' }
	Plug 'williamboman/mason.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'junegunn/vim-peekaboo'
Plug 'mfussenegger/nvim-dap'
	Plug 'nvim-neotest/nvim-nio'
	Plug 'rcarriga/nvim-dap-ui'
	Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'rcarriga/nvim-notify'
Plug 'folke/which-key.nvim'

call plug#end()

" Why?!
set noshowmode
set showcmd


" Color scheme
set background=dark
let g:embark_terminal_italics = 1
let ayucolor = "mirage"
silent! colorscheme embark

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 0
let g:airline_powerline_fonts = 1
nnoremap <M-,> <Cmd>bp<CR>
nnoremap <M-.> <Cmd>bn<CR>
nnoremap <M-c> <Cmd>Bclose<CR>
nnoremap <M-k> <Cmd>tabnext<CR>
nnoremap <M-j> <Cmd>tabprevious<CR>

inoremap <expr> <Tab>	pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"

" LSP related
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_popup_delay = 0
let g:lsp_completion_documentation_delay = 0
let g:lsp_diagnostics_echo_delay = 0
let g:lsp_diagnostics_highlights_delay = 0
let g:lsp_diagnostics_signs_delay = 0
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_virtual_text_delay = 0
let g:lsp_document_code_action_signs_delay = 0
let g:lsp_inlay_hints_delay = 0
let g:lsp_document_highlight_delay = 0
let g:lsp_preview_max_width = 100
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_float_delay = 600
let g:lsp_preview_autoclose = 1
let g:lsp_float_max_width = 100
let g:lsp_inlay_hints_enabled = 1
let g:lsp_diagnostics_virtual_text_padding_left = 12
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_settings = {
			\	'clangd': { 'cmd': [ 'clangd' ] },
			\}
function! s:truncate(str)
	if len(a:str) > 50
		return a:str[:50] . '...'
	else
		return a:str
	endif
endfunction
function! s:truncate_labels(options, matches) abort
	let l:items = []
	for [l:source_name, l:matches] in items(a:matches)
		let l:startcol = l:matches['startcol']
		let l:base = a:options['typed'][l:startcol - 1:]
		for l:item in l:matches['items']
			if stridx(l:item['word'], l:base) == 0
				if has_key(l:item, 'abbr')
					let l:item['abbr'] = s:truncate(l:item['abbr'])
				endif
				call add(l:items, l:item)
			endif
		endfor
	endfor

	call asyncomplete#preprocess_complete(a:options, l:items)
endfunction
let g:asyncomplete_preprocessor = [function('s:truncate_labels')]

" Personal keybindings
if !has('nvim')
	tnoremap <Esc> <C-w>N
else
	tnoremap <ESC> <C-\><C-n>
endif
nnoremap <leader>h <Plug>(easymotion-bd-w)
vnoremap <leader>h <Plug>(easymotion-bd-w)
nnoremap <leader>o <Cmd>Files<CR>
" nnoremap <leader>g <Cmd>Rg<CR>
nnoremap <leader>. <Cmd>Fern . -drawer<CR>
" nnoremap gpd <Cmd>LspPeekDefinition<CR>
" nnoremap gd <Cmd>LspDefinition<CR>
" nnoremap <leader>dd <Cmd>LspDocumentDiagnostics<CR>
" nnoremap <leader>dn <Cmd>LspNextDiagnostic<CR>
" nnoremap <leader>dp <Cmd>LspPreviousDiagnostic<CR>
" nnoremap grr <Cmd>LspRename<CR>
" nnoremap <leader>a <Cmd>LspCodeAction<CR>
" nnoremap K <Cmd>LspHover<CR>
nnoremap Q q
nnoremap q <Nop>
inoremap <C-e> {<ESC>A}<ESC>%li<CR><ESC>$i<CR><ESC>k^i
vnoremap <C-j> dpV`]
vnoremap <C-k> dkPV`]
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
nnoremap <C-a> ggVG
nnoremap gy `[v`]
nnoremap <C-l> <Cmd>noh<CR>
if has('nvim')
	nnoremap <leader>` <Cmd>split<CR><Cmd>term zsh<CR>i
else
	nnoremap <leader>` <Cmd>split<CR><Cmd>term ++curwin zsh<CR>
endif
nnoremap <leader>x <Cmd>%s/\s\+$//e<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bclose
" Delete buffer while keeping window layout (don't close buffer's windows).
" Version 2008-11-18 from http://vim.wikia.com/wiki/VimTip165
if v:version < 700 || exists('loaded_bclose') || &cp
	finish
endif
let loaded_bclose = 1
if !exists('bclose_multiple')
	let bclose_multiple = 1
endif

" Display an error message.
function! s:Warn(msg)
	echohl ErrorMsg
	echomsg a:msg
	echohl NONE
endfunction

" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).
function! s:Bclose(bang, buffer)
	if empty(a:buffer)
		let btarget = bufnr('%')
	elseif a:buffer =~ '^\d\+$'
		let btarget = bufnr(str2nr(a:buffer))
	else
		let btarget = bufnr(a:buffer)
	endif
	if btarget < 0
		call s:Warn('No matching buffer for '.a:buffer)
		return
	endif
	if empty(a:bang) && getbufvar(btarget, '&modified')
		call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)')
		return
	endif
	" Numbers of windows that view target buffer which we will delete.
	let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
	if !g:bclose_multiple && len(wnums) > 1
		call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
		return
	endif
	let wcurrent = winnr()
	for w in wnums
		execute w.'wincmd w'
		let prevbuf = bufnr('#')
		if prevbuf > 0 && buflisted(prevbuf) && prevbuf != btarget
			buffer #
		else
			bprevious
		endif
		if btarget == bufnr('%')
			" Numbers of listed buffers which are not the target to be deleted.
			let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
			" Listed, not target, and not displayed.
			let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
			" Take the first buffer, if any (could be more intelligent).
			let bjump = (bhidden + blisted + [-1])[0]
			if bjump > 0
				execute 'buffer '.bjump
			else
				execute 'enew'.a:bang
			endif
		endif
	endfor
	execute 'bdelete'.a:bang.' '.btarget
	execute wcurrent.'wincmd w'
endfunction
command! -bang -complete=buffer -nargs=? Bclose call <SID>Bclose(<q-bang>, <q-args>)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" indent guide
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1

" indent line
let g:indentLine_char = '┆'
let g:indentLine_first_char = '┆'
let g:indentLine_showFirstIndentLevel = 1

" cursor word
let g:cursorword_delay = 1

let g:auto_save = 0

let g:AutoPairsMultilineClose = 0

" recover cursor shape
autocmd VimLeave * silent !echo -ne "\e[6 q"

" fix split line color
set fillchars+=vert:\│
highlight VertSplit cterm=NONE
highlight VertSplit guifg=#585273

" airline styling
" ref: https://github.com/vim-airline/vim-airline/issues/323#issuecomment-27336312
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.notexists = ' '
let g:airline_symbols.dirty = ' '

let g:fern#renderer = "nerdfont"

if has('nvim')
	" lua require('local-highlight').setup { cw_hlgroup = 'LspReferenceText' }
	lua require('gitsigns').setup { attach_to_untracked = true, current_line_blame = true, current_line_blame_opts = { delay = 0 } }
endif

" fix c++ comment style in Neovim
" ref: https://github.com/tpope/vim-commentary/issues/15#issuecomment-23127749
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s

