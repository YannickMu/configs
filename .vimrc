filetype on
syntax on
set encoding=utf-8

set autoindent
set number
set norelativenumber
set mouse=a
set foldmethod=manual
set wildmenu
set nospell
set tabstop=2
set shiftwidth=2
set noexpandtab
set hlsearch
set listchars=space:·,tab:‣\ ,trail:█,eol:󰌑
set fillchars+=vert:\
set cursorline
set t_Co=256
set list
set showtabline=2
set tabline=%!MyTabLine()
autocmd BufRead *.asm silent! set syntax=nasm
autocmd BufRead *.asm silent! set filetype=nasm

"Colors
colorscheme elflord
hi Normal ctermbg=235
hi VertSplit ctermbg=None
hi EndOfBuffer ctermbg=None
hi EndOfBuffer ctermfg=236
hi Number ctermfg=13
hi LineNr ctermfg=5
hi Keyword ctermfg=3
hi StatusLine ctermbg=232
hi vimCommand ctermfg=32
hi Include ctermfg=1
hi Conditional ctermfg=1
hi Todo ctermbg=220
hi String ctermfg=28
hi CursorColumn ctermbg=59
hi CursorColumn ctermfg=46
hi Comment ctermfg=245 cterm=Italic
hi SpecialKey ctermfg=245
hi NonText ctermfg=245
hi Function ctermfg=199
hi Special ctermfg=91

hi TabLineFill ctermbg=235 ctermfg=197
hi TabLine ctermbg=197 ctermfg=235
hi TabLineSel ctermbg=235 ctermfg=197

autocmd Syntax * syntax match CustFunc /\(.*\)\@<=\w\+\((\)\@=/
autocmd Syntax * syntax match CustMethod /\(\.\)\@<=\w\+\((\)\@=/
autocmd Syntax * syntax match CustBr /[(){}]/

hi CustFunc ctermfg=199
hi CustMethod ctermfg=92
hi CustBr ctermfg=172

hi StatusLine ctermfg=5 ctermbg=None
hi StatusLineNC ctermfg=5 ctermbg=None

"Keybindings
imap <c-a> <esc>:set list!<CR>:startinsert<CR>
nmap gp :%!prettier --use-tabs --stdin-filepath %<CR>
noremap <BS><BS> :-tabnext<CR>
noremap <CR><CR> :tabnext<CR>
noremap <c-a> :set list!<CR>
nnoremap <esc><esc> :set hls!<cr>
nnoremap <c-s> :w<CR>
inoremap <c-s> <esc>:w<CR>a
inoremap <c-x> <esc>:wq<CR>
tmap <c-p> <c-w>:call Toggle()<CR>
nmap <c-p> :call Toggle()<CR>

"Statusline
set statusline=%#SL_FileType#\ %Y%#SL_Inset#%#SL_Inset#\ %f\ %#SL_Inset#%#SL_FileType#\ %{&encoding}%#SL_Upset#%=%#SL_Inset#%#SL_Inset#\ %L\ %#SL_Inset#%#SL_Inset#\ %c\ %#SL_Inset#%#SL_Inset#\ chr:\ 0x%B\ %#SL_Inset#%#SL_Inset#\ %{&ff=='unix'?'\ LF\ ':'CRLF'}\ %#SL_Inset#%#SL_FileType#\ %{&modified?'+':'\ '}\ 
set laststatus=2

hi SL_FileType ctermbg=197 ctermfg=0
hi SL_Upset ctermbg=197 ctermfg=none
hi SL_Inset ctermbg=235 ctermfg=197


"Tabline
function MyTabLine()
	let s = ''
	for i in range(tabpagenr('$'))
		" select the highlighting
		if i + 1 == tabpagenr()
			let s ..= '%#TabLineSel#'
		else
			let s ..= '%#TabLine#'
		endif

		" set the tab page number (for mouse clicks)
		let s ..= '%' .. (i + 1) .. 'T'

		" the label is made by MyTabLabel()
		if i + 1 == tabpagenr()
			let s ..= '%{MyTabLabel(' .. (i + 1) .. ')}'
		else
			let s ..= ' %{MyTabLabel(' .. (i + 1) .. ')} '
		endif
	endfor

	" after the last tab fill with TabLineFill and reset tab page nr
	let s ..= '%#TabLineFill#%T'

	" right-align the label to close the current tab page
	if tabpagenr('$') > 1
		let s ..= '%=%#TabLine#%999XX '
	endif

	return s
endfunction

function MyTabLabel(n)
	let buflist = tabpagebuflist(a:n)
	let winnr = tabpagewinnr(a:n)
	return fnamemodify(bufname(buflist[winnr - 1]), ':t')
endfunction

" Float Term
hi FloatTerm ctermbg=235
hi FloatTerm_Border ctermbg=none ctermfg=197
function FloatTerm()
	let g:buf = term_start('bash', #{hidden: 1, term_finish: "close"})
	let g:hidden = 1
endfunction

function Toggle()
	if term_getstatus(g:buf) != "running"
		let g:buf = term_start('bash', #{hidden: 1, term_finish: "close"})
		let g:hidden = 1
	endif
	if g:hidden
		let g:hidden = 0
		let g:winid = popup_create(g:buf, #{hidden: 0, minwidth: 70, minheight: 20, highlight: 'FloatTerm', border: [1, 1, 1, 1], borderchars: ['━', '┃', '━', '┃', '', '┓', '┛', '┗'], borderhighlight: ['FloatTerm_Border', 'FloatTerm_Border', 'FloatTerm_Border', 'FloatTerm_Border']})
	else
		let g:hidden = 1
		call popup_clear(1)
	endif
endfunction


call FloatTerm()

