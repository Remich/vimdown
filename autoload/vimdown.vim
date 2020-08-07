function! vimdown#TransformPrompt(type)

	let transformation = input("")
	redraw

	if transformation ==# "ul"
		call vimdown#TransformToList(a:type)
	elseif transformation ==# "h1"
		call vimdown#TransformToHeading(a:type, 1)
	elseif transformation ==# "h2"
		call vimdown#TransformToHeading(a:type, 2)
	elseif transformation ==# "h3"
		call vimdown#TransformToHeading(a:type, 3)
	elseif transformation ==# "h4"
		call vimdown#TransformToHeading(a:type, 4)
	elseif transformation ==# "h5"
		call vimdown#TransformToHeading(a:type, 5)
	elseif transformation ==# "h6"
		call vimdown#TransformToHeading(a:type, 6)
	else
		echom "ERROR: No such transformation: '".transformation."'."
	endif

endfunction

function! vimdown#LineToList(num)
	let old = getline(a:num)	
	call setline(a:num, "- ".old)
endfunction

function! vimdown#TransformToList(type)
	if a:type ==# 'visualmode()'
		let start = getpos("'<")
		let stop  = getpos("'>")
		let lines = range(start[1], stop[1])
		call map(l:lines, 'vimdown#LineToList(v:val)')
	elseif a:type ==# 'line'
		execute "normal! I- "
	else
		return
	endif
endfunction

function! vimdown#LineToHeading(num, level)
	let old = getline(a:num)	
	let str = ""
	let r = range(0, a:level-1)
	for i in r
		let str = str."#"
	endfor
	call setline(a:num, str." ".old)
endfunction

function! vimdown#TransformToHeading(type, level)
	if a:type ==# 'visualmode()'
		let start = getpos("'<")
		let stop  = getpos("'>")
		let lines = range(start[1], stop[1])
		call map(lines, 'vimdown#LineToHeading(v:val, a:level)')
	elseif a:type ==# 'line'
		call vimdown#LineToHeading(getpos(".")[1], a:level)
	else
		return
	endif
endfunction

function! vimdown#TransformTemplate()
	if a:type ==# 'v' "characterwise visual
		normal! `<v`>y
	elseif a:type ==# 'V' "linewise visual
		" do something
	elseif a:type ==# 'line'
		execute "normal! I- "
	elseif a:type ==# 'char'
		normal! `[v`]y
	else
		return
	endif
endfunction

function! vimdown#TransformToCode()
endfunction
