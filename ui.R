# Execute our custom script for loading packages
source("usePackages.R")
# Name of the packages 
pkgnames <- c("shiny")
# Use our custom load function
loadPkgs(pkgnames)

# Define UI for random distribution application 
shinyUI(fluidPage(
  
  # Application title
  headerPanel("MindMatch"),
  
  # Sidebar with controls to select the random distribution type
  # and number of observations to generate. Note the use of the br()
  # element to introduce extra vertical spacing
  sidebarPanel(
    htmlOutput("sidebarInstruction")
  ),
  
  # Show a tabset that includes a plot, summary, and table view
  # of the generated distribution
  mainPanel(
    tabsetPanel(
      id = "tabsPanel", #for identification of which tab is open
      tabPanel("Menu", value = "MenuTab", 
               "Please enter the names",
               #fields to enter name
               textInput("player1Name", "Player 1 name", "Player1"),
               textInput("player2Name", "Player 2 name", "Player2"),
               #submission button
               actionButton("startButt", "Start a new game!")
               ), 
      tabPanel("Game", value = "GameTab",
               htmlOutput("player1Name"),
               htmlOutput("player1Score"),
               htmlOutput("player2Name"),
               htmlOutput("player2Score"),
               imageOutput("cell11",height="100px",width="100px",click="click11",inline=TRUE), 
               imageOutput("cell12",height="100px",width="100px",click="click12",inline=TRUE)
      )
    )
  ))
)
