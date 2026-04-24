# fMRI Functional Connectivity Analysis  
**Dimensionality Reduction and Dynamic Brain State Modeling**

High-dimensional fMRI analysis using PCA and Co-Activation Pattern (CAP) clustering to study functional connectivity and dynamic brain states from Human Connectome Project data.

---

## Repository Structure

```
├── MVA_Project_Synth.pdf   # Report with figures and results
├── README.md
├── analysis.R              # Full pipeline: EDA → PCA → cross-subject PCA → CAP
├── brain_plots.R              # R script for brain plots
```

---

## Highlights

- 90 subjects, 100 brain regions (ROIs), ~1150 time points per subject  
- PCA reduces single-subject data to **13 components for 90% variance retention**  
- Cross-subject connectivity compressed from **10,000 features to 40 principal components**  
- CAP analysis identifies **3 interpretable dynamic brain states**  
- End-to-end analysis pipeline implemented in R  

---

## Project Overview

This project analyzes high-dimensional fMRI time series to extract meaningful patterns of brain activity and connectivity.

Key objectives:
- Reduce dimensionality of complex neural signals  
- Compare functional connectivity across subjects  
- Identify dynamic brain states beyond static correlation structures  

---

## Dataset

Subset of the Human Connectome Project (HCP) dataset:

- 90 subjects (ages 22–36+)  
- 100 brain regions (ROIs)  
- ~1150 time points per subject  
- BOLD signals (blood-oxygen-level-dependent)  
- 7 functional networks (e.g., Visual, Default Mode, Salience)

Each subject is represented by a matrix:
- **100 × T** (ROIs × time points)

**Note:** Data not included due to access restrictions.

---

## Methods

### 1. Single-Subject PCA

- Applied PCA to individual subject time series  
- Captures dominant spatial activation patterns  

**Key results:**
- PC1 explains **57.9%** of variance (global co-activation)  
- First 5 PCs explain ~80%  
- 13 PCs explain ~90%  
- Reconstruction preserves key brain activation patterns  

---

### 2. Cross-Subject PCA (Connectivity-Based)

**Challenge:**
- Variable time series length across subjects  
- No temporal alignment  

**Solution:**
- Compute ROI–ROI correlation matrix (100 × 100) per subject  
- Vectorize into 10,000-dimensional feature vectors  
- Build dataset of size **90 × 10,000**

Then:
- Apply PCA to extract shared connectivity structure  

**Results:**
- 40 PCs explain ~90% of variance  
- Strong preservation of functional connectivity patterns  

---

### 3. Co-Activation Pattern (CAP) Analysis

**Objective:**  
Capture **dynamic brain states** instead of static connectivity.

**Pipeline:**
- Select top 30% most active time points  
- Cluster using k-means (k = 3, chosen via elbow method)

**Results:**

- **CAP 1 — Task-engaged state**  
  Strong within-network activity (Somatomotor, Attention, Salience)

- **CAP 2 — Internal processing state**  
  Increased activity in Default Mode, Limbic, Executive networks  

- **CAP 3 — Global co-activation state**  
  Broad positive activation across all networks  

---

## Technical Contributions

- Built a complete analysis pipeline in R:
  - Data preprocessing and EDA  
  - PCA-based dimensionality reduction  
  - Feature engineering via correlation matrices  
  - Unsupervised clustering of brain states  

- Designed a cross-subject representation for non-aligned time series  
- Implemented CAP analysis without specialized neuroimaging libraries  
- Produced interpretable visualizations of high-dimensional data  

---

## Tech Stack

- R  
- prcomp (PCA)  
- kmeans (clustering)  
- ggplot2 (visualization)  
- pheatmap  
- gridExtra  
- patchwork  

---

## Why This Project Matters

This project demonstrates the ability to:

- Work with high-dimensional time series data  
- Perform dimensionality reduction and feature engineering  
- Apply unsupervised learning to complex signals  
- Translate raw data into interpretable insights  

**Applications:**
- Signal processing  
- Time series modeling  
- Anomaly detection  
- High-dimensional data analysis  

---

## Authors

- Akshaan Murugesu  
- Arijan Seipi  
- Bastien Olivier Mutzner  
- Munire Hagoose  

MSc Statistics — University of Geneva  
