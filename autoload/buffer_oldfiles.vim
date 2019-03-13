function! s:Oldfiles()
  " walk all the windows, any window that has the
  " buffer_oldfiles_scratch variable set in it is from
  " a previous call to s:Oldfiles and can be cleaned up
  for win in range(1, winnr('$'))
    if getwinvar(win, 'buffer_oldfiles_scratch')
      execute win . 'windo close'
    endif
  endfor
  " redirect the stuff that normally prints to the console
  " to the variable "output". Note that in "redir => output"
  " output refers to the variable itself not its contents.
  " If VimL were more like C, this would be written
  "
  "     redir => &output
  "
  redir => output
  execute "oldfiles"
  redir END
  " create a new pane thingy but vertically. seems to create it
  " on the left by default which is cool.
  vnew
  " tag this particular window with out variable outfiles_scratch
  " so we know to kill it later.
  let w:buffer_oldfiles_scratch = 1
  " our new window is ephemeral, give it ephemeralish properties.
  " NOTE: explicitly make the buffer modifiable for the moment.
  " we set it to nomodifiable after trimming the line numbers.
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile modifiable
  " dump the contents of output as lines
  call setline(1, split(output, "\n"))
  " remove the leading numbers. Leading numbers make it harder to ``gf" the lines we want.
  execute "%s/^\\d\\+: //"
  " go to the top line
  execute "1"
  " make it nomodifiable
  setlocal nomodifiable
endfunction
