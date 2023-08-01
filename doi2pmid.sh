#!/bin/bash

# Check if the script is provided with an input file and output file argument
if [ $# -lt 1 ]; then
  echo "Usage: $0 <input>"
  exit 1
fi

input="$1"

# Check if the file exists and is readable
if [ ! -r "$input" ]; then
  echo "Error: File '$input' does not exist or is not readable."
  exit 1
fi

# Get the total number of lines in the input file
total_lines=$(wc -l < "$input")

# Function to display the progress bar
progress_bar() {
  local progress=$(( $1 * 100 / $2 ))
  local length=$(( $progress / 2 ))
  local bar=$(printf "%0.s=" $(seq 1 $length))
  printf "\r[%-50s] %d%%" "$bar" "$progress"
}

# Fancy spinning animation for a satisfying waiting experience
spinner() {
    local i sp n
    sp='/-\|'
    n=${#sp}
    printf ' '
    while sleep 0.1; do
        printf "%s\b" "${sp:i++%n:1}"
    done
}

# Function to sort and deduplicate the output file
sort_and_deduplicate() {
  sort -u output.txt -o output_sorted.txt
}

# Function to clear the current line
clear_line() {
  printf "\033[2K"
}

# Main program
echo "*******************************"
echo "* Lookup tool: DOI to PMID    *"
echo "*******************************"
echo " " 
echo "WARNING: Previous output files will be overwritten."
read -p "Do you want to proceed? [Y/n]: " response1
echo ""
if [ "$response1" = "y" ] || [ "$response1" = "Y" ] || [ "$response1" = "" ]; then
  
# Loop to lookup DOIs using ncbi-entrez-utilities
output=output.txt
counter=0
notfound=0
truncate -s 0 $output
while IFS= read -r line; do
  # Ignore empty lines
  if [ -n "$line" ]; then
    # Replace any leading/trailing whitespace in the line
    arg=$(echo "$line" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    
    # Execute the shell command with the argument from the file
    echo "Processing: '$arg'"
    spinner &
    spinner_pid="$!"
    clear_line
    progress_bar "$counter" "$total_lines" 
    esearch_output=$(echo ""| esearch -db pubmed -query "doi: $arg" | efetch -format docsum | xtract -pattern DocumentSummary -element Id)
    # Check if the query resulted in non-empty output
    if [ -n "$esearch_output" ]; then
      # Append the output to the output file $output
      echo "$esearch_output" >> $output
      echo " "
      echo "PMID $esearch_output found."
    else
      echo " "
      echo "No output for the given query."
      echo "No PMID for $arg found." >> $output
      let notfound=notfound+1
    fi
    
    # count the iterations in order to report how many queries were processed
    let counter=counter+1
    # Stop the spinning animation for this iteration
    kill "$spinner_pid"
  fi
done < "$input"

successful=$(($counter - $notfound))
echo ""
echo "======================="
echo " PMIDs retrieved: $successful" 
echo " --------------------- "
echo " PMID not found: $notfound"
echo "======================="
echo ""


# Ask the user if they want to sort and deduplicate the output
read -p "Do you want the results to be sorted and deduplicated? [Y/n]: " response2
echo ""
if [ "$response2" = "y" ] || [ "$response2" = "Y" ] || [ "$response2" = "" ]; then
  sort_and_deduplicate
  # Print the number of entries in output_sorted.txt
  num_entries=$(wc -l < output.txt)
  num_entries_sort=$(wc -l < output_sorted.txt)
  echo "Untouched results in output.txt: $num_entries."
  echo "Unique entries in output_sorted.txt: $num_entries_sort"
else
  echo "Data not sorted and deduplicated. Check '$output'."
fi

  else
	echo "Aborted."
	exit 1
fi

# End of file
