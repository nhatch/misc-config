#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

BOLD=$(tput bold)
RESET=$(tput sgr0)
#PS1='\[$BOLD\][\! \u@\h \W]\$\[$RESET\] '
PS1='[\! \u@\h \W]\$ '

export REPO=https://phoenixforge.cs.uchicago.edu/svn/boli-hatc
#TODO: fix PATH and ANDROID_SWT so they aren't set improperly in the first place (note: PATH also includes /opt/android-sdk/tools which no longer exists)
export PATH=$PATH:/home/nathan/uchicago/mobile/adt-bundle-linux-x86_64-20131030/sdk/tools:/home/nathan/uchicago/mobile/adt-bundle-linux-x86_64-20131030/sdk/platform-tools:/home/nathan/uchicago/mobile/adt-bundle-linux-x86_64-20131030/eclipse:/home/nathan/uchicago/mobile/adt-bundle-linux-x86_64-20131030/android-ndk-r9c/
export ANDROID_SWT=

# the following because dvorak
alias li='ls --color=auto'
alias lim='ls -l'
alias ls='ls --color=auto'

set -o vi

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
