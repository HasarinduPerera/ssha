#!/bin/bash

# Function to clear the terminal screen
clear_screen() {
    clear
}

# Function to print a character with a delay
print_character() {
    local char=$1
    echo -n "$char"
    sleep 0.0005
}

# Function to print the ASCII art letter by letter
print_vega_ai() {
    echo ""
    echo ""
    local ascii_art=" ░▒▓███████▓▒░▒▓███████▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░  
░▒▓█▓▒░     ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓█▓▒░     ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ 
 ░▒▓██████▓▒░░▒▓██████▓▒░░▒▓████████▓▒░▒▓████████▓▒░ 
       ░▒▓█▓▒░     ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ 
       ░▒▓█▓▒░     ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓███████▓▒░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░"
    local length=${#ascii_art}

    for (( i=0; i<length; i++ )); do
        print_character "${ascii_art:$i:1}"
    done
    echo ""
    echo ""
    echo ""
}

# Call functions to print the ASCII art
clear_screen
print_vega_ai