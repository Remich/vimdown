" File: vimdown.vim
" Author: René Michalke <rene@renemichalke.de>
" Description: A Vim Plugin which provides some utilities for editing markdown
" files.

" Disable loading of plugin.
if exists("g:vimdown_load") && g:vimdown_load == 0
	finish
endif

" Save user's options, for restoring at the end of the script.
let s:save_cpo = &cpo
set cpo&vim

augroup vimdown
	autocmd!

	" ============
	" = MAPPINGS =
	" ============

	if exists("g:vimdown_did_load_mappings") == v:false
		
		" Transform Operator (Normal Mode)
		if !hasmapto('<Plug>TransformOperatorNormal')
			autocmd Filetype markdown nmap <buffer><leader>t	<Plug>TransformOperatorNormal
		endif
		noremap <unique> <script> <Plug>TransformOperatorNormal		<SID>TransformNormal
		noremap <SID>TransformNormal		:<c-u>set operatorfunc=vimdown#TransformPrompt<cr>g@
		
		" Transform Operator (Linewise)
		if !hasmapto('<Plug>TransformOperatorLine')
			autocmd Filetype markdown nmap <buffer><leader>T	<Plug>TransformOperatorLine
		endif
		noremap <unique> <script> <Plug>TransformOperatorLine		<SID>TransformLine
		noremap <SID>TransformLine		:<c-u>set operatorfunc=vimdown#TransformPrompt('line')<cr>
		
		" Transform Operator (Visual Mode)
		if !hasmapto('<Plug>TransformOperatorVisual')
			autocmd Filetype markdown vmap <buffer><leader>t	<Plug>TransformOperatorVisual
		endif
		noremap <unique> <script> <Plug>TransformOperatorVisual		<SID>TransformVisual
		noremap <SID>TransformVisual		:<c-u>set operatorfunc=vimdown#TransformPrompt('visualmode()')<cr>
		
		" call vimdown#Foobar()<cr>

		let g:vimdown_did_load_mappings = 1
	endif
augroup END

" Restore user's options.
let &cpo = s:save_cpo
unlet s:save_cpo
