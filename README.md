# tmux-polybar

tmux polybar integration

```
#bash script to get info of tmux and diplay in polybar
#add following to polybar config and

[module/tmux_poly]
type = custom/script
exec = ~/tmux-polybar/tmux-poly.sh
tail = true
click-left = kill -USR1 %pid%

#also add tmux_poly to workspaces, best to the end of the left side
modules-left = xworkspaces xwindow tmux_poly

```
