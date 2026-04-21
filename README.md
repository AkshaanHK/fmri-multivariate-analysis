# fMRI Multivariate Analysis

## Overview
This project analyzes high-dimensional fMRI data using multivariate statistical methods to extract meaningful patterns of brain activity.

The objective is to reduce dimensionality, understand functional connectivity, and identify dynamic brain states from complex time-series data.

---

## Dataset
The dataset comes from the Human Connectome Project (HCP) and contains:

- 90 subjects
- 100 brain regions (ROIs)
- ~1150 time points per subject
- BOLD signals representing neural activity

Each subject is represented by a matrix of size:
- 100 (ROIs) × ~1150 (time points)

Due to access restrictions, the dataset is not included in this repository.

---

## Methods

### 1. Exploratory Data Analysis (EDA)
- Analysis of time series variability across subjects
- Visualization of brain signals
- Study of ROI structure and functional networks

---

### 2. PCA (Single Subject Analysis)
- Applied PCA to reduce dimensionality of one subject’s data
- Key results:
  - First 5 principal components explain ~80% of variance
  - 13 components explain ~90% of total variance

- Interpretation:
  - PC1 captures global brain activation
  - PC2 reflects opposing activation patterns across regions
  - PCA reconstruction preserves major activation patterns

---

### 3. PCA Across Subjects
Challenges:
- Different number of time points per subject
- No temporal alignment
- High dimensionality (N ≫ number of subjects)

Solution:
- Transform each subject into a ROI–ROI correlation matrix (100 × 100)
- Vectorize into a 10,000-dimensional vector
- Build a dataset of size 90 × 10,000

Then:
- Apply PCA for cross-subject comparison

Results:
- First 40 components explain ~90% of variance
- Effective dimensionality reduction of inter-subject variability

---

### 4. Co-Activation Pattern (CAP) Analysis
Goal:
Capture dynamic brain states instead of static connectivity

Steps:
- Select top 30% most active time points
- Apply k-means clustering (k = 3)
- Analyze resulting clusters

Results:
- Identification of distinct brain states:
  - Task-engaged states
  - Internally oriented states
  - Global co-activation patterns

---

## Key Results

- PCA effectively reduces dimensionality while preserving structure
- Reconstruction closely matches original signals
- Correlation-based PCA allows robust cross-subject comparison
- CAP analysis reveals dynamic patterns of brain activity
- Strong within-network correlations confirm functional coherence

---

## Visualizations

The project includes:

- PCA variance explained plots
- Brain activation maps
- PCA loadings visualization
- Correlation matrices
- CAP heatmaps (brain states)

These visualizations illustrate both static and dynamic brain connectivity patterns.

---

## Code

The core analysis is implemented in:

- [`analysis.R`](analysis.R)

This script demonstrates:

- Dimensionality reduction using PCA
- Transformation of time series into correlation-based features
- Clustering of dynamic brain states (CAP analysis)

It reflects the main computational steps behind the results presented in the report.

---

## Reproducibility

- Code written in R
- Random seeds used for reproducibility
- Data not included due to HCP access restrictions

---

## Key Takeaways

This project demonstrates:

- Ability to handle high-dimensional time series data
- Application of PCA and clustering methods
- Modeling of complex systems
- Strong data visualization and interpretation skills
- Transformation of raw signals into meaningful insights

---

## Relevance

The methods used in this project are directly applicable to:

- Time series analysis
- Signal processing
- High-dimensional data modeling
- Complex system analysis (e.g. telemetry, engineering systems)

---

## Authors

Akshaan Murugesu  
Arijan Seipi  
Bastien Olivier Mutzner  
Munire Hagoose  

Master’s students in Statistics – University of Geneva

