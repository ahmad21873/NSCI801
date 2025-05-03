#!/bin/bash       
# This script compiles summarized signal intensity data into a count matrix
# NAME: Ahmad Chahin
# STUDENT NUMBER: 20111664

# Ensure R is loaded into the cluster

# Set the working directory to where your summarized bed files are
setwd("/global/home/sa105149/Aim2/summarized_bed_files")

# List all the summarized files
files <- list.files(pattern = "_summed.bed$")

# Read in all the files and merge them into a single data frame
library(dplyr)

# Initialize an empty list to store the data from each file
data_list <- list()

for (file in files) {
  # Read the summarized file
  dat <- read.table(file, header = FALSE)
  # Extract sample name from the file name, assuming it ends with "_summed.bed"
  sample_name <- gsub("_summed.bed", "", file)
  # Add the sample name as a column in the dataframe
  dat$sample <- sample_name
  # Rename the columns
  names(dat) <- c("chr", "start", "end", "signal_intensity", "sample")
  # Add the dataframe to the list
  data_list[[sample_name]] <- dat
}

# Merge all data frames by genomic coordinates
count_matrix <- Reduce(function(...) full_join(..., by = c("chr", "start", "end")), data_list)

# Pivot the data so that each sample is a column
count_matrix_long <- count_matrix %>%
  gather(key = "sample", value = "signal_intensity", -chr, -start, -end) %>%
  spread(key = sample, value = signal_intensity)

# Replace NA with zeros
count_matrix_long[is.na(count_matrix_long)] <- 0

# Write out the count matrix to a CSV file
write.csv(count_matrix_long, "/global/home/sa105149/Aim2/output/count_matrix.csv", row.names = FALSE)

# count_matrix can now be analyzed further on local machine