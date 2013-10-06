#Explore Manipulate Functions

questionmarkToValue <- function(c.array, char){
  selection <- which(c.array == char)
  c.array <- as.character(levels(c.array)[c.array])
  c.array[selection] <- 0.0
  c.array <- as.numeric(c.array)
  return(c.array) 
}