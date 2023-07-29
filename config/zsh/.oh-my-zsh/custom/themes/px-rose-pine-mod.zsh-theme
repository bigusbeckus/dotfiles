# vim:ft=zsh ts=2 sw=2 sts=2
# ====================================================================

# ROSE PINE THEME ZSH
# Author: http://github.com/pixeljae
# A modified version of agnoster's OH-MY-ZSH theme with rose-pine colors.

# README
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://gist.github.com/1595572).

# ====================================================================

# ROSE PINE PALETTE
# Referenced here (https://rosepinetheme.com/palette.html#rose-pine)
RP_BASE='#191724'
RP_OVERLAY='#26233A'
RP_LOVE='#EB6F92'
RP_GOLD='#F6C177'
RP_ROSE='#EBBCBA'
RP_PINE='#31748F'
RP_FOAM='#9CCFD8'
RP_IRIS='#C4A7E7'

### Segments of the prompt, default order declaration
typeset -aHg AGNOSTER_PROMPT_SEGMENTS=(
    # prompt_context
    # prompt_virtualenv
    prompt_dir
    prompt_git
    prompt_status
    prompt_end
)

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts
CURRENT_BG='NONE'
if [[ -z "$PRIMARY_FG" ]]; then
	PRIMARY_FG=$RP_BASE # Orig. Value was black, but rose pine likes it a bit lighter
fi

# Characters
SEGMENT_SEPARATOR="\ue0b0"
PLUSMINUS="\u00b1"
BRANCH="\ue0a0"
DETACHED="\u27a6"
CROSS="\u2718"
LIGHTNING="\u26a1"
GEAR="\u2699"

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    print -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%}"
  else
    print -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && print -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    print -n "%{%k%}"
  fi
  print -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown
# Context: user@hostname (who am I and where am I)
prompt_context() {
  local user=`whoami`

  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
    prompt_segment $PRIMARY_FG default " %(!.%{%F{$RP_FOAM}%}.)$user@%m " # Orig. Value is {yellow}
  fi
}

# Git: branch/detached head, dirty status
prompt_git() {
  local color ref
  is_dirty() {
    test -n "$(git status --porcelain --ignore-submodules)"
  }
  ref="$vcs_info_msg_0_"
  if [[ -n "$ref" ]]; then
    if is_dirty; then
      color=$RP_LOVE # Love is for when your git is dirty
      ref="${ref} $PLUSMINUS"
    else
      color=$RP_ROSE # Rose for when your git is clean
      ref="${ref} "
    fi
    if [[ "${ref/.../}" == "$ref" ]]; then
      ref="$BRANCH $ref"
    else
      ref="$DETACHED ${ref/.../}"
    fi
    prompt_segment $color $PRIMARY_FG
    print -n " $ref"
  fi
}

#### PX-Note: Original Value was blue $PRIMARY_FG (Format = ...Background...Foreground...) but rose pine likes softer colors
# Dir: current working directory
prompt_dir() {
	# prompt_segment $RP_OVERLAY $RP_IRIS ' %1~ ' 
	prompt_segment $PRIMARY_FG default ' %1~ ' 
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{$RP_LOVE}%}$CROSS" # Orig. Value: red
  [[ $UID -eq 0 ]] && symbols+="%{%F{$RP_GOLD}%}$LIGHTNING" # Orig. Value: yellow
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{$RP_FOAM}%}$GEAR" # Orig. value. cyan

	#### PX-Note: Original value was...$PRIMARY_FG default...
  [[ -n "$symbols" ]] && prompt_segment $RP_BASE default " $symbols "
}

# Display current virtual environment
#### PX-Note: Can't test this cause no virtualenv on my system :(  Someone do something cause I won't bother
prompt_virtualenv() {
  if [[ -n $VIRTUAL_ENV ]]; then
    color=$RP_GOLD
    prompt_segment $color $PRIMARY_FG
    print -Pn " $(basename $VIRTUAL_ENV) "
  fi
}

## Main prompt
prompt_agnoster_main() {
  RETVAL=$?
  CURRENT_BG='NONE'
  for prompt_segment in "${AGNOSTER_PROMPT_SEGMENTS[@]}"; do
    [[ -n $prompt_segment ]] && $prompt_segment
  done
}

prompt_agnoster_precmd() {
  vcs_info
  PROMPT='%{%f%b%k%}$(prompt_agnoster_main) '
}

prompt_agnoster_setup() {
  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  prompt_opts=(cr subst percent)

  add-zsh-hook precmd prompt_agnoster_precmd

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes false
  zstyle ':vcs_info:git*' formats '%b'
  zstyle ':vcs_info:git*' actionformats '%b (%a)'
}

prompt_agnoster_setup "$@"
