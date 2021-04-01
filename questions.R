# ## questions.R
# Functions related to retrieval of questiions and answers
# ### questionRetrieve(answered_questions)
# Function will retrieve question and answers not listed in the game, and also returns updated list of answered quesrtions
# #### input:
# answered_question contains list of questionIDs already displayed in the game.
# #### output:
# list(questionID, question, options, correct_option_index, answered_questions_updated)

DRAFTquestionRetrieve <- function(answered_questions){
  return(
    list(
      "questionID" = 1,
      "question" = "TEST QUESTION",
      "options" = c("option1", "option2", "option3", "option4"),
      "correct_option_index" = 1, #if option 1 is correct, etc
      "answered_questions_updated" = c(1, 2, 3, 4, 5) #updated list of answered questions
    )
  )
}