" Fix cursor shape
" Reference: https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes#For_VTE_compatible_terminals_(urxvt,_st,_xterm,_gnome-terminal_3.x,_Konsole_KDE5_and_others),_wsltty_and_Windows_Terminal
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" Common stuff
set encoding=utf-8
set exrc
set undofile
set undodir=~/.vim/undofiles-vanilla
set undolevels=10000
set undoreload=50000
filetype off
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set splitright
set splitbelow
set selectmode=key
set keymodel=startsel
set number
set cursorline
set termguicolors
set clipboard=unnamedplus  " not `+=` in vim
set updatetime=700
set whichwrap+=<,>,[,]
set relativenumber
set signcolumn=yes
set noequalalways
set scrolloff=10
set list
set listchars=trail:█
set noshowmode
set guicursor=n-v-c:block,i:ver25,a:blinkon0
set incsearch
set hlsearch

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

Plug 'savq/melange-nvim'
Plug 'morhetz/gruvbox'
Plug 'embark-theme/vim'
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'vim-airline/vim-airline'
Plug 'itchyny/vim-cursorword'
Plug 'wakatime/vim-wakatime'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'jdhao/better-escape.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'rhysd/conflict-marker.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

call plug#end()

" Color scheme
set background=dark
let g:embark_terminal_italics = 1
silent! colorscheme embark

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
nnoremap , <Cmd>bp<CR>
nnoremap . <Cmd>bn<CR>
nnoremap c <Cmd>Bclose<CR>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"

" LSP related
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_popup_delay = 0
let g:lsp_settings = {
            \   'clangd': { 'cmd': [ 'clangd' ] },
            \}

" Personal keybindings
nnoremap <leader>h <Plug>(easymotion-bd-w)
vnoremap <leader>h <Plug>(easymotion-bd-w)
nnoremap <leader>o <Cmd>Files<CR>
nnoremap <leader>g <Cmd>Rg<CR>
nnoremap gpd <Cmd>LspPeekDefinition<CR>
nnoremap gd <Cmd>LspDefinition<CR>
nnoremap <leader>dd <Cmd>LspDocumentDiagnostics<CR>
nnoremap <leader>dn <Cmd>LspNextDiagnostic<CR>
nnoremap <leader>dp <Cmd>LspPreviousDiagnostic<CR>
nnoremap <leader>r <Cmd>LspRename<CR>
nnoremap <leader>a <Cmd>LspCodeAction<CR>
nnoremap K <Cmd>LspHover<CR>
nnoremap <leader>` <Cmd>term zsh<CR>
nnoremap Q q
nnoremap q <Nop>
inoremap <C-e> {<ESC>A}<ESC>%li<CR><ESC>$i<CR><ESC>k^i
vnoremap <C-j> dpV`]
vnoremap <C-k> dkPV`]
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
nnoremap <C-a> ggVG

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

" Why?!
set noshowmode
