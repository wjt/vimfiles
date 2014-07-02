" vim: ff=unix

setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
" PEP-8 sanctions raising the line length to 100 provided docstrings are
" wrappped at 72.
setlocal textwidth=100
setlocal smarttab
setlocal expandtab

" set indentation correctly
if has("python")
python << EOP
import vim

def find_indent_mode(max_lines=100):
    last_started_block = False
    tab_counts = 0
    space_counts = 0
    for i in xrange(min(max_lines, len(vim.current.buffer))):
        line = vim.current.buffer[i].rstrip()
        if not line:
            continue
        first_word = line.split(None, 1)[0]
        started_block = last_started_block
        if first_word in ('if', 'while', 'for', 'class', 'def') and line.endswith(':'):
            last_started_block = True
        else:
            last_started_block = False
        if started_block:
            tab_counts += line.startswith('\t')
            space_counts += line.startswith('  ')
    if tab_counts > 2 * space_counts:
        return '\t'
    elif space_counts > 2 * tab_counts:
        return ' '
    return None

mode = find_indent_mode()
if mode == '\t':
    vim.command('setlocal noet')
elif mode == ' ':
    vim.command('setlocal et')
EOP
endif

