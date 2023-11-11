# tmux commands

## start

tmux

## end

Ctrl-a is the prefix
type the prefix before any command

:kill-server // to end session

## split screen

ctrl + a + % to make a vertical split. ctrl + a + " to make a Horizontal split. ctrl + a + left arrow to move to the left pane.

## send command to all panes

ctrl + e

## stop sending commands to all panes

ctrl + E

Prefix I // to install tmux plugins

ctrl + a + % to make a vertical split. ctrl + a + " to make a Horizontal split. ctrl + a + left arrow to move to the left pane. ctrl + a + " to make a Horizontal split.
Ctrl-a is the prefix
:kill-server // to end session
Prefix I // to install tmux plugins

ctrl + a + % to make a vertical split. ctrl + a + " to make a Horizontal split. ctrl + a + left arrow to move to the left pane. ctrl + a + " to make a Horizontal split.

<https://medium.com/@bingorabbit/tmux-propagate-to-all-panes-9d2bfb969f01>
setw synchronize-panes on
setw synchronize-panes off

# add to tmux.conf

bind e setw synchronize-panes on
bind E setw synchronize-panes off

# resize pane

:resize-pane -U 10 (Resizes the current pane upward by ten cells)
:resize-pane -R 10 (Resizes the current pane right by ten cells)
:resize-pane -D 10 (Resizes the current pane down by ten cells)
:resize-pane -L 10 (Resizes the current pane left by ten cells)

nvim ~/.tmux.conf
set -g mouse on
tmux source-file ~/.tmux.conf
