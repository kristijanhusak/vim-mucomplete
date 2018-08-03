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

if !has('patch-8.0.0283')
  inoremap <silent> <expr> <plug>(MUcompletePopupCancel) mucomplete#auto#popup_exit("\<c-e>")
  inoremap <silent> <expr> <plug>(MUcompletePopupAccept) mucomplete#auto#popup_exit("\<c-y>")
  inoremap <silent> <expr> <plug>(MUcompleteCR) mucomplete#auto#popup_exit("\<cr>")
endif

if !get(g:, 'mucomplete#no_mappings', get(g:, 'no_plugin_maps', 0))
  if !hasmapto('<plug>(MUcompleteFwd)', 'i')
    imap <unique> <tab> <plug>(MUcompleteFwd)
  endif
  if !hasmapto('<plug>(MUcompleteBwd)', 'i')
    imap <unique> <s-tab> <plug>(MUcompleteBwd)
  endif
endif

if has('patch-7.4.775') " noinsert was added there
  command -bar -nargs=0 MUcompleteAutoOn call mucomplete#auto#enable()
  command -bar -nargs=0 MUcompleteAutoOff call mucomplete#auto#disable()
  command -bar -nargs=0 MUcompleteAutoToggle call mucomplete#auto#toggle()

  if get(g:, 'mucomplete#enable_auto_at_startup', 0)
    call mucomplete#auto#enable()
  endif
endif

let &cpo = s:save_cpo
unlet s:save_cpo
