#!/bin/bash

# Check if the correct number of arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <filesdir> <searchstr>"
    exit 1
fi

filesdir="$1"
searchstr="$2"

# Check if filesdir exists and is a directory
if [ ! -d "$filesdir" ]; then
    echo "Error: $filesdir is not a valid directory."
    exit 1
fi

# Function to find matching lines in files and subdirectories
search_files() {
    local dir="$1"
    local str="$2"

    # Recursively search for files and count the matches
    local file_count=0
    local match_count=0

    for file in "$dir"/*; do
        if [ -f "$file" ]; then
            file_count=$((file_count + 1))
            matches=$(grep -c "$str" "$file")
            match_count=$((match_count + matches))
        elif [ -d "$file" ]; then
            # If it's a directory, recursively search it
            sub_counts=$(search_files "$file" "$str")
            file_count=$((file_count + sub_counts[0]))
            match_count=$((match_count + sub_counts[1]))
        fi
    done

    echo "$file_count $match_count"
}

# Call the search_files function and capture the result
result=($(search_files "$filesdir" "$searchstr"))

# Extract the values from the result array
file_count="${result[0]}"
match_count="${result[1]}"

# Print the results
echo "The number of files are $file_count and the number of matching lines are $match_count"

