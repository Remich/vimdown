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
			autocmd Filetype markdown nmap <buffer><leader>mt	<Plug>TransformOperatorNormal
			noremap <unique> <script> <Plug>TransformOperatorNormal		<SID>TransformNormal
			noremap <SID>TransformNormal		:<c-u>set operatorfunc=vimdown#TransformPrompt<cr>g@
		endif
		
		" Transform Operator (Linewise)
		if !hasmapto('<Plug>TransformOperatorLine')
			autocmd Filetype markdown nmap <buffer><leader>mT	<Plug>TransformOperatorLine
			noremap <unique> <script> <Plug>TransformOperatorLine		<SID>TransformLine
			noremap <SID>TransformLine		:<c-u>call vimdown#TransformPrompt('line')<cr>
		endif
		
		" Transform Operator (Visual Mode)
		if !hasmapto('<Plug>TransformOperatorVisual')
			autocmd Filetype markdown vmap <buffer><leader>mt	<Plug>TransformOperatorVisual
			noremap <unique> <script> <Plug>TransformOperatorVisual		<SID>TransformVisual
			noremap <SID>TransformVisual		:<c-u>call vimdown#TransformPrompt('visualmode()')<cr>
		endif

		" Insert footnote after cursor
		" TODO rename
		if !hasmapto('<Plug>VDAddFootnote')
			autocmd Filetype markdown nmap <buffer><leader>mf	<Plug>VDAddFootnote
			noremap <unique> <script> <Plug>VDAddFootnote		<SID>AddFootnote
			noremap <SID>AddFootnote		:<c-u>call vimdown#AddFootnote()<cr>
		endif

		" Insert source
		if !hasmapto('<Plug>VDAddSource')
			autocmd Filetype markdown nmap <buffer><leader>ms	<Plug>VDAddSource
			noremap <unique> <script> <Plug>VDAddSource		<SID>AddSource
			noremap <SID>AddSource		:<c-u>call vimdown#AddSource()<cr>
		endif
		
		" call vimdown#Foobar()<cr>

		let g:vimdown_did_load_mappings = 1
	endif
augroup END

" Restore user's options.
let &cpo = s:save_cpo
unlet s:save_cpo
