alias l=ls
alias la='ls -lah'
alias ll='ls -lh'

alias ..='perl ~/code/tree.pl ./'

alias explorer=$HOME/src/github/skeletonkey/tools/explorer.pl

alias clear="clear && clear"

alias tmux="tmux -2" # 256 colors

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

# Tell ls to be colourful
export CLICOLOR=1
export LS_OPTIONS='--color=auto'
export LSCOLORS=GxFxCxDxBxegedabagaced

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

# To tmux-cssh into a bunch of our machines do:
#    tcssh app1.shared.dev?.websys.tmcs 1,3-5,7
# requires tmux-cssh to be installed - https://github.com/peikk0/tmux-cssh
tcssh() {
    server=$1;
    nodes=$2
    nodes=$(expand_range $nodes);
    IFS='?' read -a server_parts <<< "$server"
    IFS=',' read -a each_node <<< "$nodes"

    session_name=$((RANDOM))

    cmd="tmux-cssh $session_name"
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

# load specific/special bash profile files if they are present
for f in ~/.bash_profile_*
do
    if [[ $f =~ \.sw.$ ]]
    then
        continue
    else
        source $f
    fi
done
