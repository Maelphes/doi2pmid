# DOI to PMID lookup

## Short info
In this project a shell script is developed which is able to retrieve PubMed IDs via the Entrez Direct E-Utilities using the DOI. 

## Detailed info
doi2pmid.sh is a shell script which reads DOIs from an input file and requests each line of the input file using the NLM Entrez API's command line utilities *Entrez Direct*. Any PMID that is found will be added to an output file. If the returned result contains more than one PMID or none at all, the DOI will be skipped and a notification will be written into the output file instead of the PMID.
When the lookup is finished, the script offers to sort and deduplicate the retrieved data. 

## Dependencies
The package `ncbi-entrez-direct` needs to be installed.
For further reference about the E-utilities visit [Entrez Programming Utilities Help](https://www.ncbi.nlm.nih.gov/books/NBK179288/).

## Usage: 
`./doi2pmid.sh <input>`

## Example:
`./doi2pmid.sh example_input.txt` 
