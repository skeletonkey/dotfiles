alias l=ls
alias la='ls -lah'
alias ll='ls -lh'
alias ..='perl ~/bin/tree.pl ./'

alias clear="printf '\n%.0s' {1..40}; echo .; clear" #clear && clear'
alias node='clear && node'
alias vi=mvim

alias gs='git status -sv'
alias gm='git mergetool -t vimdiff'

alias tmux="tmux -2" # 256 colors

alias vssh='ssh -p 2222 -Y vagrant@localhost'
alias tssh='ssh -p 2222 -Y tmweb@localhost'
alias start_vagrant='cd ~/sandbox/Software-1.0.1/ && vagrant up && cd ~/sandbox/AppDev-1.1.11/ && vagrant up && tssh'
alias stop_vagrant='cd ~/sandbox/AppDev-1.1.11/ && vagrant halt && cd ~/sandbox/Software-1.0.1/ && vagrant halt && exit'

alias cdss='cd ~/src/tm/ss/shared-services'
alias cdfunc='cd ~/src/tm/ss/shared-services-functional-tests'
alias cdinv='cd ~/src/tm/devgru/unified-inventory-parkwhiz-service'
alias cdres='cd ~/src/tm/devgru/reservation-criteria'

if [[ ${EUID} == 0 ]] ; then
    # root prompt
    export PS1='\[\033[01;31m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
else
    # user prompt
    # 34m: blue
    # 32m: yellow
    # 00m: white
    # 31m: red
    export PS1="\[\033[01;00m\]\$(date +%Y-%m-%d) \t \[\033[01;00m\][ \$(pwd) ]\n\[\033[01;32m\]\u \[\033[01;31m\]\$(__git_ps1)\[\033[32m\]\$ \[\033[00m\]"
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

source ~/code/.git-prompt.sh # git shell integration
source ~/code/git-completion.bash # tab complete for git commands/repos
source $HOME/perl5/perlbrew/etc/bashrc


#CTAGS_HOME=/Library/Developer/CommandLineTools/usr/bin/ctags
#PATH=“$CTAGS_HOME:$PATH”
#export PATH
export PATH=/usr/local/bin:${PATH}:${HOME}/bin:.
export PATH=$PATH:/Users/erik.tank/Applications/apache-maven-3.1.1/bin
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_45.jdk/Contents/Home
#export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_45.jdk/Contents/Home/jre:/Library/Java/JavaVirtualMachines/jdk1.8.0_45.jdk/Contents/Home/bin

# Tell ls to be colourful
export CLICOLOR=1
export LS_OPTIONS='--color=auto'
export LSCOLORS=GxFxCxDxBxegedabagaced

export GREP_OPTIONS='--color=auto' # Tell grep to highlight matches

######## BINDINGS ########

# search bash history with up and down arrows
#bind '"\e[A"':history-search-backward
#bind '"\e[B"':history-search-forward

######## SSH AUTO-COMPLETION ########

# Add bash completion for ssh: it tries to complete the host to which you
# want to connect from the list of the ones contained in ~/.ssh/known_hosts
__ssh_known_hosts() {
    if [[ -f ~/.ssh/known_hosts ]]; then
        cut -d " " -f1 ~/.ssh/known_hosts | cut -d "," -f1
    fi
}
_ssh() {
    local cur known_hosts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    known_hosts="$(__ssh_known_hosts)"
    if [[ ! ${cur} == -* ]] ; then
        if [[ ${cur} == *@* ]] ; then
            COMPREPLY=( $(compgen -W "${known_hosts}" -P ${cur/@*/}@ -- ${cur/*@/}) )
        else
            COMPREPLY=( $(compgen -W "${known_hosts}" -- ${cur}) )
        fi
    fi
    return 0
}
complete -o bashdefault -o default -o nospace -F _ssh ssh 2>/dev/null \
    || complete -o default -o nospace -F _ssh ssh

# short cuts: ssh app1.shared.dev3.websys.tmcs --> pssh app1 dev3
# assumes that you have ~/.ssh/config set up to provide the correct user
# Example: 
#    Host *.websys.tmcs
#      IdentityFile ~/.ssh/id_rsa.pub
#      StrictHostKeyChecking no
#      User tmweb
pssh() {
    eval "ssh ${1}.shared.${2}.websys.tmcs"
}
# assumes app1
apssh() {
    eval "ssh app1.shared.${1}.websys.tmcs"
}


# To tmux-cssh into a bunch of our machines do:
#  tcssh app1.shared.dev?.websys.tmcs 1,3-5,7
tcssh() {
    server=$1;
    nodes=$2
    nodes=$(expand_range $nodes);
    IFS='?' read -a server_parts <<< "$server"
    IFS=',' read -a each_node <<< "$nodes"

    cmd='tmux-cssh '
    for ((i=0; i < ${#each_node[@]}; i++)); do
        node=${each_node[i]}
        cmd="$cmd ${server_parts[0]}$node${server_parts[1]}";
    done
    eval $cmd
}

# takes: 1,2-4,7 
# returns: 1,2,3,4,7
expand_range() {
    range=$1
    new_range=''
    IFS=',' read -a nodes <<< "$range"
    for ((i=0; i < ${#nodes[@]}; i++)); do
        if [[ ${nodes[i]} =~ ^(.*)-(.*)$ ]]; then
            min=${BASH_REMATCH[1]}
            max=${BASH_REMATCH[2]}
            for ((y=$min; y <= $max; y++)); do
                new_range="$new_range$y,"
            done
        else
            new_range="$new_range${nodes[i]},"
        fi
    done

    echo ${new_range%?}
}

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
    echo -n "^C"
}


##
# Your previous /Users/erik.tank/.bash_profile file was backed up as /Users/erik.tank/.bash_profile.macports-saved_2015-06-10_at_12:05:05
##

# MacPorts Installer addition on 2015-06-10_at_12:05:05: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

