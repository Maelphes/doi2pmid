# DOI to PMID lookup

## Short info
This is an attempt to retrieve PubMed IDs via the Entrez Direct E-.Utilities using the DOI. 

## Detailed info
doi2pmid.sh is a shell script which reads DOIs from an input file and requests each line of the input file using the NLM Entrez API's command line utilities. Any PMID that is found will be added to an output file.
When the lookup is finished, the script offers to sort and deduplicate the retrieved data. 

## Dependencies
The package `ncbi-entrez-direct` needs to be installed.
For further reference, go to [Entrez Programming Utilities Help](https://www.ncbi.nlm.nih.gov/books/NBK179288/).

## Usage: 
`./doi2pmid.sh <input>`
 
