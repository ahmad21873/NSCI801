#!/bin/bash       
#Coverts bigwig files to bedgraph files
#Run on cluster containing the data
#NAME: Ahmad Chahin
#STUDENT NUMBER: 20111664

# Load bedtools
module load bedtools

# Convert bigWig files stored in specified directory to bedGraph format for highly marked cell types
cd "$TOP5_DIR" || exit
for file in *.bigWig; do
    base="${file%.bigWig}"
    ./bigWigToBedGraph "$file" "${base}.bedGraph"
done

# Convert bigWig files stored in specified directory to bedGraph format for lowly marked cell types
cd "$BOTTOM5_DIR" || exit
for file in *.bigWig; do
    base="${file%.bigWig}"
    ./bigWigToBedGraph "$file" "${base}.bedGraph"
done

# Extract signal intensity for top 5 cell types
cd "$TOP5_DIR" || exit
for file in *.bedGraph; do
    base=$(basename "$file" .bedGraph)
    bedtools map -a "$OUTPUT_DIR/genome_windows.bed" -b "$file" -c 4 -o mean > "$OUTPUT_DIR/${base}_signal.bed"
done

# Extract signal intensity for bottom 5 cell types
cd "$BOTTOM5_DIR" || exit
for file in *.bedGraph; do
    base=$(basename "$file" .bedGraph)
    bedtools map -a "$OUTPUT_DIR/genome_windows.bed" -b "$file" -c 4 -o mean > "$OUTPUT_DIR/${base}_signal.bed"
done

