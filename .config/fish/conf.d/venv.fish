# Based on https://gist.github.com/tommyip/cf9099fa6053e30247e5d0318de2fb9e


# Based on https://gist.github.com/bastibe/c0950e463ffdfdfada7adf149ae77c6f
# Changes:
# * Instead of overriding cd, we detect directory change. This allows the script to work
#   for other means of cd, such as z.
# * Update syntax to work with new versions of fish.

# Optimized Venv Auto-activation

# where to look for virtual environments
function __venv_base
  # Optimization: Check if .git exists in the current dir first (fastest)
  if test -d .git
    pwd
    # Otherwise, check if we are in a git sub-directory
  else if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
    command git rev-parse --show-toplevel 2>/dev/null
  else
    pwd
  end
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

function __auto_source_venv --on-variable PWD --description "Activate/Deactivate virtualenv on directory change"
  status --is-command-substitution; and return
  __handle_venv_activation (__venv_base)
end

# Initial call on shell start
__auto_source_venv