" Filename:   init.vim
" Github:     https://github.com/ghidalgo93/dotfiles
" Maintainer: Gerardo Hidalgo-Cuellar 

" Plugins {{{
call plug#begin('~/.config/nvim/plugged') " begin vim-plug manager

" Autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'folke/which-key.nvim'
Plug 'folke/zen-mode.nvim'
Plug 'windwp/nvim-autopairs' "nvim autopairing
Plug 'numToStr/Comment.nvim' "comments
Plug 'sainnhe/everforest' "colorscheme plugin
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'unblevable/quick-scope' " show hints when using F and T to navigate
Plug 'kyazdani42/nvim-tree.lua' " actual file tree
Plug 'tpope/vim-fugitive'
Plug 'romgrk/barbar.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'
Plug 'kosayoda/nvim-lightbulb'
Plug 'antoinemadec/FixCursorHold.nvim'
autocmd CursorHold,CursorHoldI *.ts,*.js,*.py,*.c,*.cpp lua require'nvim-lightbulb'.update_lightbulb()
Plug 'folke/todo-comments.nvim'
Plug 'L3MON4D3/LuaSnip'
Plug 'akinsho/nvim-toggleterm.lua'
Plug 'simrat39/symbols-outline.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'tpope/vim-projectionist'
Plug 'mbbill/undotree'
Plug 'kamykn/spelunker.vim'
Plug 'echasnovski/mini.nvim', { 'branch': 'stable' }
Plug 'lukas-reineke/indent-blankline.nvim'

" neovim lsp plugins
"
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig' "native nvim lsp
Plug 'folke/lsp-colors.nvim'
Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }

" neovim tree sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'jose-elias-alvarez/null-ls.nvim'

" neovim telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'axkirillov/telescope-changed-files'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-symbols.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'

Plug 'EthanJWright/vs-tasks.nvim'

" Copilot
Plug 'github/copilot.vim'
imap <silent><script><expr> <C-F> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true


call plug#end() " Initialize plugin system

" Source lua config files
luafile ~/.config/nvim/lua/plugins/lsp-installer.lua
luafile ~/.config/nvim/lua/plugins/cmp.lua
luafile ~/.config/nvim/lua/plugins/nvim-tree.lua
luafile ~/.config/nvim/lua/plugins/which-key.lua
luafile ~/.config/nvim/lua/plugins/telescope.lua
luafile ~/.config/nvim/lua/plugins/lsp.lua
luafile ~/.config/nvim/lua/plugins/trouble.lua
luafile ~/.config/nvim/lua/plugins/web-devicons.lua
luafile ~/.config/nvim/lua/plugins/lightbulb.lua
luafile ~/.config/nvim/lua/plugins/todo-comments.lua
luafile ~/.config/nvim/lua/plugins/toggleterm.lua
luafile ~/.config/nvim/lua/plugins/symbols-outline.lua
luafile ~/.config/nvim/lua/plugins/gitsigns.lua
luafile ~/.config/nvim/lua/plugins/lualine.lua
luafile ~/.config/nvim/lua/plugins/zen-mode.lua
luafile ~/.config/nvim/lua/plugins/nvim-autopairs.lua
luafile ~/.config/nvim/lua/plugins/comment.lua
luafile ~/.config/nvim/lua/plugins/mini/starter.lua
luafile ~/.config/nvim/lua/plugins/mini/surround.lua


" quick-scope settings  
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']


" Colors {{{
syntax enable

" Color settings
if has('termguicolors') " Important!!
	set termguicolors
endif

" The configuration options should be placed before `colorscheme forest-night`.
let g:everforest_ui_contrast = 'high'
let g:everforest_transparent_background = 0
let g:everforest_enable_italic = 1
let g:everforest_disable_italic_comment = 0
let g:everforest_better_performance = 1
let g:everforest_diagnostic_line= 1
let g:everforest_diagnostic_virtual_text = 'colored'
colorscheme everforest
" }}}

" Tabs and Spaces {{{
set tabstop=4 softtabstop=4 	" Set tabstop 
set shiftwidth=4 							" Set shiftwidth 
set expandtab
set smartindent
" }}}

" UI {{{
let mapleader = " " 	" Map leader to space 
inoremap jk <esc>
tnoremap jk <C-\><C-n>
set cursorline 				" Hightlight cursorline
set showmatch 				" Shows matching brackets
set number 						"show lines 
set relativenumber 		"set relative numbers
set laststatus=2 			" Show status bar
set ruler 						" Always show current position
set hlsearch 					" Search Highlighting
set incsearch 				" Highlighting while typing
set nowrap
set scrolloff=8
set signcolumn=yes
set colorcolumn=80
set nospell

" undo
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" movement between vim panes
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Splits
set splitbelow
set splitright

" Encoding? 
set encoding=UTF-8
" }}}

" On open jump to the last known cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
