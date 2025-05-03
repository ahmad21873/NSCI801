#!/bin/bash       
#Maps the mm10 genome to appropriate gene locations
#Run on cluster containing the data
#NAME: Ahmad Chahin
#STUDENT NUMBER: 20111664

# Ensure genome is uploaded to cluster

# First, extract chromosome length
grep "^>" Mus_musculus.GRCm38.dna.primary_assembly.fa | awk -F ">" '{print $2}' > chromosome_names.txt

cat <<EOF > calculate_chromosome_lengths.awk
BEGIN {RS=">"}
NR>1 {
    split(\$0, lines, "\n")
    chrom_name = lines[1]
    chrom_seq = ""
    for (i=2; i<=length(lines); i++) {
        chrom_seq = chrom_seq lines[i]
    }
    print chrom_name "\t" length(chrom_seq)
}
EOF

awk -f calculate_chromosome_lengths.awk Mus_musculus.GRCm38.dna.primary_assembly.fa > mm10_chrom_lengths.txt

rm chromosome_names.txt calculate_chromosome_lengths.awk

# Second, run 'make_windows_function.sh' to create windows of specified sizes along the chromosomes of the mm10 genome
./make_windows_function.sh

