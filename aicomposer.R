################################################################################
## "AI" Composer Project
##
##    Date          Author                Comments
##    ~~~~          ~~~~~~                ~~~~~~~~
## 06/29/2021    Dipankar Mitra        Initial version created.
## 07/07/2021    Dipankar Mitra        Added functionality for Maj scales.
## 07/09/2021    Dipanakr Mitra        Added functionality for min scales.
################################################################################


## Function to randomly generate musical chords
## Input params 
##           root - Single character indicating root of scale
##           scale - Character indicating Major or minor scale
##           measures = Numeric count of measures (assume 1 chord per measure)

chords_randomize <- function(root = "C", scale = "Maj", measures = 4)
{
    ## Read the file circle_of_fifths.csv
    note_table <- read.csv("./scales_notes.csv")

    ## Check input parameter for root note
    transpose <- switch(root, "C" = 1, "C#" = 2, "D" = 3, "D#" = 4, "E" = 5, 
                        "F" = 6,"F#" = 7, "G" = 8, "G#" = 9, "A" = 10, 
                              "A#" = 11, "B" = 12)
    
    numeric_chords <- generate_chords(measures)
    
    translate_chords(numeric_chords, scale, note_table, transpose)

}

generate_chords <- function(num_measures)
{
    if ((num_measures == 0) || (num_measures > 8))
    {
        num_measures <- 4
    }
    ## Sample randomly from 1st to 7th chords
    #set.seed(8)
    temp <- sample(1:7, size = (num_measures -1), replace = TRUE) 
    
    c(1, temp)
}

translate_chords <- function(chord_numbers, scale, chord_table, transpose)
{
    ret_val <- vector(mode = "character", length = 1 + length(chord_numbers))
    root_chords_maj <- c("C Maj", "C# Maj", "D Maj", "D# Maj", "E Maj", "F Maj", 
                     "F# Maj", "G Maj", "G# Maj", "A Maj", "Bp Maj", "B Maj")
    root_chords_min <- c("C min", "C# min", "D min", "D# min", "E min", "F min", 
                         "F# min", "G min", "G# min", "A min", "Bp min", "B min")
    
    if ((scale == "Minor") || (scale == "minor") || (scale == "min"))
    {
        ret_val[1] <- root_chords_min[transpose]
        
    } 
    else
    {
        ret_val[1] <- root_chords_maj[transpose]
    }
    

    for (i in 2:length(ret_val))
    {
        if ((scale == "Minor") || (scale == "minor") || (scale == "min"))
        {
            ret_val[i] <- chord_table[chord_numbers[i-1], transpose + 12]
            if (isMinorsclaeSecondchord(chord_numbers[i-1]) )
            {## second note could be either 7th chord or 4th minor chord
                temp <- sample(c(7,4), size = 1)
                ret_val[i] <- chord_table[temp, transpose+12]
            }
            if (isMinorscaleMinorchord(chord_numbers[i-1]))
            {
                ret_val[i] <- paste(ret_val[i], "min")
            }
            else
            {
                ret_val[i] <- paste(ret_val[i], "Maj")
            }
            
        } else
        { 
            ret_val[i] <-  chord_table[chord_numbers[i-1], transpose]
            if (isMajorscaleMinorchord(chord_numbers[i-1]))
            {
                ret_val[i] <- paste(ret_val[i], "min")
            }
            else if (isSeventhchord(chord_numbers[i-1]))
            {
                ret_val[i] <- paste(chord_table[5, transpose], "7")
            }
            else
            {
                ret_val[i] <- paste(ret_val[i], "Maj")
            }
        }
    }

    ret_val
}

## Helper function to check if chord should be minor in major scale

isMajorscaleMinorchord <- function(x)
{
    minor <- FALSE
    if ( x == 2 || x == 3 || x == 6)
    {
        minor <- TRUE
    }
    minor
}

## Helper function to check if chord should be minor in minor scale
isMinorscaleMinorchord <- function(x)
{
    minor <- FALSE
    if ( x == 1 || x == 4 || x == 5)
    {
        minor <- TRUE
    }
    minor
}

## Helper function to check if it is 2nd chord for minor scale
isMinorsclaeSecondchord <- function(x)
{
    return (x == 2)
}
## Helper function to check if chord should be 7th

isSeventhchord <- function(x)
{
    seventh <- FALSE
    if ( x == 7)
    {
        seventh <- TRUE
    }
    ## Also, let's randomize the V chord to V 7th 
    if (x == 5)
    {
        roll <- sample(1:2, size = 1, prob = c(0.25, 0.75))
        seventh <- switch(roll, TRUE, FALSE)
    }
    seventh
}    
    

