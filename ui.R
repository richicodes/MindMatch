# Execute our custom script for loading packages
source("usePackages.R")

# Name of the packages 
pkgnames <- c("shiny")
# Use our custom load function
loadPkgs(pkgnames)

# Define UI for random distribution application 
shinyUI(fluidPage(
  #notification appears left of screen
  tags$head(
    tags$style(
      HTML(".shiny-notification {
             position:relative;
             right: 65vw;
             }
             "
      )
    )
  ),
  
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
               "Please enter your names.",
               #fields to enter name
               textInput("player1Name", "Player 1", placeholder = "Input Player 1 name here"),
               textInput("player2Name", "Player 2", placeholder = "Input Player 2 name here"),
               #submission button
               actionButton("startButt", "Start game!")
               ), 
      tabPanel("Game", value = "GameTab",
               htmlOutput("player1Name"),
               htmlOutput("player1Score"),
               htmlOutput("player2Name"),
               htmlOutput("player2Score"),
               
               #to add a background image for the grid:
               # the trick here is to make the gameboard image 'position:absolute;z-order:0'; 
               # Then, to superimpose images, style them to be 'position:relative;z-order:999'
               #img(src='FantasyMap.jpg',style="position:absolute;z-order:0",width="415px",height="400px"),
               
               #images for matrix:
               imageOutput("cell11",height="100px",width="100px",click="click11",inline=TRUE), # height and width are for the containing div, not the image itself
               imageOutput("cell12",height="100px",width="100px",click="click12",inline=TRUE),  # height and width are for the containing div, not the image itself
               imageOutput("cell13",height="100px",width="100px",click="click13",inline=TRUE), # height and width are for the containing div, not the image itself
               imageOutput("cell14",height="100px",width="100px",click="click14",inline=TRUE),  # height and width are for the containing div, not the image itself
               imageOutput("cell15",height="100px",width="100px",click="click15",inline=TRUE), # height and width are for the containing div, not the image itself
               imageOutput("cell16",height="100px",width="100px",click="click16",inline=TRUE),  # height and width are for the containing div, not the image itself
               
               imageOutput("cell21",height="100px",width="100px",click="click21",inline=TRUE), # height and width are for the containing div, not the image itself
               imageOutput("cell22",height="100px",width="100px",click="click22",inline=TRUE),  # height and width are for the containing div, not the image itself
               imageOutput("cell23",height="100px",width="100px",click="click23",inline=TRUE), # height and width are for the containing div, not the image itself
               imageOutput("cell24",height="100px",width="100px",click="click24",inline=TRUE),  # height and width are for the containing div, not the image itself
               imageOutput("cell25",height="100px",width="100px",click="click25",inline=TRUE), # height and width are for the containing div, not the image itself
               imageOutput("cell26",height="100px",width="100px",click="click26",inline=TRUE),  # height and width are for the containing div, not the image itself
               
               imageOutput("cell31",height="100px",width="100px",click="click31",inline=TRUE), # height and width are for the containing div, not the image itself
               imageOutput("cell32",height="100px",width="100px",click="click32",inline=TRUE),  # height and width are for the containing div, not the image itself
               imageOutput("cell33",height="100px",width="100px",click="click33",inline=TRUE), # height and width are for the containing div, not the image itself
               imageOutput("cell34",height="100px",width="100px",click="click34",inline=TRUE),  # height and width are for the containing div, not the image itself
               imageOutput("cell35",height="100px",width="100px",click="click35",inline=TRUE), # height and width are for the containing div, not the image itself
               imageOutput("cell36",height="100px",width="100px",click="click36",inline=TRUE),  # height and width are for the containing div, not the image itself
               
               imageOutput("cell41",height="100px",width="100px",click="click41",inline=TRUE), # height and width are for the containing div, not the image itself
               imageOutput("cell42",height="100px",width="100px",click="click42",inline=TRUE),  # height and width are for the containing div, not the image itself
               imageOutput("cell43",height="100px",width="100px",click="click43",inline=TRUE), # height and width are for the containing div, not the image itself
               imageOutput("cell44",height="100px",width="100px",click="click44",inline=TRUE),  # height and width are for the containing div, not the image itself
               imageOutput("cell45",height="100px",width="100px",click="click45",inline=TRUE), # height and width are for the containing div, not the image itself
               imageOutput("cell46",height="100px",width="100px",click="click46",inline=TRUE),  # height and width are for the containing div, not the image itself
               
               imageOutput("cell51",height="100px",width="100px",click="click51",inline=TRUE), # height and width are for the containing div, not the image itself
               imageOutput("cell52",height="100px",width="100px",click="click52",inline=TRUE),  # height and width are for the containing div, not the image itself
               imageOutput("cell53",height="100px",width="100px",click="click53",inline=TRUE), # height and width are for the containing div, not the image itself
               imageOutput("cell54",height="100px",width="100px",click="click54",inline=TRUE),  # height and width are for the containing div, not the image itself
               imageOutput("cell55",height="100px",width="100px",click="click55",inline=TRUE), # height and width are for the containing div, not the image itself
               imageOutput("cell56",height="100px",width="100px",click="click56",inline=TRUE),  # height and width are for the containing div, not the image itself
               
               imageOutput("cell61",height="100px",width="100px",click="click61",inline=TRUE), # height and width are for the containing div, not the image itself
               imageOutput("cell62",height="100px",width="100px",click="click62",inline=TRUE),  # height and width are for the containing div, not the image itself
               imageOutput("cell63",height="100px",width="100px",click="click63",inline=TRUE), # height and width are for the containing div, not the image itself
               imageOutput("cell64",height="100px",width="100px",click="click64",inline=TRUE),  # height and width are for the containing div, not the image itself
               imageOutput("cell65",height="100px",width="100px",click="click65",inline=TRUE), # height and width are for the containing div, not the image itself
               imageOutput("cell66",height="100px",width="100px",click="click66",inline=TRUE),  # height and width are for the containing div, not the image itself
               
               p("Illustration by itim2101 from flaticon.com")
               )
      )
      
    )
  )
)
