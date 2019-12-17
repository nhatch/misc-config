# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# for CUDA
export PATH=/usr/local/cuda-9.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}:/usr/local/lib

# added by Miniconda3 installer
export PATH="/home/nathan/miniconda3/bin:$PATH"

export EDITOR=vim

# the following courtesy of jeroen janssens
export MARKPATH=$HOME/.marks
function jump { 
    cd -P $MARKPATH/$1* 2>/dev/null || echo "No such mark: $1"
}
function mark { 
    mkdir -p $MARKPATH; ln -s "$(pwd)" $MARKPATH/$1
}
function unmark { 
    rm -i $MARKPATH/$1 
}
function marks {
    ls -l $MARKPATH | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}
alias j='jump'

alias grp='git grep'
alias gdi='git diff'
alias gst='git status'
alias gco='git checkout'
alias gc='git commit'
alias gbr='git branch'
alias gsh='git show'
alias glg='git log'
alias gdih='git diff HEAD'
alias gp='git push'

alias open='xdg-open'

export DATASETS_FOLDER=~/research/datasets/
export EXPERIMENTS_FOLDER=~/research/experiments/

export PYTHONPATH=~/research/FAR-HO:~/research/ExperimentManager:$PYTHONPATH
export PYTHONPATH=$PYTHONPATH:~/research/bullet3/examples/pybullet/gym/:~/research/bullet3/examples/
export PYTHONPATH=$PYTHONPATH:~/research/pydart2/

. /home/nathan/torch/install/bin/torch-activate

alias caexp='python experiment.py -mtruncated_reverse -domniglot -T200 -R100 -lp 1.0 -ld 1e-5 -ngrad_clipping -r1 -B4'
alias lt='open *.pdf && vim *.tex'
source /opt/ros/melodic/setup.bash
source ~/catkin_ws/devel/setup.sh
source ~/catkin_ws/src/autorally/autorally_util/setupEnvLocal.sh
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:/home/nathan/research/rcta_stuff/rcta/src
#source ~/research/rcta_stuff/warthog_ws/devel/setup.bash

# As recommended by learncpp.com
alias gpp='g++ -pedantic-errors -Wall -Weffc++ -Wextra -Wsign-conversion'

alias ros='source activate autorally' # Python 2 Conda environment

# For running X windows (in particular, Gazebo) from docker containers.
# Got this code from https://github.com/CogRob/omnimapper/tree/master/docker/nvidia
# Requires some prior work on the Docker image (installing some apt-gets and Nvidia driver)
export XSOCK=/tmp/.X11-unix
export XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
alias rcta='docker run --name rctatest --volume=$XSOCK:$XSOCK:rw --volume=$XAUTH:$XAUTH:rw --env="XAUTHORITY=${XAUTH}" --env=DISPLAY --device /dev/nvidia0:/dev/nvidia0 --device /dev/nvidiactl:/dev/nvidiactl -it --mount type=bind,source=/home/nathan/research/rcta_stuff/rcta/src,target=/rcta/src rcta/builtimage:nvidia'
alias rcta1='docker start -i rctatest' # If you already ran `rcta`
alias rcta2='docker exec -it rctatest bash' # If you already ran `rcta1`
