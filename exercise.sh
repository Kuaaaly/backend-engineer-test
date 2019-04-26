#!/bin/bash
# Description
# Usage : ./exercise.sh
# Création : Quentin Le Graverend - 26/04/2019
# Modification : Quentin Le Graverend - 26/04/2019
# version 0.1

# ERROR CONTROL
set -eu

# VARIABLES

# FUNCTIONS
hello_world () {
    echo "Hello World!"
}

read_freelancer_data() {
    i=0
    while [[ $i -lt 5 ]]
    do
	if [[ is_there_another_exp ]]
	then
	    echo "C'est fini !"
	else
            jq ".freelance.professionalExperiences[$i]" examples/freelancer.json
	fi
	i=$i+1
    done	
}

is_there_another_exp() {
    nl='
    '
    if [[ $(jq ".freelance.professionalExperiences[$1]" examples/freelancer.json) != *$nl*  ]]
    then
	return 0
    else
	return 1
    fi
}

# MAIN
hello_world
read_freelancer_data


