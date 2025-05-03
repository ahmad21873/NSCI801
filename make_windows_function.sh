#!/bin/bash       
# This script extracts signal intensity from .bedGraph files
# Uses bedTools to create 10kb windows across the reference genome (mm10)
# It then extracts the mean signal intensity from the .bedGraph files for each window
# NAME: Ahmad Chahin
# STUDENT NUMBER: 20111664

# Ensure bedtools is loaded
module load bedtools

bedtools makewindows -g "/global/home/sa105149/Aim2/fasta/mm10_chrom_lengths_chr.txt" -w $WINDOW_SIZE > "$OUTPUT_DIR/genome_windows.bed"


# Define variables
WINDOW_SIZE=10000
GENOME_FILE="genome.fa.fai"
TOP5_FILES=("top5_file1.bw" "top5_file2.bw" ...)  # Add all top 5 files
BOTTOM5_FILES=("bottom5_file1.bw" "bottom5_file2.bw" ...)  # Add all bottom 5 files
OUTPUT_DIR="/global/home/sa105149/Aim2/bigwigFiles"


# Create genome windows
bedtools makewindows -g "/global/home/sa105149/Aim2/fasta/mm10_chrom_lengths_chr.txt" -w $WINDOW_SIZE > "$OUTPUT_DIR/genome_windows.bed"

# Extract signal intensity for top 5 cell types
for file in "${TOP5_FILES[@]}"; do
    base=$(basename "$file" .bw)
    bedtools map -a genome_windows.bed -b "$file" -c 4 -o mean > "${base}_signal.bed"
done

# Extract signal intensity for bottom 5 cell types
for file in "${BOTTOM5_FILES[@]}"; do
    base=$(basename "$file" .bw)
    bedtools map -a genome_windows.bed -b "$file" -c 4 -o mean > "${base}_signal.bed"
done


