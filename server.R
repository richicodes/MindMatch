# Execute our custom script for loading packages
source("usePackages.R")
# Name of the packages 
pkgnames <- c("shiny")
# Use our custom load function
loadPkgs(pkgnames)

# Define server logic for random distribution application
shinyServer(function(input, output, session) {
  
  vals <- reactiveValues(
    #tab opened
    tabOpen = NULL)
  
  playerVals <- reactiveValues(
    #player names
    player1Name = "Player 1", 
    player2Name = "Player 2", 
    #card scores
    player1Score = NULL,
    player2Score = NULL
    )
  
  gameVals <- reactiveValues(
    #whose turn is it; 1 or 2, representing player 1 or 2
    playerTurn = NULL,
    #name of player in turn
    playerName = NULL,
    #game state (e.g. is it to pick card or answer question)
    # PC1: pick first card
    # PC2: pick second card
    # AQ: answer question
    gameState = NULL,
    #power card, if we ever get to that state
    powerCard = NULL,
    #stores order of cards, whether if it is opened
    cardMatrix = NULL,
    #stores questions that are answered
    questionsAnswered = NULL)
  
  questionvals <- reactiveValues(question = NULL) #TBC
  
  #games tab is hidden by default
  hideTab(inputId = "tabsPanel", target = "GameTab")
  
  #track which tab is open
  observe({
    vals$tabOpen <- input$tabsPanel
  })
  
  observeEvent(input$startButt, {
    #unhide game tab and switches to it
    showTab(inputId = "tabsPanel", target = "GameTab")
    updateTabsetPanel(session, "tabsPanel", selected = "GameTab")
    
    #sets player names, or playerN if input is empty
    if (nchar(input$player1Name) > 0){playerVals$player1Name <- input$player1Name} 
    if (nchar(input$player2Name) > 0){playerVals$player2Name <- input$player2Name}
    
    #initialise game settings
    gameVals$playerTurn <-  1
    gameVals$playerName <- playerVals$player1Name
    gameVals$gameState <- "PC1"
    playerVals$player1Score <-  0
    playerVals$player2Score <-  0
  })
  
  #output vals for player names
  output$player1Name <- renderUI(playerVals$player1Name)
  output$player2Name <- renderUI(playerVals$player2Name)
  
  #output for side panel
  output$sidebarInstruction <- renderUI(
    if (vals$tabOpen == "MenuTab"){
      "INSTRUCTIONS goes here"
    }
    else if (vals$tabOpen == "GameTab"){
      if (gameVals$gameState == "PC1") {
        #prompt for choices if game state is AQ
        tabPanel("gameInfoDisplay", 
                 paste0(gameVals$playerName, " pick first card"))
      }
      else if (gameVals$gameState == "PC2") {
        #prompt for choices if game state is AQ
        tabPanel("gameInfoDisplay", 
                 paste0(gameVals$playerName, " pick second card"))
      }
      else if (gameVals$gameState == "AQ") {
        #prompt for choices if game state is AQ
        tabPanel("gameInfoDisplay",
                 paste0(gameVals$playerName, " answer this question"),
                 radioButtons("answerChoice", "QUESTION", c("Choice 1", 
                                                            "Choice 2", 
                                                            "Choice 3")),
                 actionButton("answerButt", "Answer"))
      }
    })
  
  #making image matrix
  renderCell <- function(gridrow,gridcol){
    renderImage({
      #select the icon appropriate for this cell
      imageid <- 1
      if (!is.null(vals$cardMatrix)) imageid <- vals$cardMatrix[gridrow,gridcol]+1
      imgsrc=switch(imageid,"www/tokenA.jpg", "www/tokenB.jpg")
      # Unfortunately, we are not able to re-size the image and still have the click event work. 
      # So the image files must have exactly the size we want.
      # Also, z-order works only if 'position' is set.
      list(src=imgsrc,style="position:relative;z-order:999") 
    },deleteFile=FALSE)
  }
  
  output$cell11 <- renderCell(1,1)
  output$cell12 <- renderCell(1,2)
  
  #determine next turn
  nextTurn <- function(){
    gameVals$playerTurn <- (gameVals$playerTurn %% 2) + 1
    gameVals$playerName <- switch(gameVals$playerTurn, playerVals$player1Name, playerVals$player2Name)
  }
  
  #track clicking of images
  processClickEvent <- function(gridrow,gridcol){
    if (gameVals$gameState == "PC2"){
      gameVals$gameState  <-  "AQ"
    }
    else if (gameVals$gameState == "PC1"){
      #advance to pick second card
      gameVals$gameState  <-  "PC2"
    }
  }
  
  #process clicks of images
  observeEvent(input$click11,{processClickEvent(1,1)})
  observeEvent(input$click12,{processClickEvent(1,2)})
  
  #process clicks of answerbutton
  observeEvent(input$answerButt,{
    #Adds score for player and advance to answer question
    if (gameVals$playerTurn == 1){
      playerVals$player1Score <- playerVals$player1Score + 1
    }
    else{
      playerVals$player2Score <- playerVals$player2Score + 1
    }
    nextTurn()
    gameVals$gameState  <-  "PC1"
  })
  
  #output vals for player scores
  output$player1Score <- renderUI(as.character(playerVals$player1Score))
  output$player2Score <- renderUI(as.character(playerVals$player2Score))
  
})