function __tmux_fzf
  set -l sessions (tmux list-sessions)
  if [ -z "$sessions" ];
    tmux new-session
    commandline -f repaint
    return
  end
  set -l create_new "Create New Session"
  for x in $create_new $sessions; echo $x; end | fzf | cut -d: -f1 | read select
  if [ -z "$select" ];
    return
  else if [ $select = $create_new ];
    tmux new-session
  else if [ -n "$select" ];
    tmux attach-session -t "$select"
  end
  commandline -f repaint
end
