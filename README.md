# fMRI Multivariate Analysis

## Overview
This project analyzes fMRI data from 90 subjects using multivariate statistical methods to extract meaningful brain activity patterns.

## Data
The dataset comes from the Human Connectome Project and contains:
- 100 brain regions (ROIs)
- ~1150 time points per subject
- BOLD signals as proxy for neural activity

## Methods
- Exploratory Data Analysis (EDA)
- Principal Component Analysis (PCA)
- Dimensionality reduction
- Reconstruction of brain signals
- Visualization of brain activation patterns

## Key Results
- First 5 principal components explain ~80% of variance
- 13 components capture ~90% of total variance :contentReference[oaicite:2]{index=2}  
- PCA reconstruction preserves major activation patterns
- Identification of peak brain activity time points

## Visualization
Brain activation maps and PCA loadings were visualized using custom plotting functions.

## Reproducibility
Due to data access restrictions, the dataset is not included. Code structure and methodology are fully documented.

## Files
- `report/` and `code/` : full report (HTML)
