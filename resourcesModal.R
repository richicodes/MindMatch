#outputs instruction modal
resourcesModal <- function(){
  modal <- fluidPage(
    tags$h4("This is the resources page"), 
    tags$hr(),
    tags$h5("How to play:"), 
    tags$ul(
      tags$li("Each player takes turns to flip any 2 memory cards within 20 seconds."), 
      tags$li("If the picture on the memory card matches, the player proceed to answer a randomly generated quiz question. Otherwise, the mismatched cards are flipped back and the turn ends. Then, it’s the next player's turn to flip any 2 cards."), 
      tags$li("If the quiz question is answered correctly, the player collects the 2 matching memory cards and scores a point for each card collected. If answered incorrectly, opponent gets the cards and earns points instead."),
      tags$li("To obtain a chance card, the player must find the matching coloured memory card."),
      tags$li("If the player chooses matching chance cards, a chance action is randomly selected and it will be effective immediately before the player answers a quiz question."),
      tags$li("The game ends when all of the memory cards are matched and the player with the most points wins the game.")
    )
  ) 
  return(modal)
}