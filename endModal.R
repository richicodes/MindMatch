#outputs end of modal
endModal <- function(p1Score, p1Name, p2Score, p2Name){
  winner <- c(p1Name,p2Name)[which.max(c(p1Score, p2Score))]
  loser <- c(p1Name,p2Name)[which.min(c(p1Score, p2Score))]
  modal <- fluidPage(
    tags$h4(paste0(winner, " wins with ", p1Score, " points!")), 
    tags$hr(),
    tags$h5(paste0(loser, " loses with ", p2Score, " points"))
  ) 
  return(modal)
}


# testing
# getscores <- function(p1Score, p1Name, p2Score, p2Name){
#   winner <- c(p1Name,p2Name)[which.max(c(p1Score, p2Score))]
#   loser <- c(p1Name,p2Name)[which.min(c(p1Score, p2Score))]
#   paste("the winner is", winner, "with", p1Score, "points, and the loser is", loser, "with", p2Score, "points")
# 
#   
# }
# 
# getscores(10, "player1", 3, "player2")
