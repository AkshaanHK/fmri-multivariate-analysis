# Main analysis script for the fMRI multivariate analysis project
# Methods included:
# - PCA on a single subject
# - Correlation-based PCA across subjects
# - Co-Activation Pattern (CAP) clustering

# -----------------------------
# Load data and required packages
# -----------------------------
load("subjects-fMRI.RData")

# Optional helper for brain visualizations if available
# source("brain_plots.R")

library(pheatmap)

# -----------------------------
# 1. Exploratory data summary
# -----------------------------
n_timepoints <- sapply(subj.fmri, function(x) ncol(x))

summary(n_timepoints)

# -----------------------------
# 2. PCA on a single subject
# -----------------------------
subject_5_data <- subj.fmri[[5]]

pca_result <- prcomp(t(subject_5_data), center = TRUE, scale. = TRUE)

explained_variance <- pca_result$sdev^2 / sum(pca_result$sdev^2)
cumulative_variance <- cumsum(explained_variance)

k_pc_90 <- which(cumulative_variance >= 0.9)[1]

cat("Single-subject PCA\n")
cat("Number of PCs explaining 90% variance:", k_pc_90, "\n")
cat("Variance explained by first 5 PCs:", round(sum(explained_variance[1:5]), 4), "\n")

# Reconstruction using the first PCs explaining 90% variance
approx_5_90 <- pca_result$center +
  (pca_result$x[, 1:k_pc_90] %*% t(pca_result$rotation[, 1:k_pc_90]))

# Peak activation time point
mean_signal <- colMeans(subject_5_data)
max_time_index <- which.max(abs(mean_signal))

# Reconstruction error at the peak time point
reconstruction_error <- approx_5_90[max_time_index, ] - subject_5_data[, max_time_index]

mse <- mean(reconstruction_error^2)
mae <- mean(abs(reconstruction_error))

cat("Peak time index:", max_time_index, "\n")
cat("Reconstruction MSE:", round(mse, 4), "\n")
cat("Reconstruction MAE:", round(mae, 4), "\n")

# -----------------------------
# 3. PCA across subjects using correlation matrices
# -----------------------------
cor_matrices <- lapply(subj.fmri, function(x) cor(t(x)))
vectorized_cor_matrix <- do.call(rbind, lapply(cor_matrices, as.vector))

pca_multi <- prcomp(vectorized_cor_matrix, center = TRUE, scale. = FALSE)

cumsumvar_multi <- cumsum(pca_multi$sdev^2) / sum(pca_multi$sdev^2)
k_multi_90 <- which(cumsumvar_multi >= 0.9)[1]

cat("\nMulti-subject PCA\n")
cat("Number of PCs explaining 90% variance:", k_multi_90, "\n")

# Reconstruction function
approx_data <- function(pca_obj, subject_index, rank) {
  pca_obj$center + pca_obj$x[subject_index, 1:rank] %*% t(pca_obj$rotation[, 1:rank])
}

# Reconstruct subject 5 correlation matrix
corr_5 <- matrix(vectorized_cor_matrix[5, ], nrow = 100, ncol = 100)
x_approx <- matrix(approx_data(pca_multi, 5, k_multi_90), nrow = 100, ncol = 100)

diff_matrix <- corr_5 - x_approx

cat("Mean absolute reconstruction error (correlation matrix):",
    round(mean(abs(diff_matrix)), 4), "\n")

# -----------------------------
# 4. Co-Activation Pattern (CAP) analysis
# -----------------------------
mean_activation <- colMeans(abs(subject_5_data))
threshold <- quantile(mean_activation, 0.70)
selected_time_points <- which(mean_activation > threshold)
filtered_data <- subject_5_data[, selected_time_points]

cat("\nCAP analysis\n")
cat("Selected active time points:", length(selected_time_points), "\n")

# Elbow method values
k_values <- 2:10
wcss <- numeric(length(k_values))

for (i in seq_along(k_values)) {
  set.seed(123)
  km <- kmeans(t(filtered_data), centers = k_values[i], nstart = 10)
  wcss[i] <- km$tot.withinss
}

# Final clustering
set.seed(11)
k <- 3
cap_clusters <- kmeans(t(filtered_data), centers = k, nstart = 10)

cat("Chosen number of CAP clusters:", k, "\n")
cat("Cluster sizes:\n")
print(table(cap_clusters$cluster))

# -----------------------------
# 5. Network-level CAP summaries
# -----------------------------
network_names <- c(
  "Visual", "Somatomotor", "Dorsal Attention",
  "Salience", "Limbic", "Central Executive", "Default"
)

network_labels <- c(
  rep(network_names[1], 9), rep(network_names[2], 6), rep(network_names[3], 8),
  rep(network_names[4], 7), rep(network_names[5], 3), rep(network_names[6], 4),
  rep(network_names[7], 13), rep(network_names[1], 8), rep(network_names[2], 8),
  rep(network_names[3], 7), rep(network_names[4], 5), rep(network_names[5], 2),
  rep(network_names[6], 9), rep(network_names[7], 11)
)

compute_network_correlations <- function(cap_data, network_labels) {
  cor_matrix <- cor(t(cap_data))
  unique_networks <- unique(network_labels)
  
  network_corr <- matrix(
    0,
    nrow = length(unique_networks),
    ncol = length(unique_networks)
  )
  
  rownames(network_corr) <- unique_networks
  colnames(network_corr) <- unique_networks
  
  for (net1 in unique_networks) {
    for (net2 in unique_networks) {
      idx1 <- which(network_labels == net1)
      idx2 <- which(network_labels == net2)
      network_corr[net1, net2] <- mean(cor_matrix[idx1, idx2])
    }
  }
  
  network_corr
}

network_level_results <- list()

for (i in 1:k) {
  cap_data <- filtered_data[, cap_clusters$cluster == i]
  network_level_results[[paste0("CAP_", i)]] <-
    compute_network_correlations(cap_data, network_labels)
}

cat("\nNetwork-level CAP summaries computed for", k, "states.\n")