
# List all sessions
for session in $(tmux list-sessions -F "#{session_name}"); do
  echo "Session: $session"

  # List all windows in the current session
  for window in $(tmux list-windows -t "$session" -F "#{window_index}:#{window_name}"); do
    window_index=$(echo "$window" | cut -d: -f1)
    window_name=$(echo "$window" | cut -d: -f2)
    echo "  Window [$window_index]: $window_name"

    # List all panes in the current window
    for pane in $(tmux list-panes -t "$session:$window_index" -F "#{pane_index}:#{pane_title}"); do
      pane_index=$(echo "$pane" | cut -d: -f1)
      pane_title=$(echo "$pane" | cut -d: -f2)
      echo "    Pane [$pane_index]: $pane_title"
    done
  done
done
