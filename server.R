# Execute our custom script for loading packages
source("usePackages.R")
source("setAWSPassword.R")
source("cardmatrix.R")
source("questions.R")
source("instructionModal.R")
source("resourcesModal.R")
source("endModal.R")

# Name of the packages 
pkgnames1 <- c("shiny")
# Use our custom load function
loadPkgs(pkgnames1)

# Define server logic for random distribution application
shinyServer(function(input, output, session) {
  
  vals <- reactiveValues(
    #which tab is opened
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
    # WC: wrong card
    # AQ: answer question
    # EG: end game
    gameState = NULL,
    
    #action card, if we ever get to that state
    actionCard = F,
    
    #stores order of cards, whether if it is opened
    cardMatrix = NULL,
    
    #stores the order of the cards on the board
    cardMatrixTemp = NULL,
    
    #stores the first unflipped card
    firstCard = list("row" = FALSE, "col" = FALSE),
    
    #stores the second unflipped card
    secondCard = list("row" = FALSE, "col" = FALSE),
    
    #stores questions that are answered
    questionsAnswered = c(),
    
    #stores question answered Now
    questionAnsweredNow = NULL,
    
    #stores answer
    answerCorrect = NULL, 
    
    #stores answer text
    answerCorrectText = NULL,
    
    #stores cards that are opened
    cardsOpened = c(),
    
    #proportion of cards completed
    gameProgress = 0
    )
  
  #determine next turn
  nextTurn <- function(){
    gameVals$playerTurn <- (gameVals$playerTurn %% 2) + 1
    gameVals$playerName <- switch(gameVals$playerTurn, playerVals$player1Name, playerVals$player2Name)
  }
  
  #games tab is hidden by default
  hideTab(inputId = "tabsPanel", target = "GameTab")
  
  #track which tab is open
  observe({
    vals$tabOpen <- input$tabsPanel
  })
  
  #reset game
  gameReset <- function(){
    #initialise game settingswhen new game starts
    gameVals$cardMatrix <- generateMatrix()
    gameVals$cardMatrixTemp <-  NULL
    gameVals$playerTurn <-  1
    gameVals$playerName <- playerVals$player1Name
    gameVals$gameState <- "PC1"
    gameVals$questionsAnswered <- c()
    gameVals$cardsOpened <- c()
    gameVals$gameProgress <- 0
    firstCard = list("row" = FALSE, "col" = FALSE)
    secondCard = list("row" = FALSE, "col" = FALSE)
    playerVals$player1Score <-  0
    playerVals$player2Score <-  0
  }
  
  observeEvent(input$startButt, { 
    #unhide game tab and switches to it
    showTab(inputId = "tabsPanel", target = "GameTab")
    updateTabsetPanel(session, "tabsPanel", selected = "GameTab")
    
    #sets player names, or playerN if input is empty
    if (nchar(input$player1Name) > 0){playerVals$player1Name <- input$player1Name} 
    if (nchar(input$player2Name) > 0){playerVals$player2Name <- input$player2Name}
    
    #reset game
    gameReset()
  })
  
  #output vals for player names
  output$player1Name <- renderUI(playerVals$player1Name)
  output$player2Name <- renderUI(playerVals$player2Name)
  
  #output for game progress
  output$gameProgress <- renderUI(tags$b(paste0("Game progress: ", gameVals$gameProgress*100, "%")))
  
  #output for side panel
  output$sidebarInstruction <- renderUI(
    if (vals$tabOpen == "MenuTab"){
      fluidPage(
        img(src = "Mindmatchlogo.png", height = 75, width = 150 ),
        tags$hr(),
        tags$h5("About our game:"),
        tags$p("MindMatch is a memory-quiz game that aims to help reduce mental health stigmatisation by spreading awareness about the common struggles people with mental health issues face and teach us ways that we can support them. "),
        actionButton("instructButt", "Instructions"),
        tags$br(),
        actionButton("resourcesButt", "Resources")
      )
    }
    else if (vals$tabOpen == "GameTab"){
      print("STOP BYEBYE")
      if (gameVals$gameState == "PC1") {
        #prompt for choices if game state is AQ
        tabPanel("gameInfoDisplay", 
                 paste0(gameVals$playerName, " pick first card."))
      }
      else if (gameVals$gameState == "PC2") {
        #prompt for choices if game state is AQ
        tabPanel("gameInfoDisplay", 
                 paste0(gameVals$playerName, " pick second card."))
      }
      else if (gameVals$gameState == "WC") {
        #prompt for choices if game state is AQ
        tabPanel("gameInfoDisplay", 
                 "Cards don't match! Click on any card to end turn")
      }
      else if (gameVals$gameState == "AQ") {
        #retrieve question
        questionOut <- questionRetrieve(gameVals$questionsAnswered)
        print(questionOut)
        print("STOP HELLO")
        
        #sets correct value for answer and updates questions answered
        gameVals$questionAnsweredNow <- questionOut[["questionID"]]
        gameVals$answerCorrect <- questionOut[["correct_option_index"]]
        gameVals$answerCorrectText <- questionOut[["options"]][questionOut[["correct_option_index"]]]
        
        #prompt for choices if game state is AQ
        tabPanel("gameInfoDisplay",
                 paste0(gameVals$playerName, " answer this question"),
                 radioButtons("answerChoice", 
                              questionOut[["question"]], 
                              choiceNames = c(questionOut[["options"]], "Show Answer"),
                              choiceValues  = c(1, 2, 3, 4, 5),
                              selected = 5),
                 actionButton("answerButt", "Answer"))
      }
    })
  
  #launches instruction modal
  observeEvent(input$instructButt,{
    showModal(modalDialog(instructionModal()
    ))
  })
  
  observeEvent(input$resourcesButt,{
    showModal(modalDialog(resourcesModal()
    ))
  })
  
  #making image matrix
  renderCell <- function(gridrow,gridcol){
    renderImage({
      # checks for game completeness on the first cell
      if (gridrow == 1 & gridcol == 1){
        # checks if all cards are opened or all questions are answered
        noCardsOpened <- length(gameVals$cardsOpened)
        gameVals$gameProgress <- noCardsOpened/input$gameSize
        if ( gameVals$gameProgress >= 1 | 
            length(gameVals$questionsAnswered) == 35){
          #if (T){ # use this as short cut to check end modal
          endGame()
        }
      }
      
      row <- toString(gridrow)
      col <- toString(gridcol)
      #select the icon appropriate for this cell
      card <- gameVals$cardMatrix[[row]][[col]]
      
      #show real card if its already opened
      if (card[["open"]]){ #if card is opened
        imgsrc <- paste0("www/patterns/", card["img"])
        # adds image into cardsOpened list if its not already inside
        gameVals$cardsOpened <- union(gameVals$cardsOpened, card["img"])
      }
      else{
        #show real card if flipped open by game action
        if ((gameVals$firstCard[["row"]] == row & gameVals$firstCard[["col"]] == col) |
            (gameVals$secondCard[["row"]] == row & gameVals$secondCard[["col"]] == col)){
          imgsrc <- paste0("www/patterns/", card["img"])
        }
        #show closed card if flipped if its closed
        else{
          imgsrc <- "www/closed.png"
        }
      }
      # Unfortunately, we are not able to re-size the image and still have the click event work. 
      # So the image files must have exactly the size we want.
      # Also, z-order works only if 'position' is set.
      list(src=imgsrc,style="position:relative;z-order:999") 
    },deleteFile=FALSE)
  }
  
  #creates and maintains images for cells
  output$cell11 <- renderCell(1,1)  
  output$cell12 <- renderCell(1,2) 
  output$cell13 <- renderCell(1,3)  
  output$cell14 <- renderCell(1,4)
  output$cell15 <- renderCell(1,5)  
  output$cell16 <- renderCell(1,6)
  
  output$cell21 <- renderCell(2,1) 
  output$cell22 <- renderCell(2,2) 
  output$cell23 <- renderCell(2,3)  
  output$cell24 <- renderCell(2,4)
  output$cell25 <- renderCell(2,5)  
  output$cell26 <- renderCell(2,6)
  
  output$cell31 <- renderCell(3,1) 
  output$cell32 <- renderCell(3,2) 
  output$cell33 <- renderCell(3,3)  
  output$cell34 <- renderCell(3,4)
  output$cell35 <- renderCell(3,5)  
  output$cell36 <- renderCell(3,6)
  
  output$cell41 <- renderCell(4,1) 
  output$cell42 <- renderCell(4,2) 
  output$cell43 <- renderCell(4,3)  
  output$cell44 <- renderCell(4,4)
  output$cell45 <- renderCell(4,5)  
  output$cell46 <- renderCell(4,6)
  
  output$cell51 <- renderCell(5,1) 
  output$cell52 <- renderCell(5,2) 
  output$cell53 <- renderCell(5,3)  
  output$cell54 <- renderCell(5,4)
  output$cell55 <- renderCell(5,5)  
  output$cell56 <- renderCell(5,6)
  
  output$cell61 <- renderCell(6,1) 
  output$cell62 <- renderCell(6,2) 
  output$cell63 <- renderCell(6,3)  
  output$cell64 <- renderCell(6,4)
  output$cell65 <- renderCell(6,5)  
  output$cell66 <- renderCell(6,6)
  
  #track clicking of images
  processClickEvent <- function(gridrow,gridcol){
    row <- toString(gridrow)
    col <- toString(gridcol)
    card <- gameVals$cardMatrix[[row]][[col]]
    
    #if state is wrong card
    if (gameVals$gameState == "WC"){
      # change state and player
      gameVals$gameState  <-  "PC1"
      nextTurn()
      #Erases first and second card VAR
      gameVals$firstCard <- list("row" = FALSE, "col" = FALSE)
      gameVals$secondCard <- list("row" = FALSE, "col" = FALSE)
      showNotification(paste0("Pick some cards, ", gameVals$playerName))
    }

    #only react if card is closed (check from matrix and first card opened)
    else if (!card[["open"]] &
        !(gameVals$firstCard[["row"]] == row & 
          gameVals$firstCard[["col"]] == col)){
      
      #if its second card
      if (gameVals$gameState == "PC2"){
        
        gameVals$secondCard <- list("row" = row, "col" = col)
        
        #checks results
        outcome <- checkCard(gameVals$cardMatrix, gameVals$firstCard, gameVals$secondCard)
        if (outcome[["check"]]){
          #NOTE: reset first and second row after answering question (see answeringbutt function)
          #check for action card
          if (outcome[["action"]]){
            gameVals$actionCard <- sample(c("Skip", "Together", "Bonus"), 1)
            if (gameVals$actionCard == "Skip"){
              # show skip notification
              showNotification("You have picked a skip action card! Your turn is skipped!", type = "warning")
              # updates cardMatrix directly
              gameVals$cardMatrix <- outcome[["cardMatrix"]]
              # change state and player
              gameVals$gameState  <-  "PC1"
              nextTurn()
              #Erases first, second card, and Bonus card VAR
              gameVals$firstCard <- list("row" = FALSE, "col" = FALSE)
              gameVals$secondCard <- list("row" = FALSE, "col" = FALSE)
              showNotification(paste0("Pick some cards, ", gameVals$playerName))
              gameVals$actionCard <- F
            }
            else if (gameVals$actionCard == "Bonus"){
              # show bonus notification
              showNotification("You have picked a Bonus action card! Free points for you!", type = "warning")
              #give player points
              if (gameVals$playerTurn == 1){
                playerVals$player1Score <- playerVals$player1Score + 1
              }
              else{
                playerVals$player2Score <- playerVals$player2Score + 1
              }
              # updates cardMatrix directly
              gameVals$cardMatrix <- outcome[["cardMatrix"]]
              # change state and player
              gameVals$gameState  <-  "PC1"
              nextTurn()
              #Erases first, second card, and Bonus card VAR
              gameVals$firstCard <- list("row" = FALSE, "col" = FALSE)
              gameVals$secondCard <- list("row" = FALSE, "col" = FALSE)
              showNotification(paste0("Pick some cards, ", gameVals$playerName))
              gameVals$actionCard = F
            }
            else if (gameVals$actionCard == "Bonus"){
              # show success notification
              showNotification("You have picked an Answer Together action card! Please answer questions in prompt", type = "warning")
              #changes game state and updates cardMatrix
              gameVals$gameState  <-  "AQ"
              gameVals$cardMatrixTemp <- outcome[["cardMatrix"]]
            }
          }
          else{
            # show success notification
            showNotification("Success! Please answer questions in prompt")
            #changes game state and updates cardMatrix
            gameVals$gameState  <-  "AQ"
            gameVals$cardMatrixTemp <- outcome[["cardMatrix"]]
          }
        }
        else{
          #if cards don't match, change state to wrong card
          gameVals$gameState <- "WC"
          showNotification("Cards don't match. Click on any card to end turn")
        }
        
      }
      #if its first card
      else if (gameVals$gameState == "PC1"){
        #advance to pick second card
        gameVals$gameState <- "PC2"
        gameVals$firstCard <- list("row" = row, "col" = col)
      }
    }
  }
  
  #process clicks of images
  observeEvent(input$click11,{processClickEvent(1,1)})
  observeEvent(input$click12,{processClickEvent(1,2)})
  observeEvent(input$click13,{processClickEvent(1,3)})
  observeEvent(input$click14,{processClickEvent(1,4)})
  observeEvent(input$click15,{processClickEvent(1,5)})
  observeEvent(input$click16,{processClickEvent(1,6)})
  
  observeEvent(input$click21,{processClickEvent(2,1)})
  observeEvent(input$click22,{processClickEvent(2,2)})
  observeEvent(input$click23,{processClickEvent(2,3)})
  observeEvent(input$click24,{processClickEvent(2,4)})
  observeEvent(input$click25,{processClickEvent(2,5)})
  observeEvent(input$click26,{processClickEvent(2,6)})
  
  observeEvent(input$click31,{processClickEvent(3,1)})
  observeEvent(input$click32,{processClickEvent(3,2)})
  observeEvent(input$click33,{processClickEvent(3,3)})
  observeEvent(input$click34,{processClickEvent(3,4)})
  observeEvent(input$click35,{processClickEvent(3,5)})
  observeEvent(input$click36,{processClickEvent(3,6)})
  
  observeEvent(input$click41,{processClickEvent(4,1)})
  observeEvent(input$click42,{processClickEvent(4,2)})
  observeEvent(input$click43,{processClickEvent(4,3)})
  observeEvent(input$click44,{processClickEvent(4,4)})
  observeEvent(input$click45,{processClickEvent(4,5)})
  observeEvent(input$click46,{processClickEvent(4,6)})
  
  observeEvent(input$click51,{processClickEvent(5,1)})
  observeEvent(input$click52,{processClickEvent(5,2)})
  observeEvent(input$click53,{processClickEvent(5,3)})
  observeEvent(input$click54,{processClickEvent(5,4)})
  observeEvent(input$click55,{processClickEvent(5,5)})
  observeEvent(input$click56,{processClickEvent(5,6)})
  
  observeEvent(input$click61,{processClickEvent(6,1)})
  observeEvent(input$click62,{processClickEvent(6,2)})
  observeEvent(input$click63,{processClickEvent(6,3)})
  observeEvent(input$click64,{processClickEvent(6,4)})
  observeEvent(input$click65,{processClickEvent(6,5)})
  observeEvent(input$click66,{processClickEvent(6,6)})
  
  #process clicks of answerbutton
  observeEvent(input$answerButt,{##only react if there is input 
    #compares score
    if (length(input$answerChoice) == 0){
      #nothing happens if there is no input
    }
    else {
      # unions questionanswerednow and questionanswered
      gameVals$questionsAnswered <- append(gameVals$questionsAnswered, gameVals$questionAnsweredNow)
      if (input$answerChoice == gameVals$answerCorrect){
      #Adds score for player if correct
      showNotification("That is the correct answer!")
        #checks for bonus card
        if (gameVals$actionCard == "Bonus"){
          playerVals$player1Score <- playerVals$player1Score + 1
          playerVals$player2Score <- playerVals$player2Score + 1
          #reset bonus card
          gameVals$actionCard <- F
        }
        else{
        #assigns points if there is no action card
          if (gameVals$playerTurn == 1){
            playerVals$player1Score <- playerVals$player1Score + 1
          }
          else{
            playerVals$player2Score <- playerVals$player2Score + 1
          }
        }
        #sets open card
        gameVals$cardMatrix <- gameVals$cardMatrixTemp
        gameVals$cardMatrixTemp <- NULL
      }
      else {
        #if incorrect, add score of other player
        showNotification(paste0("The choice was not correct. The correct choice was ", gameVals$answerCorrectText, "."))
        #checks for bonus card
        if (gameVals$actionCard == "Bonus"){
          playerVals$player1Score <- playerVals$player1Score - 1
          playerVals$player2Score <- playerVals$player2Score - 1
          #reset bonus card
          gameVals$actionCard <- F
        }
        else{
          #assigns points if there is no action card
          if (gameVals$playerTurn == 1){
            playerVals$player2Score <- playerVals$player2Score + 1
          }
          else{
            playerVals$player1Score <- playerVals$player1Score + 1
          }
        }
      }
    
      # advance to answer question and turn
      nextTurn()
      gameVals$gameState  <-  "PC1"
      #Erases first and second card VAR
      gameVals$firstCard <- list("row" = FALSE, "col" = FALSE)
      gameVals$secondCard <- list("row" = FALSE, "col" = FALSE)
    }
  })
  
  #output vals for player scores
  output$player1Score <- renderUI(as.character(playerVals$player1Score))
  output$player2Score <- renderUI(as.character(playerVals$player2Score))
  
  #end game function
  endGame <- function(){
    gameVals$gameState <- "EG"
    showModal(
      modalDialog(
        endModal(playerVals$player1Score, playerVals$player1Name, playerVals$player2Score, playerVals$player2Name)
      )
    )
    #hide game tab and switches to menu tab
    hideTab(inputId = "tabsPanel", target = "GameTab")
    updateTabsetPanel(session, "tabsPanel", selected = "MenuTab")
    gameReset()
  }
  
})