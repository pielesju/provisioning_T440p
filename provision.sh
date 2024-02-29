#!/bin/bash
###########

printf "STARTING PROVISIONING\n"

function task {
    NAME=$1
    CMD=$2
    
    printf "%s\n" $NAME
    eval "$CMD" &> /dev/null
    if [[ $? != 0 ]]; then
        printf "%s FAILED\n" $NAME
        exit 1
    fi
}

################################################################################

task "UPDATE SYSTEM" "sudo pacman -Syu"

task "INSTALL PYTHON" "sudo pacman -S python"

task "INSTALL ANSIBLE" "sudo pacman -S ansible &> /dev/null"

printf "PULL AND EXECUTE PLAYBOOK"
sudo ansible-pull -U https://github.com/pielesju/provisioning_T440p.git t440p.yml

exit 0