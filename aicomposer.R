################################################################################
## "AI" Composer Project
##
##    Date          Author                Comments
##    ~~~~          ~~~~~~                ~~~~~~~~
## 06/29/2021    Dipankar Mitra        Initial version created.
################################################################################


## Function to randomly generate musical chords
## Input params 
##           root - Letter indicating root of scale

chords_randomize <- function(root = "C", scale = "Maj", measures = 8)
{
    ## Read the file circle_of_fifths.csv
    circle_5 <- read.csv("./circle_of_fifths.csv")
    transpose <- 0
    ## Check input parameter for root note
    transpose <- switch(root, "C#" = 1, "D" = 2, "D#" = 3, "E" = 4, "F" = 5,
                              "F#" = 6, "G" = 7, "G#" = 8, "A" = 9, 
                              "A#" = 10, "B" = 11)
    
    
    

}