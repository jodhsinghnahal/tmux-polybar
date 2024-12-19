
# List all tmux windows
tmux list-windows -F '#S:#I #W' | while read -r window; do
    session=$(echo "$window" | cut -d: -f1)
    window_index=$(echo "$window" | cut -d: -f2 | awk '{print $1}')
    window_name=$(echo "$window" | cut -d: -f2- | awk '{print $2}')

    echo "Session: $session"
    echo "Window Index: $window_index"
    echo "Window Name: $window_name"
    echo "-----------------------------------"

    # List panes in the current window
    tmux list-panes -t "$session:$window_index" -F '  Pane ID: #D
  Pane Title: #T
  Pane Index: #P
  Hostname (Full): #H
  Hostname (Short): #h
  Window Flags: #F
  Window Index: #I
  Session Name: #S
  Window Name: #W'
    echo
done
