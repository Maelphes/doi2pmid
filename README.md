# DOI to PMID lookup

## Short info
In this project a shell script is developed which is able to retrieve PubMed IDs via the Entrez Direct E-Utilities using the DOI. 

## Detailed info
doi2pmid.sh is a shell script which reads Digital Object Identifiers (DOI) from an input file. 

The input file should contain one DOI per line only. For each line of the input file the script sends a request to the NLM Entrez API using the command line utilities *Entrez Direct*. Any PMID that is found will be added to an output file. If the returned result contains more than one PMID or none at all, the DOI will be skipped and a notification will be written into the output file instead of the PMID.

When the lookup is finished the script offers to sort and deduplicate the retrieved data. 

### Note
This script does **not** use the [Any ID converter](https://www.ncbi.nlm.nih.gov/pmc/utils/idconv/v1.0/) from PMC, which will only find PMIDs of references which are also in PubMed Central. It uses the [Entrez system](https://www.ncbi.nlm.nih.gov/books/NBK3837/) instead.

## Dependencies
The package `ncbi-entrez-direct` needs to be installed.
For further reference about the E-utilities visit [Entrez Programming Utilities Help](https://www.ncbi.nlm.nih.gov/books/NBK179288/).

## Usage: 
`./doi2pmid.sh <input>`

## Example:
`./doi2pmid.sh example_input.txt` 
