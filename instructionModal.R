#outputs instruction modal
instructionModal <- function(){
  modal <- fluidPage(
    tags$h4("Learn how to support how to support your loved ones with mental health concerns!"), 
    tags$hr(),
    tags$h5("How to play:"), 
    tags$ul(
      tags$li("Each player takes turns to flip any 2 memory cards within 20 seconds."), 
      tags$li("If the picture on the memory card matches, the player proceed to answer a randomly generated quiz question. Otherwise, the mismatched cards are flipped back and the turn ends. Then, it’s the next player's turn to flip any 2 cards."), 
      tags$li("If the quiz question is answered correctly, the player collects the 2 matching memory cards and scores a point for each card collected. If answered incorrectly or if the player chooses to reveal the answer, opponent gets the cards and earns points instead."),
      tags$li("To obtain an action card, the player must find the matching coloured memory card. Possible action cards are Bonus, Skip or Answer Together."),
      tags$li("If the player chooses matching chance cards, a chance action is randomly selected and it will be effective immediately before the player answers a quiz question."),
      tags$li("The game ends when all of the memory cards are matched or if the question bank is exhausted. The player with the most points wins the game.")
    )
  ) 
  return(modal)
}