# ## cardmatrix.R
# Functions relating to comparing, generating and updating card matrix
# Exact data form of cardmatrix TBC, but will contain 36 cells with information like 
# - row and column of card
# - type of card (related to picture file name and whether if its action card)
# - opened/close
# ### generateMatrix()
# Generates 6 * 6 matrix of all closed cards
# #### input: 
# None
# #### output:
# cardmatrix
# ### checkCard(cardmatrix, card1, card2)
# checks if card1 and card2 are the same, and spits out decision and updated matrix
# #### input:
# cardmatrix: current card matrix
# card1: first chosen card
# card2: second chosen card
# #### output:
# list(verdict, updated_cardmatrix)
# verdict: True/False of whether cards are the same
# action: True/False if card is action card. (if not matching then NULL? TBC)
# updated_cardmatrix: changes chosen cards to open if they are the same

# Data format:
# return(
#   list(
#     1 = list( #row
#       1 =     #column
#            list("img" = "A.png", "act" = TRUE, "open" = FALSE), #properties
# img: image file, act: TRUE if its action card, open: TRUE if cards are flipped open
# to read or write properties: cardmatrix[[toString(row#)]][[toString(column#)]]["property"]

#these draft functions return a default result
#will be used until actual functions are ready

DRAFTgenerateMatrix <- function(){
  return(
    list(
         '1' = list(
           '1' = list("img" = "A.png", "act" = TRUE, "open" = FALSE),
           '2' = list("img" = "A.png", "act" = TRUE, "open" = FALSE),
           '3' = list("img" = "B.png", "act" = TRUE, "open" = FALSE),
           '4' = list("img" = "B.png", "act" = TRUE, "open" = FALSE),
           '5' = list("img" = "C.png", "act" = TRUE, "open" = FALSE),
           '6' = list("img" = "C.png", "act" = TRUE, "open" = FALSE)
        ),
         '2' = list(
           '1' = list("img" = "D.png", "act" = TRUE, "open" = FALSE),
           '2' = list("img" = "D.png", "act" = TRUE, "open" = FALSE),
           '3' = list("img" = "e.png", "act" = FALSE, "open" = FALSE),
           '4' = list("img" = "e.png", "act" = FALSE, "open" = FALSE),
           '5' = list("img" = "f.png", "act" = FALSE, "open" = FALSE),
           '6' = list("img" = "f.png", "act" = FALSE, "open" = FALSE)
         ),
         '3' = list(
           '1' = list("img" = "g.png", "act" = FALSE, "open" = FALSE),
           '2' = list("img" = "g.png", "act" = FALSE, "open" = FALSE),
           '3' = list("img" = "h.png", "act" = FALSE, "open" = FALSE),
           '4' = list("img" = "h.png", "act" = FALSE, "open" = FALSE),
           '5' = list("img" = "i.png", "act" = FALSE, "open" = FALSE),
           '6' = list("img" = "i.png", "act" = FALSE, "open" = FALSE)
         ),
         '4' = list(
           '1' = list("img" = "j.png", "act" = FALSE, "open" = FALSE),
           '2' = list("img" = "j.png", "act" = FALSE, "open" = FALSE),
           '3' = list("img" = "k.png", "act" = FALSE, "open" = FALSE),
           '4' = list("img" = "k.png", "act" = FALSE, "open" = FALSE),
           '5' = list("img" = "l.png", "act" = FALSE, "open" = FALSE),
           '6' = list("img" = "l.png", "act" = FALSE, "open" = FALSE)
         ),
         '5' = list(
           '1' = list("img" = "m.png", "act" = FALSE, "open" = FALSE),
           '2' = list("img" = "m.png", "act" = FALSE, "open" = FALSE),
           '3' = list("img" = "n.png", "act" = FALSE, "open" = FALSE),
           '4' = list("img" = "n.png", "act" = FALSE, "open" = FALSE),
           '5' = list("img" = "o.png", "act" = FALSE, "open" = FALSE),
           '6' = list("img" = "o.png", "act" = FALSE, "open" = FALSE)
         ),
         '6' = list(
           '1' = list("img" = "p.png", "act" = FALSE, "open" = FALSE),
           '2' = list("img" = "p.png", "act" = FALSE, "open" = FALSE),
           '3' = list("img" = "q.png", "act" = FALSE, "open" = FALSE),
           '4' = list("img" = "q.png", "act" = FALSE, "open" = FALSE),
           '5' = list("img" = "r.png", "act" = FALSE, "open" = FALSE),
           '6' = list("img" = "r.png", "act" = FALSE, "open" = FALSE)
         )
         )
    )
}

DRAFTcheckCard <- function(cardmatrix, card1, card2){ 
#card1, card2 entered same fashion as 
#gameVal$firstCard, e.g. list("row" = "1", "col" = "2")
  output = DRAFTgenerateMatrix()
  output[["1"]][["1"]][["open"]]  <-  TRUE
  output[["1"]][["2"]][["open"]]  <-  TRUE
  return(list ("check" = TRUE,
         "cardMatrix" = output))
}
