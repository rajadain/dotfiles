# Based on https://gist.github.com/tommyip/cf9099fa6053e30247e5d0318de2fb9e


# Based on https://gist.github.com/bastibe/c0950e463ffdfdfada7adf149ae77c6f
# Changes:
# * Instead of overriding cd, we detect directory change. This allows the script to work
#   for other means of cd, such as z.
# * Update syntax to work with new versions of fish.

# Optimized Venv Auto-activation

# where to look for virtual environments
function __venv_base
  # If we are in the home directory, stop immediately. 0ms cost.
  if test "$PWD" = "$HOME"
    return 1
  end

  # Fast check: are we at the root of a git repo?
  if test -d .git
    echo "$PWD"
    return 0
  end

  # Only now do we call the git binary
  command git rev-parse --show-toplevel 2>/dev/null
end

# find the virtualenv, whatever it is called
function __venv --argument-names dir
  set -l VENV_DIR_NAMES env .env venv .venv
  for venv_dir in $dir/$VENV_DIR_NAMES
    if test -f "$venv_dir/bin/activate.fish"
      echo "$venv_dir"
      return
    end
  end
  return 1
end

function __handle_venv_activation --argument-names dir
  set -l venv_dir (__venv $dir)
  if test $status -ne 0
    # no virtual env found, deactivate any existing virtual env
    if set -q VIRTUAL_ENV
      deactivate
    end
    return
  end

  if test "$VIRTUAL_ENV" != "$venv_dir"
    source "$venv_dir/bin/activate.fish"
  end
end

function __auto_source_venv --on-variable PWD --description "Activate/Deactivate virtualenv"
  status --is-command-substitution; and return

  # Optimization: If we are already in a Venv and the PWD is still inside 
  # that Venv's parent, do nothing.
  if set -q VIRTUAL_ENV
    set -l venv_parent (dirname "$VIRTUAL_ENV")
    if string match -q "$venv_parent*" "$PWD"
      return
    end
  end

  set -l target_dir (__venv_base)
  __handle_venv_activation "$target_dir"
end

# Initial call on shell start
__auto_source_venv