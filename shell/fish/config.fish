if status is-interactive
    # Commands to run in interactive sessions can go here
end

string match -q "$TERM_PROGRAM" "vscode"
and . (code --locate-shell-integration-path fish)

set -gx LANG en_US.UTF-8

alias vim /opt/homebrew/bin/nvim
alias python /opt/homebrew/bin/python3
alias python3 /opt/homebrew/bin/python3
