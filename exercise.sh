#!/bin/bash
# Description
# Usage : ./exercise.sh
# Création : Quentin Le Graverend - 26/04/2019
# Modification : Quentin Le Graverend - 26/04/2019
# version 0.1

# ERROR CONTROL
set -eu

# VARIABLES
INPUT_FILE=examples/freelancer.json

# FUNCTIONS
another_element() {
    nl='
    '
    element=$(jq "$1" examples/freelancer.json)
    if [[ $element != "null" ]]
    then
	return 0
    else
	return 1
    fi
}

contain_element() {
    # Source: https://stackoverflow.com/questions/3685970/check-if-a-bash-array-contains-a-value
    local e match="$1"
    shift
    for e; do [[ "$e" == "$match" ]] && return 0; done
    return 1
}

get_skill_list() {
    i=0
    declare -a SKILL_LIST
    while another_element .freelance.professionalExperiences[$i]
    do
	j=0
	while another_element .freelance.professionalExperiences[$i].skills[$j]
	do
	    SKILL=$(jq ".freelance.professionalExperiences[$i].skills[$j].name" $INPUT_FILE)
	    if ! contain_element $SKILL "${SKILL_LIST[@]}"
            then
		SKILL_LIST+=($SKILL)
            fi
	    j=$j+1
	done
        i=$i+1
    done
    echo ${SKILL_LIST[@]}
}

# MAIN
get_skill_list

