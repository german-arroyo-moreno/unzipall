#!/bin/bash

# -----------------------------------------------------------------------------

# UnzipAll - A simple script to extract multiple ZIP files in a directory
# and organize them in a structured manner.

# Author: Germán Arroyo <arroyo@ugr.es>
# License: MIT License
# Copyright (c) 2024 Germán Arroyo

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom
# the Software is furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Usage:./unzipall [path]

# Extracts all ZIP files in the specified directory (or current directory if
#  none is provided)
# and organizes them in a structured manner.

# -----------------------------------------------------------------------------

# Function to find all zip files in a directory
find_zip_files() {
    local path="$1"

    # Check if the provided path is a directory
    if [[ ! -d "$path" ]]; then
        echo "Error: '$path' is not a directory." >&2
        return 1
    fi

    # Use find to recursively search for.zip files, excluding the "unzipped" directory
    find "$path" -type f -name "*.zip" -not -path "*/__unzipped/*" -print0
}

# Function to unzip a file in a directory
unzip_file() {
    local dir="$1"
    local file="$2"

    # Check if the provided directory is a directory
    if [[ ! -d "$dir" ]]; then
        echo "Error: '$dir' is not a directory." >&2
        return 1
    fi

    # Check if the provided file exists in the directory
    if [[ ! -f "$dir/$file" ]]; then
        echo "Error: '$file' does not exist in '$dir'." >&2
        return 1
    fi

    # Unzip the file in the directory
    (cd "$dir" && unzip -q "$file")
}

# Function to move a file to the "__unzipped" directory
move_to_unzipped() {
    local dir="$1"
    local file="$2"

    # Create the "unzipped" directory if it doesn't exist
    local unzipped_dir="./__unzipped"

    # Get the relative path of the directory within the current directory
    local rel_dir="${dir#./}"
    rel_dir="${rel_dir#/}"

    # Create the relative directory structure in the "unzipped" directory
    local target_dir="$unzipped_dir/$rel_dir"
    mkdir -p "$target_dir"
    # Move the file to the "unzipped" directory, maintaining the relative path
    mv "$dir/$file" "$target_dir/"
    echo "Moved \"$file\" into \"$target_dir\"."
}

# Function to process zip files
process_zip_files() {
    local path="$1"

    # Process zip files function
    while IFS= read -r -d '' file; do
        echo ""
        dir=$(dirname "$file")
        file_name=$(basename "$file")
        echo "Unzipping \"$file\" in \"$dir\"..."
        unzip_file "$dir" "$file_name"
        echo "Moving \"$file\" into \"__unzipped\"..."
        move_to_unzipped "$dir" "$file_name"
        echo ""
    done < <(find_zip_files "$path")
}

# Function to display help message
help() {
    echo "Usage: $(basename "$0") [path]"
    echo ""
    echo "Options:"
    echo "  $(basename "$0") --help or $(basename "$0") -h  Show this help message."
    echo ""
    echo "Path Argument:"
    echo "  If not provided, the current directory '.' is used by default."
    echo ""
    echo "Description:"
    echo "  This program unextracts multiple ZIP files and organizes them in a structured manner."
    echo ""
    echo "How it Works:"
    echo "  Unzips all ZIP files found in the specified directory (or the current directory if none is provided)."
    echo "  Moves original ZIP files to an '__unzipped' directory to keep them separate from extracted files."
    echo ""
    echo "Safety and Reusability:"
    echo "  Safe to run multiple times without overwriting or mixing up existing extracted files."
    echo "  Preserves the original directory structure for easy access to extracted files."
    echo ""
    echo "Result:"
    echo "  After processing, all ZIP files are extracted and organized in their original structure, with ZIP files moved to '__unzipped'."
}

# -----------------------------------------
#          Main program
# -----------------------------------------

# Check for help option
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    help
    exit 0
fi

if [ "$#" -gt 1 ]; then
    # More than one argument, show error message
    echo "Error: Too many arguments. Please provide only one directory." >&2
    exit 1
fi

# Set default path to current directory if no argument is provided
path="${1:-.}"

# Call the process_zip_files function
process_zip_files "$path"

exit 0
