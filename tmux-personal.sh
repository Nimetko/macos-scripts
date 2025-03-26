#!/usr/bin/env bash

session=~/x/personal

if [[ -z $session ]]; then
    exit 0
fi

session_name=$(basename "$session" | tr . _)

# If we're inside tmux and already in the desired session, do nothing
if [[ -n $TMUX ]] && [[ $(tmux display-message -p '#S') == "$session_name" ]]; then
    exit 0
fi

if ! tmux has-session -t "$session_name" 2> /dev/null; then 
    tmux new-session -s "$session_name" -c "$session" -d
fi

tmux switch-client -t "$session_name"
#

# mine, same as on windows
echo "session: $session"
cd session

# tmux neww bash -c "nvim ~/x/personal/legoTodoTickets"
