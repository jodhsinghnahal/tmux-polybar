# # Get current session, window, and pane
# current_session=$(tmux display-message -p '#S')
# current_window=$(tmux display-message -p '#W')
# current_pane=$(tmux display-message -p '#P')
#
# echo "Current session: $current_session"
# echo "Current window: $current_window"
# echo "Current pane: $current_pane"
#
# # List all sessions
# for session in $(tmux list-sessions -F "#{session_name}"); do
#   echo "Session: $session"
#
#   # List all windows in the current session
#   for window in $(tmux list-windows -t "$session" -F "#{window_index}:#{window_name}"); do
#     window_index=$(echo "$window" | cut -d: -f1)
#     window_name=$(echo "$window" | cut -d: -f2)
#     echo "  Window [$window_index]: $window_name"
#
#     # List all panes in the current window
#     tmux list-panes -t "$session:$window_index" -F "#{pane_index}:#{pane_current_command}" | while IFS=: read -r pane_index command; do
#       # Fallback to "unknown" if the command is empty
#       command="${command:-unknown}"
#       echo "    Pane [$pane_index]: $command"
#     done
#   done
# done

# Get current session, window, and pane
current_session=$(tmux display-message -p '#S')
current_window=$(tmux display-message -p '#W')

# Format the list of panes in the current window
pane_info=$(tmux list-panes -F "#{pane_index}:#{pane_current_command}" | awk '{print $1}' | paste -sd ' ')

# Assemble the formatted output
output="working on $current_session |$current_window|$pane_info"

echo "$output"
