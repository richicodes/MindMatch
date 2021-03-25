# MindMatch
R picture matching game with quiz about mental health

## server.R
Carry out all the reactive functions

## ui.R
Stores the most of the UI related stuff

## questions.R
Functions related to retrieval of questiions and answers
### questionRetrieve(answered_question)
Function will retrieve question and answers not listed in the game, and also returns updated list of answered quesrtions
#### input:
answered_question contains list of questionIDs already displayed in the game.
#### output:
list(questionID, question, scrambled_options, correct_option_index, answered_question_updated)

## cardmatrix.R
Functions relating to comparing, generating and updating card matrix
Exact data form of cardmatrix TBC, but will contain 36 cells with information like 
- row and column of card
- type of card (related to picture file name and whether if its action card)
- opened/close
### generateMatrix()
Generates 6 * 6 matrix of all closed cards
#### input: 
None
#### output:
cardmatrix
### checkCard(cardmatrix, card1, card2)
checks if card1 and card2 are the same, and spits out decision and updated matrix
#### input:
cardmatrix: current card matrix
card1: first chosen card
card2: second chosen card
#### output:
list(verdict, updated_cardmatrix)
verdict: True/False of whether cards are the same
action: True/False if card is action card. (if not matching then NULL? TBC)
updated_cardmatrix: changes chosen cards to open if they are the same