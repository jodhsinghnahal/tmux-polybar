
# Function to check if the active window is tmux
is_tmux_active() {
  # Get the window class or title of the currently focused window
  active_window=$(xdotool getwindowfocus getwindowname 2>/dev/null)

  # Check if the title contains "tmux" (or a specific pattern if customized)
  [[ "$active_window" == *"tmux"* ]]
}

# Function to get tmux session and window information
get_tmux_info() {
  # Get the current tmux session and window details
  tmux display-message -p '#S:#I.#P'
}

# Loop to check every second
while true; do
  if is_tmux_active; then
    # Fetch and print tmux information if tmux is active
    tmux_info=$(get_tmux_info)
    echo "Active tmux session and window: $tmux_info"
  else
    echo "Tmux is not the active window."
  fi

  # Wait for 1 second before the next check
  sleep 1
done
