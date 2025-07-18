#!/usr/bin/env bash

session=~/x/personal

if [[ -z $session ]]; then
    exit 0
fi

session_name=$(basename "$session" | tr . _)

# Use the first argument as the file, or default to "legoTodoTickets"
file="${1:-legoTodoTickets}"
window_name=$(basename "$file" | sed 's/\.[^.]*$//')   # Strip extension for window name

# Start the session if it doesn't exist
if ! tmux has-session -t "$session_name" 2>/dev/null; then 
    tmux new-session -s "$session_name" -c "$session" -d
fi

# Check if a window with the given name already exists in the session
if tmux list-windows -t "$session_name" | grep -q "$window_name"; then
    # Switch to the session and that window
    tmux switch-client -t "$session_name"
    tmux select-window -t "$session_name:$window_name"
else
    # Create a new window with the given name and open the file
    tmux new-window -t "$session_name" -n "$window_name" -c "$session" "nvim $session/$file"
    tmux switch-client -t "$session_name"
    tmux select-window -t "$session_name:$window_name"
fi

echo "session: $session, file: $file, window: $window_name"
