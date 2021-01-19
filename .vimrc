filetype plugin indent on
syntax on

function! UseTabs()
  set tabstop=2     " Size of a hard tabstop (ts).
  set shiftwidth=2  " Size of an indentation (sw).
  set noexpandtab   " Always uses tabs instead of space characters (noet).
  set autoindent    " Copy indent from current line when starting a new line (ai).
endfunction

function! UseSpaces()
  set tabstop=2     " Size of a hard tabstop (ts).
  set shiftwidth=2  " Size of an indentation (sw).
  set expandtab     " Always uses spaces instead of tab characters (et).
  set softtabstop=0 " Number of spaces a <Tab> counts for. When 0, featuer is off (sts).
  set autoindent    " Copy indent from current line when starting a new line.
  set smarttab      " Inserts blanks on a <Tab> key (as per sw, ts and sts).
endfunction

function! UseVisuals()
  set ruler
  set number
  set showcmd
  # set showmatch
  set nu
  hi CursorLine cterm=NONE ctermbg=NONE ctermfg=white guibg=darkred guifg=white
  set cursorline
  hi CursorColumn cterm=NONE ctermbg=blue ctermfg=white guibg=darkred guifg=white
  set cursorcolumn
  set visualbell
  set errorbells
endfunction

function! EnableSearch()
  set incsearch
  set hlsearch
  set ignorecase
  set smartcase
  hi Search cterm=NONE ctermfg=black ctermbg=white
endfunction


call UseTabs()
call UseVisuals()
call EnableSearch()



