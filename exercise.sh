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
declare -A SKILL_LIST
declare -A SKILL_DURATION_LIST

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

element_in_array() {
    # Source: https://stackoverflow.com/questions/3685970/check-if-a-bash-array-contains-a-value
    local e match="$1"
    shift
    for e; do [[ "$e" == "$match" ]] && return 0; done
    return 1
}

get_skill_list() {
    i=0
    while another_element .freelance.professionalExperiences[$i]
    do
	j=0
	while another_element .freelance.professionalExperiences[$i].skills[$j]
	do
	    SKILL_NAME=$(jq -r ".freelance.professionalExperiences[$i].skills[$j].name" $INPUT_FILE)
	    SKILL_ID=$(jq -r ".freelance.professionalExperiences[$i].skills[$j].id" $INPUT_FILE)
            SKILL_LIST[$SKILL_NAME]=$SKILL_ID
	    SKILL_DURATION_LIST[$SKILL_NAME]=0
	    j=$j+1
	done
        i=$i+1
    done
}

get_skill_duration() {
    i=0
    while another_element .freelance.professionalExperiences[$i]
    do
        j=0
        while another_element .freelance.professionalExperiences[$i].skills[$j]
        do
            SKILL_NAME=$(jq -r ".freelance.professionalExperiences[$i].skills[$j].name" $INPUT_FILE)
	    SKILL_DURATION_LIST[$SKILL_NAME]=$(( ${SKILL_DURATION_LIST[$SKILL_NAME]} + $(compute_duration ".freelance.professionalExperiences[$i]") )) 
            j=$j+1
        done
        i=$i+1
    done
}

print_duration_list_array() {
    for KEY in "${!SKILL_DURATION_LIST[@]}"
    do
        # Print the KEY value
        echo "$KEY : ${SKILL_DURATION_LIST[$KEY]}"
    done
}

compute_duration() {
    START_DATE=$(jq -r "$1.startDate" $INPUT_FILE)
    END_DATE=$(jq -r "$1.endDate" $INPUT_FILE)
    # Duration computation in months
    echo $(( ($(date --date=$END_DATE +%s) - $(date --date=$START_DATE +%s) )/(60*60*24*30) ))
}

# MAIN
get_skill_list
get_skill_duration
print_duration_list_array
