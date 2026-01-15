" An example for a vimrc file.
"
" Maintainer:	The Vim Project <https://github.com/vim/vim>
" Last Change:	2023 Aug 10
" Former Maintainer:	Bram Moolenaar <Bram@vim.org>
"
" To use it, copy it to
"	       for Unix:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"	 for MS-Windows:  $VIM\_vimrc
"	      for Haiku:  ~/config/settings/vim/vimrc
"	    for OpenVMS:  sys$login:.vimrc


" When started as "evim", evim.vim will already have done these settings, bail
" out.
"if v:progname =~? "evim"
"  finish
"endif


" Get the defaults that most users want.
"source $VIMRUNTIME/defaults.vim

"if has("vms")
"  set nobackup		" do not keep a backup file, use versions instead
"else
"  set backup		" keep a backup file (restore to previous version)
"  if has('persistent_undo')
"    set undofile	" keep an undo file (undo changes after closing)
"  endif
"endif


"if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
"  set hlsearch
"endif


" Put these in an autocmd group, so that we can delete them easily.
"augroup vimrcEx
"  au!

  " For all text files set 'textwidth' to 78 characters.
"  autocmd FileType text setlocal textwidth=78
"augroup END


" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
"if has('syntax') && has('eval')
"  packadd! matchit
"endif

" Actual config

set number              " affiche les numéros de ligne
set relativenumber      " numérotation relative (utile pour naviguer)
syntax on               " active la coloration syntaxique
set tabstop=4           " largeur d'une tabulation = 4 espaces
set expandtab           " convertit les tabs en espaces
set autoindent          " indentation automatique
set background=dark     " optimise les couleurs pour fond sombre

" Chargement automatique selon le type de fichier

autocmd FileType python set tabstop=4 shiftwidth=4 expandtab
autocmd FileType yaml set tabstop=2 shiftwidth=2 expandtab

" Configuration file for vim
" set modelines=0		" CVE-2007-2438


" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements

" set nocompatible	" Use Vim defaults instead of 100% vi compatibility
" set backspace=2		" more powerful backspacing

" Don't write backup file if vim is being called by "crontab -e"
" au BufWrite /private/tmp/crontab.* set nowritebackup nobackup

" Don't write backup file if vim is being called by "chpass"
" au BufWrite /private/etc/pw.* set nowritebackup nobackup

" let skip_defaults_vim=1
