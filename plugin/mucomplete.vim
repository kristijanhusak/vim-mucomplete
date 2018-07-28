" Chained completion that works as I want!
" Maintainer: Lifepillar <lifepillar@lifepillar.me>
" License: This file is placed in the public domain

if exists("g:loaded_mucomplete")
  finish
endif
let g:loaded_mucomplete = 1

let s:save_cpo = &cpo
set cpo&vim

imap     <silent> <expr> <plug>(MUcompleteFwd) mucomplete#tab_complete( 1)
imap     <silent> <expr> <plug>(MUcompleteBwd) mucomplete#tab_complete(-1)
imap     <silent> <expr> <plug>(MUcompleteCycFwd) mucomplete#cycle( 1)
imap     <silent> <expr> <plug>(MUcompleteCycBwd) mucomplete#cycle(-1)
imap     <silent> <expr> <plug>(MUcompleteExtendFwd) mucomplete#further( 1)
imap     <silent> <expr> <plug>(MUcompleteExtendBwd) mucomplete#further(-1)

if !get(g:, 'mucomplete#no_mappings', get(g:, 'no_plugin_maps', 0))
  if !hasmapto('<plug>(MUcompleteFwd)', 'i')
    imap <unique> <tab> <plug>(MUcompleteFwd)
  endif
  if !hasmapto('<plug>(MUcompleteBwd)', 'i')
    imap <unique> <s-tab> <plug>(MUcompleteBwd)
  endif
endif

if has('patch-7.4.775') " noinsert was added there
  command -bar -nargs=0 MUcompleteAutoOn call mucomplete#enable_auto()
  command -bar -nargs=0 MUcompleteAutoOff call mucomplete#disable_auto()
  command -bar -nargs=0 MUcompleteAutoToggle call mucomplete#toggle_auto()

  if get(g:, 'mucomplete#enable_auto_at_startup', 0)
    augroup MUcompleteAuto
      autocmd InsertCharPre * noautocmd call mucomplete#insertcharpre()
      if get(g:, 'mucomplete#delayed_completion', 0)
        autocmd TextChangedI * noautocmd call mucomplete#ic_autocomplete()
        autocmd  CursorHoldI * noautocmd call mucomplete#autocomplete()
      else
        autocmd TextChangedI * noautocmd call mucomplete#autocomplete()
      endif
    augroup END
  endif
endif

let &cpo = s:save_cpo
unlet s:save_cpo
