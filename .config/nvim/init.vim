" Plugins
if ! filereadable(expand('<sfile>:p:h').'/autoload/plug.vim')
    echo "Downloading junegunn/vim-plug to autoload/plug.vim"
    silent execute '!curl -fLo "'.expand('<sfile>:p:h').'/autoload/plug.vim"
        \ --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin(expand('<sfile>:p:h').'/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-peekaboo'
Plug 'itchyny/lightline.vim'
Plug 'vimwiki/vimwiki'
Plug 'cespare/vim-toml'
if has('nvim-0.5')
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
endif
call plug#end()

" Settings
syntax on
set go=a
set encoding=utf-8
set mouse=niv
set clipboard+=unnamedplus
set scrolloff=5
set hidden
set number relativenumber
set tabstop=4 shiftwidth=4 softtabstop=-1
set expandtab autoindent smartindent
set nohlsearch incsearch ignorecase smartcase
set nowrap sidescroll=1 scrolloff=7
set spelllang=en_us,en_gb,nb_no
set colorcolumn=80,100
set listchars=tab:\|\ ,extends:>,precedes:<,trail:+,nbsp:~
set laststatus=2
set completeopt=menuone,noselect
let mapleader=" "
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 25
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_list = [{'path': '~/Documents/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
let g:rust_recommended_style = 0
let g:compe = {}
let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true

" Highlight
highlight LineNR ctermfg=Grey
highlight ColorColumn ctermbg=Black
highlight NonText ctermfg=DarkGrey
highlight Pmenu ctermfg=Grey ctermbg=Black
highlight PmenuSel ctermfg=Black ctermbg=Cyan
highlight LspDiagnosticsVirtualTextError ctermfg=red
highlight LspDiagnosticsVirtualTextWarning ctermfg=cyan
highlight LspDiagnosticsVirtualTextInformation ctermfg=yellow
highlight LspDiagnosticsVirtualTextHint ctermfg=green

" Mappings
noremap <silent> <leader>e :Lexplore<CR>
nnoremap <silent> <Leader><CR> :source $MYVIMRC <bar> echo "Reloaded ".fnamemodify($MYVIMRC, ':t')<CR>
nnoremap <silent> <Leader>M :call <SID>append_modeline()<CR>
nnoremap <silent> <Leader>W :%s/\s\+$//e<CR>
nnoremap <silent> <leader>s :!shellcheck %<CR>
nnoremap <leader>r :Run
nnoremap <silent> <leader>l :set list!<CR>
vnoremap <leader>p "_dP
inoremap <silent><expr> <CR> compe#confirm('<CR>')
nnoremap <leader>ff :Telescope find_files<cr>
nnoremap <leader>fF :Telescope find_files hidden=true<cr>
nnoremap <leader>fg :Telescope live_grep<cr>
nnoremap <leader>fb :Telescope buffers<cr>
nnoremap <leader>fh :Telescope help_tags<cr>

" Disable arrow keys
for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exec 'noremap' key '<Nop>'
    exec 'inoremap' key '<Nop>'
endfor

" Functions/commands
function! s:append_modeline()
    let l:modeline = printf(' vim: set ts=%d sw=%d tw=%d %set :',
                \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
    let l:modeline = substitute(&commentstring, '%s', l:modeline, '')
    call append(line('$'), ['', l:modeline])
endfunction

command! -nargs=* Run :!%:p <args>

" Autocmd
augroup FileTypeStuff
    autocmd!
    autocmd FileType * set formatoptions-=cro
    autocmd FileType markdown setlocal wrap
    autocmd FileType lua setlocal suffixesadd=.lua
                \ includeexpr=substitute(v:fname,'\\.','/','g')
    autocmd FileType php setlocal commentstring=//\ %s
    autocmd FileType xdefaults setlocal commentstring=!\ %s
augroup END

" Lua require
if has('nvim-0.5')
    lua require('myownstuff')
endif

" vim: set ts=4 sw=4 tw=0 et :
