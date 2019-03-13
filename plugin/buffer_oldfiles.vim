if exists('g:buffer_oldfiles_loaded')
  finish
endif

let g:buffer_oldfiles_loaded = 1
let g:buffer_oldfiles_version = '0.0.1'

command! -nargs=0 Oldfiles silent call buffer_oldfiles#Oldfiles()
