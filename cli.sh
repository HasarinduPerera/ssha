#!/bin/bash

# Author: Hasarindu Perera
# Created Date: Mar 16 23
# Last Modified Date: Mar 16 23

# Define file to store aliases
ALIAS_FILE="$HOME/.ssh_aliases"

# Function to load aliases from file
load_aliases() {
    if [ -f "$ALIAS_FILE" ]; then
        mapfile -t aliases < "$ALIAS_FILE"
        # echo "DEBUG: Aliases loaded successfully."
    else
        echo "DEBUG: No alias file found."
    fi
}


# Function to save aliases to file
save_aliases() {
    > "$ALIAS_FILE"  # Clear the file
    for line in "${aliases[@]}"; do
        echo "$line" >> "$ALIAS_FILE"
    done
    # echo "DEBUG: Aliases saved."
}

# Function to establish SSH connection using alias
connect() {
    local alias="$1"
    local target=$(grep -w "^$alias" "$ALIAS_FILE" | cut -d' ' -f2)

    if [ -z "$target" ]; then
        echo "Unknown alias: $alias"
        exit 1
    fi

    echo "Connecting to $alias at $target..."
    ssh "$target"
}

# Function to add or update alias
add_alias() {
    local alias="$1"
    local target="$2"
    local line="$alias $target"
    
    # Load existing aliases
    load_aliases

    # Validate target format (username@ip)
    if ! [[ "$target" =~ ^[a-zA-Z0-9._%+-]+@[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        echo "Error: Invalid target format. Please use username@ip format."
        return 1
    fi

    # Check if alias or target already exists
    for existing_line in "${aliases[@]}"; do
        existing_alias=$(echo "$existing_line" | cut -d ' ' -f1)
        existing_target=$(echo "$existing_line" | cut -d ' ' -f2)
        if [[ "$existing_alias" == "$alias" || "$existing_target" == "$target" ]]; then
            echo "Error: Alias '$alias' with target '$target' already exists."
            return 1
        fi
    done
    
    # Append new alias
    aliases+=("$line")
    save_aliases
    
    echo "Alias '$alias' added for '$target'."
}

# Function to remove alias
remove_alias() {
    local alias="$1"
    sed -i "/^$alias /d" "$ALIAS_FILE"

    # Debug output
    # echo "DEBUG: .ssh_aliases file contents after removal:"
    # cat "$ALIAS_FILE"
    
    echo "Alias '$alias' removed."
}

# Function to show all available aliases
show_aliases() {
    load_aliases
    echo "Available aliases:"
    echo "--------------------------------------"
    printf "%-15s %s\n" "Alias" "Target"
    echo "--------------------------------------"
    for line in "${aliases[@]}"; do
        alias=$(echo "$line" | cut -d ' ' -f1)
        target=$(echo "$line" | cut -d ' ' -f2)
        printf "%-15s %s\n" "$alias" "$target"
    done
    echo "--------------------------------------"
}

# Parse command-line arguments
case "$1" in
    "con")
        connect "$2"
        ;;
    "new")
        if [ -z "$2" ] || [ -z "$3" ]; then
            echo "Usage: $0 new <alias> <target>"
            exit 1
        fi
        add_alias "$2" "$3"
        ;;
    "del")
        if [ -z "$2" ]; then
            echo "Usage: $0 del <alias>"
            exit 1
        fi
        remove_alias "$2"
        ;;
    "show")
        show_aliases
        ;;
    *)
        echo "Usage: $0 <command>"
        echo "Commands:"
        echo "  con <alias>       Connect to SSH server using alias"
        echo "  new <alias> <target>  Add SSH alias"
        echo "  del <alias>       Remove SSH alias"
        echo "  show              Show all available aliases"
        ;;
esac

# Load aliases when script starts
aliases=()
load_aliases
