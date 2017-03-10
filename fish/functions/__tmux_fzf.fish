function __tmux_fzf
  #tmux-start.sh
  set -l sessions (tmux list-sessions)
  if [ -z "$sessions" ];
    tmux new-session
    commandline -f repaint
    return
  end
  set -l create_new "Create New Session"
  set sessions $create_new $sessions
  for x in $sessions; echo $x; end | fzf | cut -d: -f1 | read select
  if [ $select = $create_new ];
    tmux new-session
  else if [ -n "$select" ];
    tmux attach-session -t "$select"
  end
  commandline -f repaint
end
