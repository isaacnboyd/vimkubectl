" Copyright (c) Mohammed Saud
"
" MIT License
"
" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the
" "Software""), to deal in the Software without restriction, including
" without limitation the rights to use, copy, modify, merge, publish,
" distribute, sublicense, and/or sell copies of the Software, and to
" permit persons to whom the Software is furnished to do so, subject to
" the following conditions:
"
" The above copyright notice and this permission notice shall be
" included in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
" MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
" NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
" LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
" OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
" WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE."


if exists('g:loaded_vimkubectl')
  finish
endif
let g:loaded_vimkubectl = 1

if !exists('g:vimkubectl_command')
  let g:vimkubectl_command = 'kubectl'
endif

if !exists('g:vimkubectl_timeout')
  let g:vimkubectl_timeout = 5
endif

command -bar -bang -complete=custom,vimkubectl#allResources -nargs=? Kget call vimkubectl#openResourceListView(<q-args>)
command -bar -bang -complete=custom,vimkubectl#allNamespaces -nargs=? Knamespace call vimkubectl#switchOrShowNamespace(<q-args>)
command -bar -bang -complete=custom,vimkubectl#allResourcesAndObjects -nargs=+ Kedit call vimkubectl#editResourceObject(<q-args>)
command -bar -bang -nargs=0 -range=% Kapply <line1>,<line2>call vimkubectl#applyActiveBuffer()

augroup vimkubectl_internal
  autocmd! *
  autocmd BufReadCmd kube://* nested call vimkubectl#overrideBuffer()
augroup END