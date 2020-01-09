# This is a little more than just aliases, but putting it all in .bash_aliases
# means it's automatically included in the default .bashrc with Ubuntu 18.04.

setxkbmap -option caps:swapescape
export EDITOR=vim

shopt -s expand_aliases
# As recommended by learncpp.com
alias gpp='g++ -pedantic-errors -Wall -Weffc++ -Wextra -Wsign-conversion'

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

alias lt='open *.pdf && vim *.tex'

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

# for CUDA
#export PATH=/usr/local/cuda-9.0/bin${PATH:+:${PATH}}
#export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}:/usr/local/lib

#source /opt/ros/melodic/setup.bash
#export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:/home/nathan/research/rcta_stuff/rcta/src
#source ~/research/rcta_stuff/warthog_ws/devel/setup.bash
