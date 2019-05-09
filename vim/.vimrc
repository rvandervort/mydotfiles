call pathogen#infect()

" Highlight trailing whitespace
match ErrorMsg '\s\+$'


" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap  <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
imap <C-Space> <C-x><C-o>
inoremap <F2> <c-o>:w<cr>
"inoremap { {<cr>}<esc><S-o>
nnoremap Q <nop>

let mapleader=","
set autoread
set mouse=n
set hidden
set encoding=utf8
set backspace=indent,eol,start
set relativenumber
set nocompatible
set ts=2
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
syntax on
filetype on
filetype plugin on
filetype indent on


set noswapfile
set dir=~/tmp
set number
set runtimepath^=~/.vim/bundle/ctrlp.vim
if exists("g:ctrl_user_command")
  unlet g:ctrlp_user_command
endif
set wildignore+=*/target/*,/.git/,*/project/target/resolution-cache/*,*/node_mdules/*,*/tmp/*,*.so,*.swp,*.zip,*.class,*.jar

" Quick access to .vimrc
map <f12> :tabe ~/.vimrc<CR>
nnoremap <Leader>v :tabe ~/.vimrc<CR>



" Buffer handling shortcuts
map <C-b> <esc>:BufExplorer<cr>
map gb :bnext<cr>
map gB :bprev<cr>
map gz :bdelete<cr>

nnoremap <Leader>l :ls<CR>
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>f :bn<CR>
nnoremap <Leader>g :e#<CR>
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>
" remove trailing whitespace
nnoremap <Leader>rtw :%s/\s\+$//e<CR>


" show the buffer number in the status line.
set laststatus=2 statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

syntax enable
set background=dark
colorscheme darkblue

autocmd FileType java set makeprg=javac\ %
set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#

"ruby
au BufRead,BufNewFile *.rabl setf ruby
au BufRead,BufNewFile *.jbuilder setf ruby
au BufRead,BufNewFile *.ejs setf html
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1


"scala
au BufRead,BufNewFile *.sbt setf scala

"coffeescript
let coffee_make_options='--bare'

"Go
au BufRead,BufNewFile *.go setf go

"Impex
au BufRead,BufNewFile *.impex set filetype=impex

"Rspec Helpers
"" Testing
function! RunTests(filename)
" Write the file and run tests for the given filename
  :w
  :silent !echo;echo;echo;echo;echo
  exec ":!bundle exec rspec " . a:filename
endfunction

function! SetTestFile()
" Set the spec file that tests will be run for.
  let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
  if a:0
    let command_suffix = a:1
  else
    let command_suffix = ""
  endif

" Run the tests for the
" previously-marked file.
  let in_spec_file = match(expand("%"), '$') != -1
  if in_spec_file
    call SetTestFile()
  elseif
    !exists("t:grb_test_file")
    return
  end
  call RunTests(t:grb_test_file.command_suffix)
endfunction

function! RunNearestTest()
  let spec_line_number = line('.')
  call RunTestFile(":" . spec_line_number)
endfunction

function! InsertJava()
  let file_name=expand("%:t")
  :let class_name = split(file_name, "\\.")[0]

  :read $HOME/Dropbox/Google\ Prep/Cracking\ The\ Coding\ Interview/common/CommonStart.java
  setf java

  execute "%s/<<CLASSNAME>>/" . class_name . "/g"
endfunction
map <c-j> :call InsertJava()<cr>

function! RunWip(...)
  :w
  :silent !echo;echo;echo;echo;echo
  exec ":!bundle exec rspec -t @wip"
endfunction

" Remove trailing whitespaces
function! Rtw()
  :%s/\s\+$//e<CR>
endfunction

map <leader>N :NERDTree<cr>

"run feature file
map <leader>w :call RunWip()<cr>
"run spec for current file
map <leader>f :call RunTestFile()<cr>
"run spec for what is under cursor
map <leader>t :call RunNearestTest()<cr>
"run spec for entire app
map <leader>a :call RunTests('spec')<cr>
