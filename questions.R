# ## questions.R
# Functions related to retrieval of questions and answers
# ### questionRetrieve(answered_questions)
# Function will retrieve question and answers not listed in the game, and also returns updated list of answered questions
# #### input:
# answered_question contains list of questionIDs already displayed in the game.
# #### output:
# list(questionID, question, options, correct_option_index, answered_questions_updated)

library(DBI)
library(RSQLite)
library(RMySQL)
library(dbplyr)



getAWSConnection <- function(){
  conn <- dbConnect(
    drv = RMySQL::MySQL(),
    dbname = "student071",
    host = "esddbinstance-1.ceo4ehzjeeg0.ap-southeast-1.rds.amazonaws.com",
    username = "student071",
    password = getOption("AWSPassword"))
  conn
  }

# sqlQuery <- function (query) {
#   # creating DB connection object with RMysql package
#   conn <- getAWSConnection()
#   
#   dbDisconnect(conn)
#   
#   DB <- dbConnect(
#     drv = RMySQL::MySQL(),
#     dbname = "student071",
#     host = "esddbinstance-1.ceo4ehzjeeg0.ap-southeast-1.rds.amazonaws.com",
#     username = "student071",
#     password = getOption("AWSPassword"))
#     # close db connection after function call exits
#   on.exit(dbDisconnect(DB))
#     # send Query to obtain result set
#   rs <- dbSendQuery(DB, query)
#     # get elements from result sets and convert to dataframe
#   result <- fetch(rs, -1)
#   killDbConnections <- function () {
#     all_cons <- dbListConnections(MySQL())
#     print(all_cons)
#     for(con in all_cons)
#       +  dbDisconnect(con)
#     print(paste(length(all_cons), " connections killed."))
#   }
#   # return the dataframe
#   return(result)
# }

getQuestions <- function(){
  #open the connection
  conn <- getAWSConnection()
  query <- "SELECT * FROM GameQuestions"
  result <- dbGetQuery(conn, query)
  dbDisconnect(conn)
  result
}


questionRetrieve <- function(questionsAnswered){
  questionData <- getQuestions()
  allQuestions <- c(1:35)
  
  questionsNotAnswered <- 0
  
  # check if questionsAnswered is null
  if (is.null(questionsAnswered)){
    questionsNotAnswered <- allQuestions
  } else {
    questionsNotAnswered <- allQuestions[-questionsAnswered]
  }
  
  question <- sample(questionsNotAnswered, 1, replace = FALSE)
  
  return(
    list(
    "questionID" = question ,
    "question" = questionData[question,"question"],
    "options" = c(questionData[question, "a"],
                 questionData[question, "b"],
                 questionData[question, "c"], 
                 questionData[question, "d"]),
    required = TRUE, # must select one option
    "correct_option_index" = questionData[question, "correct_option_index"], #if option 1 is correct, etc
    "answered_questions_updated" = c(questionsAnswered, question) #updated list of answered questions
    
    ))

}


