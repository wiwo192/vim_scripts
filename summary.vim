" Add -- xxx {{{ ... -- }}} around visual selected lines.
" <space> while in visual mode to trigger.
function! AddSummary(startline, endline)
" No benefits: it doesn't update child/parent lvls
"    let l:myfoldlvl = foldlevel(a:startline) + 1
"    let l:beginmarker = "      -- __summary__ {{{" . l:myfoldlvl
"    let l:endmarker = "      -- }}}" . l:myfoldlvl

    let l:beginmarker = "      -- __summary__ {{{"
    let l:endmarker = "      -- }}}"

    call append(a:endline, l:endmarker)
    call append(a:startline - 1, l:beginmarker)
    call cursor(a:startline, 1)
    
    " Open fold and replace __summary__
    "   zo: open fold
    "   f_: search for _ in __summary__
    "   cw: delete __summary__ and goto insert mode
    call feedkeys("zof_\"_cw")
endfunction

function! AddSummary2(startline, endline)
    call append(a:endline, "      -- ")
    call append(a:startline - 1, "      -- __summary__ ")
    execute a:startline . ", " . a:endline + 1 . "fold"
endfunction


function! SummaryModeOn()
  command! -range=% AddSummary call AddSummary(<line1>, <line2>)
  vnoremap <buffer> <space> :AddSummary<cr>
  nnoremap <buffer> <space> za
  nnoremap <buffer> <2-LeftMouse> za

  highlight link Summary Keyword
  syntax match Summary /^      --.*/
  setlocal foldmethod=marker
endfunction

nnoremap <leader>s :call SummaryModeOn()<cr>
