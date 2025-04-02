#!/usr/bin/env zsh

function mycsv {
    column -t -s, -n "$@" | less -F -S -X -K
}

function mytsv {
    column -t -s $'\t' -n "$@" | less -F -S -X -K
}

# "alert" for long running commands.  Use like so: sleep 2; alert
function alert() { notify-send "$@"; }
function alert_pipe() { while read OUTPUT; do notify-send "$OUTPUT"; done }
