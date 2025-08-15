let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/mps/repo/github/mpsffap/mps
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +1 playbooks/desktop.yml
badd +5 roles/terminal-nvim/tasks/main.yml
badd +11 playbooks/terminal.yml
badd +28 roles/terminal-shells/tasks/bash.yml
badd +3 inventory/hosts
badd +24 inventory/group_vars/all/all.yml
badd +4 inventory/group_vars/all/common.yml
badd +11 playbooks/all.yml
badd +6 playbooks/os.yml
badd +30 roles/terminal-shells/tasks/zsh.yml
badd +24 roles/terminal-homedir/tasks/main.yml
badd +6 playbooks/extras.yml
badd +83 ~/mps/repo/github/mps-nvim/installers/nvim.bash
badd +51 roles/terminal-nvim/tasks/essentials.yml
badd +1 roles/terminal-nvim/tasks/config.yml
badd +1 roles/terminal-nvim/tasks/cargo.yml
badd +18 roles/terminal-nvim/tasks/nvim.yml
badd +13 roles/terminal-nvim/tasks/lazygit.yml
badd +45 roles/desktop-qtile/tasks/config.yml
badd +10 playbooks/optimize.yml
badd +63 templates/dotfiles/.config/bashrc/.bashrc
badd +11 roles/desktop-rofi/tasks/essentials.yml
badd +36 templates/snippets/autostart.sh
badd +4 templates/snippets/qtilerun.bash
badd +7 templates/dotfiles/.config/qtile/qtile.desktop
badd +24 templates/dotfiles/.config/qtile/groups.py
badd +17 templates/dotfiles/.config/qtile/layouts.py
badd +251 templates/dotfiles/.config/kitty/kitty.conf
badd +1 roles/terminal-shells/tasks/main.yml
badd +15 roles/terminal-vim/tasks/main.yml
badd +23 templates/dotfiles/.vimrc
argglobal
%argdel
$argadd playbooks/desktop.yml
edit roles/terminal-vim/tasks/main.yml
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
balt roles/terminal-shells/tasks/zsh.yml
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 17 - ((16 * winheight(0) + 16) / 32)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 17
normal! 0
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=10
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
