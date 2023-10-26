#!/bin/bash

# Check if the correct number of arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <writefile> <writestr>"
    exit 1
fi

writefile="$1"
writestr="$2"

# Check if writefile is specified
if [ -z "$writefile" ]; then
    echo "Error: You must specify a valid file path."
    exit 1
fi

# Check if writestr is specified
if [ -z "$writestr" ]; then
    echo "Error: You must specify a non-empty string to write."
    exit 1
fi

# Create the directory if it doesn't exist
mkdir -p "$(dirname "$writefile")"

# Write the content to the file, overwriting any existing content
echo -n "$writestr" > "$writefile"

# Check if the write operation was successful
if [ $? -ne 0 ]; then
    echo "Error: Could not write to $writefile."
    exit 1
fi

echo "File created: $writefile"

