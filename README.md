# aicomposer

A simple R program to generate random chord combinations that are musically pleasing (well, mostly).
Despite the name, I do not claim to have implemented any "AI" other than "if else" type of decision making.
The logic will be expanded as and when I get the time. 

## Useage

The main entry point function is chords_randomize(). This takes three arguments, which has defaults defined in case no arguments are specified.
root : Root note of the musical scale. Default is "C"
scale : Type of scale, major or minor. Default is "Maj"
measures : default is 4


Examples: 
    chords_randomize("D", "Maj'", 8)
    chords_randomize("C#", "min")

NOTE: 
  The first two arguments are character, and need quotes.
  Known issue - flats are not recognized in arguments. For e.g. specify "A#" if you want the B-flat scale.
