if status is-interactive
    # Commands to run in interactive sessions can go here
    set -x EDITOR micro
    set -x GPG_TTY (tty)
end
