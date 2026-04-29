# fMRI Functional Connectivity Analysis
**Dimensionality Reduction and Dynamic Brain State Modeling**

High-dimensional fMRI analysis using PCA and Co-Activation Pattern (CAP) clustering to study functional connectivity and dynamic brain states from Human Connectome Project data.

---

## Repository Structure

```
├── MVA_Project_Synth.pdf   # Report with figures and results
├── README.md
├── analysis.R              # Full pipeline: EDA → PCA → cross-subject PCA → CAP
├── brain_plots.R           # R script for brain plots
```

---

## Highlights

- 90 subjects, 100 brain regions (ROIs), ~1150 time points per subject
- PCA reduces single-subject data to **13 components for 90% variance retention**
- Cross-subject connectivity compressed from **10,000 features to 40 principal components**
- CAP analysis identifies **3 interpretable dynamic brain states**

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

> Data not included due to HCP access restrictions.

---

## Methods

### 1. Single-Subject PCA

Applied PCA to individual subject time series to capture dominant spatial activation patterns.

Key results:
- PC1 explains **57.9%** of variance (global co-activation)
- First 5 PCs explain ~80%
- 13 PCs explain ~90%
- Reconstruction preserves key brain activation patterns

---

### 2. Cross-Subject PCA (Connectivity-Based)

Challenge: variable time series length across subjects with no temporal alignment.

Solution:
- Compute ROI–ROI correlation matrix (100 × 100) per subject
- Vectorize into 10,000-dimensional feature vectors
- Build dataset of size **90 × 10,000**
- Apply PCA to extract shared connectivity structure

Results:
- 40 PCs explain ~90% of variance
- Strong preservation of functional connectivity patterns

---

### 3. Co-Activation Pattern (CAP) Analysis

Objective: capture dynamic brain states instead of static connectivity.

Pipeline:
- Select top 30% most active time points
- Cluster using k-means (k = 3, chosen via elbow method)

Results:
- **CAP 1 — Task-engaged state**: strong within-network activity (Somatomotor, Attention, Salience)
- **CAP 2 — Internal processing state**: increased activity in Default Mode, Limbic, Executive networks
- **CAP 3 — Global co-activation state**: broad positive activation across all networks

---

## Tech Stack

`R` · `prcomp` · `kmeans` · `ggplot2` · `pheatmap` · `gridExtra` · `patchwork`

---

## AI Usage

AI tools (Claude, ChatGPT) were used to assist with code debugging, refactoring, and visualisation. All analytical choices, methodology, and interpretations are entirely our own.

---

## Authors

Akshaan Murugesu · Arijan Seipi · Bastien Olivier Mutzner · Munire Hagoose

MSc Statistics — University of Geneva
