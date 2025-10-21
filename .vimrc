filetype on
syntax on
set encoding=utf-8

set autoindent
set number
set norelativenumber
set mouse=a
set foldmethod=manual
set nofoldenable
set wildmenu
set nospell
set tabstop=2
set shiftwidth=2
set noexpandtab
set hlsearch
set listchars=space:·,tab:-->,trail:█,eol:󰌑
set fillchars+=vert:\|
set cursorline
set t_Co=256
set list
set showtabline=2
set tabline=%!CustTabline()
autocmd BufRead *.asm silent! set syntax=nasm
autocmd BufRead *.asm silent! set filetype=nasm

set directory=./

"Colors
colorscheme elflord
hi Normal ctermbg=233
hi VertSplit ctermbg=None ctermfg=197
hi EndOfBuffer ctermbg=None
hi EndOfBuffer ctermfg=236
hi Number ctermfg=13
hi LineNr ctermfg=198
hi Keyword ctermfg=3
hi StatusLine ctermbg=232
hi vimCommand ctermfg=32
hi Include ctermfg=1
hi Conditional ctermfg=1
hi Todo ctermbg=199 ctermfg=16
hi Statement ctermfg=161
hi String ctermfg=46
hi CursorColumn ctermbg=59
hi CursorColumn ctermfg=46
hi Comment ctermfg=245 cterm=Italic
hi SpecialKey ctermfg=245
hi NonText ctermfg=245
hi Function ctermfg=226
hi Special ctermfg=91
hi Folded ctermbg=233 ctermfg=245

hi TabLineFill ctermbg=235 ctermfg=197
hi TabLine ctermbg=197 ctermfg=235
hi TabLineSel ctermbg=235 ctermfg=197

autocmd Syntax * syntax match CustFunc /\(.*\)\@<=\w\+\((\)\@=/
autocmd Syntax * syntax match CustMethod /\(\.\)\@<=\w\+\((\)\@=/
autocmd Syntax * syntax match CustBr /[(){}]/

hi CustFunc ctermfg=226
hi CustMethod ctermfg=92
hi CustBr ctermfg=172

hi StatusLine ctermfg=5 ctermbg=None
hi StatusLineNC ctermfg=5 ctermbg=None

"Keybindings
imap <c-a> <esc>:set list!<CR>:startinsert<CR>
noremap <BS><BS> :-tabnext<CR>
noremap <CR><CR> :tabnext<CR>
noremap <c-a> :set list!<CR>
nnoremap <esc><esc> :set hls!<cr>
nnoremap <c-s> :w<CR>
inoremap <c-s> <esc>:w<CR>a
inoremap <c-x> <esc>:wq<CR>

" move line with ctrl + up/down
noremap <c-UP> :m -2<CR>
noremap <c-DOWN> :m +1<CR>

"Statusline
set statusline=%#SL_FileType#\ %Y%#SL_Inset#%#SL_Inset#\ %f\ %#SL_Inset#%#SL_FileType#\ %{&encoding}%#SL_Upset#%=%#SL_Inset#%#SL_Inset#\ %L\ %#SL_Inset#%#SL_Inset#\ %c\ %#SL_Inset#%#SL_Inset#\ chr:\ 0x%B\ %#SL_Inset#%#SL_Inset#\ %{&ff=='unix'?'\ LF\ ':'CRLF'}\ %#SL_Inset#%#SL_FileType#\ %{&modified?'󱠡':'\ '}\ 
set laststatus=2

hi SL_FileType ctermbg=197 ctermfg=0
hi SL_Upset ctermbg=197 ctermfg=none
hi SL_Inset ctermbg=235 ctermfg=197


"Tabline
def CustTabline(): string
	var tabline = ' '
	#loop through each tab page
	for i in range(tabpagenr('$'))
		if i + 1 == tabpagenr()
			tabline ..= '%#SL_Inset#%#TabLineSel#'
		else
			tabline ..= '%#TabLine#  '
		endif

		tabline ..= '%' .. (i + 1) .. 'T'   #set the tab page number (for mouse clicks)

		var n = ''				#temp str for buf names
		var m = 0					  #modified counter
		m = 0
		for b in tabpagebuflist(i + 1)
			if bufname(b) == ''
				n ..= '[NEW]'
			else
				n ..= fnamemodify(bufname(b), ':t')
			endif
			n ..= '  '
			if getbufvar(b, "&modified") && getbufvar(b, "&buftype") != "terminal"
				m += 1
			endif
		endfor

		if m > 1
			tabline ..= m .. '󱠡 '
		elseif m > 0
			tabline ..= '󱠡 '
		endif

		n = substitute(n, '  $', '', '')   #remove last and
		tabline ..= n
		if i + 1 == tabpagenr()
			tabline ..= '%#SL_Diag#'
		else
			tabline ..= '  '
		endif
	endfor
	tabline ..= '%#TabLineFill#%T'
	return tabline
enddef
