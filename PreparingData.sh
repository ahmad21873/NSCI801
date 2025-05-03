#!/bin/bash       
#Generates signal intensity of H3K27me3 over a certain gene location 
#Run on local machine containing the data
#NAME: Ahmad Chahin
#STUDENT NUMBER: 20111664

# Ensure deepTools is installed
pip install deeptools

# Ensure BED file of gene location from ENCODE is obtained (stored in 'BED-file')
# Ensure bigWig file of H3K27me3 signal intensity from ENCODE is obtained (stored in 'bigwigdata')
# Run 'multiBigwigSummary' to generate signal intensity of H3K27me3 over gene location
multiBigwigSummary BED-file \
    --bedFile CyclinD1.bed \
    --bwfiles $(ls bigwigdata/*.bigwig) \
    --outFileName multiBigwigSummary_output.npz \
    --outRawCounts csvchr7.csv \
    --binSize 10


# Output of signal intensities over CyclinD1 gene location is stored in 'csvchr7.csv' and can be further analyzed




