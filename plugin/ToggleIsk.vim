" vim: set fdm=marker fdl=0: vim modeline( set )

" 'isk' stand for 'iskeyword'
" &用于获取vim 'option' 变量
" 提供一个通用的vim函数, 内部用Python实现, 这样只用实现一次Python代码

" only load once: because use <unique> map
" so don't support hot load (If changed, You need to restart vim to load this plugin)

if !exists("g:ToggleIskLoaded")
    let g:ToggleIskLoaded = 1
else
    finish
endif

if !has("python") && !has("python3")
    "echom  "ToggleIsk need python or python3 support"
    echoerr "'ToggleIsk' need vim support support' python' or 'python3'"
    finish
endif


fun! s:Toggle_isk(delimit, target)
"{{{
py3 <<EOF
import  vim
def toggle_isk(delimit, add_target):
#{{{     这里要用Python注释
    isk = vim.eval("&isk")

    keys = isk.split(delimit)

    # toggle
    if add_target not in keys:
        keys.append(add_target)
    else:
        keys.remove(add_target)

    new_isk = delimit.join(keys)
    vim.command("set  isk=%s" % new_isk)
    print("old isk: %s" % isk)
    print("new isk: %s" % new_isk)
#}}}     这里要用Python注释
delimit = vim.eval("a:delimit")     # python get vim argument
target  = vim.eval("a:target")      # python get vim argument
toggle_isk(delimit, target)

EOF
"}}}
endfun

fun! s:Toggle_isk_hypen()
    call s:Toggle_isk(",", "-")
endfun

fun! s:Toggle_isk_underline()
    call s:Toggle_isk(",", "_")
endfun

fun! s:Toggle_isk_dot()
    call s:Toggle_isk(",", ".")
endfun

fun! s:Toggle_isk_slash()
    call s:Toggle_isk(",", "/")
endfun

fun! s:Toggle_isk_colon()
    call s:Toggle_isk(",", ":")
endfun

fun! s:Toggle_isk_sharp()
    call s:Toggle_isk(",", "#")
endfun


" You can remap by this
nnoremap <unique>  <Plug>Toggle_isk_hypen      :call <SID>Toggle_isk_hypen    ( )<CR>
nnoremap <unique>  <Plug>Toggle_isk_underline  :call <SID>Toggle_isk_underline( )<CR>
nnoremap <unique>  <Plug>Toggle_isk_dot        :call <SID>Toggle_isk_dot      ( )<CR>
nnoremap <unique>  <Plug>Toggle_isk_slash      :call <SID>Toggle_isk_slash    ( )<CR>
nnoremap <unique>  <Plug>Toggle_isk_colon      :call <SID>Toggle_isk_colon    ( )<CR>
nnoremap <unique>  <Plug>Toggle_isk_sharp      :call <SID>Toggle_isk_sharp    ( )<CR>

" 应该搞个字典: map "key" + <Plug>
" 然后写个函数来映射
if maparg('<Leader>t-')
    echom("<Leader>t- is already used")
endif
if !hasmapto("<Plug>Toggle_isk_hypen")
    nmap <unique>  <Leader>t-  <Plug>Toggle_isk_hypen
endif


if !hasmapto("<Plug>Toggle_isk_underline")
    nmap  <Leader>t_  <Plug>Toggle_isk_underline
endif

if !hasmapto("<Plug>Toggle_isk_dot")
    nmap  <Leader>t.  <Plug>Toggle_isk_dot
endif

if !hasmapto("<Plug>Toggle_isk_slash")
    nmap  <Leader>t/  <Plug>Toggle_isk_slash
endif

if !hasmapto("<Plug>Toggle_isk_colon")
    nmap  <Leader>t:  <Plug>Toggle_isk_colon
endif

if !hasmapto("<Plug>Toggle_isk_sharp")
    nmap  <Leader>t#  <Plug>Toggle_isk_sharp
endif
