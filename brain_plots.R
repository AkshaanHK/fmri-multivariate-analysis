# this R script provides suggestions to plot brain data
# Notice that the plot is based on *ggplot*, hence you can modify the function accordingly to your needs (e.g. aesthetic parameters)

# packages ----------------------------------------------------------------
library(dplyr)
library(ggplot2)
library(reshape2)

library(ggseg)
library(ggseg3d)
library(ggsegSchaefer)



# plot functions ----------------------------------------------------------

brain_plot <- function(y, roiNames, myTitle=NULL){
  
  # INPUTS
  # *y*           [vector]          observed signal to plot on each ROI
  # *roiNames*    [vector]          character vector of ordered names of the ROIs
  # *myTitle*     [character]       plot title to display
  
  # OUTPUT :
  # *p*           [ggplot object]   plot of the intensity of the signal *y* on the ROIs; views from the left/right hemishepre and medial/letaral side
  
  df <- tibble(
    # build the dataset
    region = roi.names, 
    y = y,
    hemi = rep(c("left", "right"), each = 50)
  )
  
  # ggplot object
  p = df %>%
    ggplot() +
    geom_brain(atlas = schaefer7_100,                                                              # type of atlas: Schaefer100
               position = position_brain(side ~ hemi),                                             # *hemi* is in {right, left};  *side* is in {lateral, medial}
               aes(fill = y)) +
    scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0) +                # color scale to fill the ROIs
    xlab("hemisphere") +                                                                           # label on the x-axis
    ylab("side") +                                                                                 # label on the y-axis 
    annotate("text", x = -30, y = 100, label = "Lateral", size = 4, hjust = 0, angle = 90) +       # labels of *side* (for easier interpretation)
    annotate("text", x = -30, y = 350, label = "Medial", size = 4, hjust = 0, angle = 90) +        
    annotate("text", x = 150, y = -30, label = "Left", size = 4, hjust = 0) +                      # labels of *hemi* (for easier interpretation)
    annotate("text", x = 500, y = -30, label = "Right", size = 4, hjust = 0) +
    ggtitle(myTitle) +                                                                             # title
    theme_minimal() +                                                                              
    theme(axis.text.x = element_blank(),                                                           # remove axis text
                  axis.text.y = element_blank(),
                  axis.ticks.x = element_blank(),
                  axis.ticks.y = element_blank())
  
  return(p)
}