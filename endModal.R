#outputs end of modal
endModal <- function(p1Score, p1Name, p2Score, p2Name){
  modal <- fluidPage(
    tags$h4(paste0(p1Name, " wins with ", p1Score, " points!")), 
    tags$hr(),
    tags$h5(paste0(p2Name, " loses with ", p2Score, " points"))
  ) 
  return(modal)
}