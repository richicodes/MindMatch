#outputs end of modal
endModal <- function(p1Score, p1Name, p2Score, p2Name){
  
  if (p1Score != p2Score){
    winner <- c(p1Name,p2Name)[which.max(c(p1Score, p2Score))]
    loser <- c(p1Name,p2Name)[which.min(c(p1Score, p2Score))]
    modal <- fluidPage(
      img(src="congratulations.jpg", height="70%", width="70%", style="display: block; margin-left: auto; margin-right: auto;", alt="found on google"),
      tags$h6(tags$a(href="https://www.pinterest.com/pin/551620654356891248/", "image credit"), align="center"), 
      tags$hr(),
      tags$h4(paste(winner, "wins with", p1Score, "points!"), align="center"), 
      tags$br(),
      tags$h4(paste(loser, "loses with", p2Score, "points!"), align="center")
      
    )} else {
      modal <- fluidPage(
        img(src="congratulations.jpg", height="70%", width="70%", style="display: block; margin-left: auto; margin-right: auto;", alt="found on google"),
        tags$hr(),
        tags$h4(paste(p1Name, "and", p2Name, "are tied with", p1Score, "points!"))
  )} 
  return(modal)
}


# testing
# getscores <- function(p1Score, p1Name, p2Score, p2Name){
#   if (p1Score != p2Score){
#   winner <- c(p1Name,p2Name)[which.max(c(p1Score, p2Score))]
#   loser <- c(p1Name,p2Name)[which.min(c(p1Score, p2Score))]
#   paste("the winner is", winner, "with", p1Score, "points, and the loser is", loser, "with", p2Score, "points!")
#   
#   } else{
#     paste(p1Name, "and", p2Name, "are tied with", p1Score, "points!")
#   }
# 
# 
# }
# 
# getscores(10, "player1", 10, "player2")
