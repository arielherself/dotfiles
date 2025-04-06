" my filetype file
if exists("did_load_filetypes")
	finish
endif
augroup filetypedetect
	au! BufRead,BufNewFile *.ipynb		setfiletype markdown
	au! BufRead,BufNewFile *.fmj		setfiletype java
augroup END

