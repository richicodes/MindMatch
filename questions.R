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

sqlQuery <- function (query) {
  # creating DB connection object with RMysql package
  query = "SELECT * FROM RandomQuestion"
  DB <- dbConnect(
    drv = RMySQL::MySQL(),
    dbname = "student071",
    host = "esddbinstance-1.ceo4ehzjeeg0.ap-southeast-1.rds.amazonaws.com",
    username = "student071",
    password = "YttS3FxB")
    # close db connection after function call exits
  on.exit(dbDisconnect(DB))
    # send Query to obtain result set
  rs <- dbSendQuery(DB, query)
    # get elements from result sets and convert to dataframe
  result <- fetch(rs, -1)
  killDbConnections <- function () {
    all_cons <- dbListConnections(MySQL())
    print(all_cons)
    for(con in all_cons)
      +  dbDisconnect(con)
    print(paste(length(all_cons), " connections killed."))
  }
  # return the dataframe
  return(result)
}

questionRetrieve <- function(answered_questiCons){
  #open the connection
  question =sample(1:35,1, replace=FALSE)
  data<- sqlQuery("SELECT * FROM RandomQuestion")
    return(
      list(
      "questionID" = question ,
      "question" = data["question"],
      "options" =c(data[["a"]],data[["b"]],data[["c"]],data[["d"]]),
      required = TRUE, # must select one option
      "correct_option_index" = data["correct_option_index"] #if option 1 is correct, etc
     # "answered_questions_updated" = c((data["questionID"])) #updated list of answered questions
      ))
    #Close the connection
  dbDisconnect(data)
}



