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

# Start the session if it doesn't exist
if ! tmux has-session -t "$session_name" 2>/dev/null; then 
    tmux new-session -s "$session_name" -c "$session" -d
fi

# Check if the file is already open in any pane/window of this session
file="legoTodoTickets"
already_open=$(tmux list-panes -t "$session_name" -F "#{pane_current_command} #{pane_current_path}" | grep nvim | grep "$session")

if [[ -z "$already_open" ]]; then
    tmux send-keys -t "$session_name" "nvim $session/$file" C-m
fi

# Switch to the session
tmux switch-client -t "$session_name"

# Debug/log info (optional)
echo "session: $session"
