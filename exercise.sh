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
    local nl='
    '
    element=$(jq "$1" examples/freelancer.json)
    if [[ $element != "null" ]]
    then
        return 0
    else
        return 1
    fi
}

compute_duration() {
    var=$(declare -p "$1")
    eval "declare -A _arr="${var#*=}
    local i=0
    local DURATION=0
    KEYS=(${!_arr[@]})
    while [[ i -lt ${#_arr[@]} ]]
    do
        DURATION=$(( $DURATION + (($(date --date=${_arr[${KEYS[$i]}]} +%s) - $(date --date=${KEYS[$i]} +%s) )/(60*60*24*30)) ))
        i=$i+1
    done
    echo $DURATION
}

compute_overlap() {
    var=$(declare -p "$1")
    eval "declare -A _arr="${var#*=}
    local i=1
    local OVERLAP_DURATION=0
    KEYS=(${!_arr[@]})
    while [[ i -lt ${#_arr[@]} ]]
    do
        OVERLAP=$(( ($(date --date=${KEYS[${i}]} +%s) - $(date --date=${_arr[${KEYS[$((i-1))]}]} +%s) )/(60*60*24*30) ))
        if [[ $OVERLAP -lt 0 ]]
        then
            OVERLAP_DURATION=$((OVERLAP_DURATION + OVERLAP))
        fi
        i=$i+1
    done
    echo $OVERLAP_DURATION
}

display_result() {
    KEYS=(${!SKILL_LIST[@]})
    echo '{"freelance": {"id": 42,"computedSkills":['
    for k in "${!SKILL_LIST[@]}"
    do
        if [[ $k = ${KEYS[$((${#SKILL_LIST[@]}-1))]} ]]
        then
            echo "{\"id\": ${SKILL_LIST[$k]},\"name\": \"$k\",\"durationInMonths\": ${SKILL_DURATION_LIST[$k]}}"
        else
            echo "{\"id\": ${SKILL_LIST[$k]},\"name\": \"$k\",\"durationInMonths\": ${SKILL_DURATION_LIST[$k]}},"
        fi
    done
    echo ']}}'
}

get_all_skills_duration() {
    var=$(declare -p "$1")
    eval "declare -A _arr="${var#*=}
    for k in "${!_arr[@]}"
    do
        get_skill_duration $k
    done
}

get_skill_duration() {
    local i=0
    local SKILL_NAME=$1
    declare -A EXP_DURATION_LIST
    while another_element .freelance.professionalExperiences[$i]
    do
        local j=0
        while another_element .freelance.professionalExperiences[$i].skills[$j]
    do
        if [[ $(jq -r ".freelance.professionalExperiences[$i].skills[$j].name" $INPUT_FILE) = $SKILL_NAME ]]
        then
            START_DATE=$(jq -r ".freelance.professionalExperiences[$i].startDate" $INPUT_FILE)
            END_DATE=$(jq -r ".freelance.professionalExperiences[$i].endDate" $INPUT_FILE)
            EXP_DURATION_LIST[$START_DATE]=$END_DATE
        fi
        j=$j+1
        done
    i=$i+1
    done
    SKILL_DURATION_LIST[$SKILL_NAME]=$((\
        ${SKILL_DURATION_LIST[$SKILL_NAME]}\
        + $(compute_duration "EXP_DURATION_LIST")\
        + $(compute_overlap "EXP_DURATION_LIST")\
        ))
}

get_skill_list() {
    local i=0
    while another_element .freelance.professionalExperiences[$i]
    do
    local j=0
    while another_element .freelance.professionalExperiences[$i].skills[$j]
    do
        local SKILL_NAME=$(jq -r ".freelance.professionalExperiences[$i].skills[$j].name" $INPUT_FILE)
        local SKILL_ID=$(jq -r ".freelance.professionalExperiences[$i].skills[$j].id" $INPUT_FILE)
        SKILL_LIST[$SKILL_NAME]=$SKILL_ID
        SKILL_DURATION_LIST[$SKILL_NAME]=0
        j=$j+1
    done
    i=$i+1
    done
}

print_associative_array() {
    # this function is for debug purpose
    # source : https://stackoverflow.com/questions/4069188/how-to-pass-an-associative-array-as-argument-to-a-function-in-bash
    var=$(declare -p "$1")
    eval "declare -A _arr="${var#*=}
    for k in "${!_arr[@]}"; do
        echo "$k: ${_arr[$k]}"
    done
}

# MAIN
get_skill_list
get_all_skills_duration "SKILL_LIST"
display_result | jq .
