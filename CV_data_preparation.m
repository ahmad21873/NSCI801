%% Title: Cross Validation Preprocessing
% Author: Ahmad Chahin
% Student number: 20111664

%% Data preprocessing

% Load the data 
newcount = readtable('/Desktop/new_count.csv');
samplenames = readtable('/Desktop/sample_names.csv');

% Extract numeric data from newcount, skipping the first column which contains non-numeric data
data = table2array(newcount(:, 2:end));

% Extract group labels from samplenames
labels = samplenames.group;

% Create a logical target vector for classification (1 for 'TOP5', 0 for 'BOTTOM5')
isTop5 = strcmp(labels, 'TOP5');

% Transpose the data so that rows correspond to samples and columns to features
dataTransposed = data';

% Normalize the transposed data to ensure mean is zero and standard deviation is one
normalizedData = zscore(dataTransposed);

%% Implementing Gaussian Random Projection 

% Define Parameters
numComponents = 500; 
[numSamples, numFeatures] = size(normalizedData);

% Replace NaNs in normalized data with 0 or another appropriate value
normalizedData(isnan(normalizedData)) = 0;

% Perform random projection
reducedData = normalizedData * projectionMatrix;

% Create a Gaussian random projection matrix
projectionMatrix = randn(numFeatures, numComponents) / sqrt(numComponents);

% Apply the random projection
reducedData = normalizedData * projectionMatrix;

% Prepare the input table for the Classification Learner
inputTable = array2table(reducedData);
inputTable.Group = isTop5; 

% Load 'inputTable' into the Classification Learner app






