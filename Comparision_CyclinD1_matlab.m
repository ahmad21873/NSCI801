%% Script for plotting boxplots of histone intensity
% Author: Ahmad Chahin
% Student number: 20111664

% Read the file
dat = readtable('~P2_RMD_Files/csvchr7.csv');
vals = dat.value; 
cell_type = categorical(dat.Biosample_term_name); 

% Plot the boxplot
figure, hold on;
boxplot(vals,cell_type)
[x,G] = findgroups(cell_type);
gscatter(x,vals,cell_type)
xlabel('')
ylabel('Intensity')