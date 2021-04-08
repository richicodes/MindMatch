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

generateMatrix <- function(){
  cardBoard <- sample(list.files(path = "www/patterns/", pattern = "png$"), 18)
  cardBoard <- sample(rep(cardBoard, 2))
  # print(cardBoard)
  
  # trying to create a for loop but not too sure how
  # matrix <- for (i in 1:6) {
  #   for (j in 1:6) {
  #     list(
  #       i = list(
  #         j = list("img" = cardBoard[(i-1)*6 + j], "act" = FALSE, "open" = FALSE)
  #       )
  #     )
  #   }
  # }
  # print(matrix)
  
  return(
    
    list(
         '1' = list(
           '1' = list("img" = cardBoard[1], "act" = TRUE, "open" = FALSE),
           '2' = list("img" = cardBoard[2], "act" = TRUE, "open" = FALSE),
           '3' = list("img" = cardBoard[3], "act" = TRUE, "open" = FALSE),
           '4' = list("img" = cardBoard[4], "act" = TRUE, "open" = FALSE),
           '5' = list("img" = cardBoard[5], "act" = TRUE, "open" = FALSE),
           '6' = list("img" = cardBoard[6], "act" = TRUE, "open" = FALSE)
        ),
         '2' = list(
           '1' = list("img" = cardBoard[7], "act" = TRUE, "open" = FALSE),
           '2' = list("img" = cardBoard[8], "act" = TRUE, "open" = FALSE),
           '3' = list("img" = cardBoard[9], "act" = FALSE, "open" = FALSE),
           '4' = list("img" = cardBoard[10], "act" = FALSE, "open" = FALSE),
           '5' = list("img" = cardBoard[11], "act" = FALSE, "open" = FALSE),
           '6' = list("img" = cardBoard[12], "act" = FALSE, "open" = FALSE)
         ),
         '3' = list(
           '1' = list("img" = cardBoard[13], "act" = FALSE, "open" = FALSE),
           '2' = list("img" = cardBoard[14], "act" = FALSE, "open" = FALSE),
           '3' = list("img" = cardBoard[15], "act" = FALSE, "open" = FALSE),
           '4' = list("img" = cardBoard[16], "act" = FALSE, "open" = FALSE),
           '5' = list("img" = cardBoard[17], "act" = FALSE, "open" = FALSE),
           '6' = list("img" = cardBoard[18], "act" = FALSE, "open" = FALSE)
         ),
         '4' = list(
           '1' = list("img" = cardBoard[19], "act" = FALSE, "open" = FALSE),
           '2' = list("img" = cardBoard[20], "act" = FALSE, "open" = FALSE),
           '3' = list("img" = cardBoard[21], "act" = FALSE, "open" = FALSE),
           '4' = list("img" = cardBoard[22], "act" = FALSE, "open" = FALSE),
           '5' = list("img" = cardBoard[23], "act" = FALSE, "open" = FALSE),
           '6' = list("img" = cardBoard[24], "act" = FALSE, "open" = FALSE)
         ),
         '5' = list(
           '1' = list("img" = cardBoard[25], "act" = FALSE, "open" = FALSE),
           '2' = list("img" = cardBoard[26], "act" = FALSE, "open" = FALSE),
           '3' = list("img" = cardBoard[27], "act" = FALSE, "open" = FALSE),
           '4' = list("img" = cardBoard[28], "act" = FALSE, "open" = FALSE),
           '5' = list("img" = cardBoard[29], "act" = FALSE, "open" = FALSE),
           '6' = list("img" = cardBoard[30], "act" = FALSE, "open" = FALSE)
         ),
         '6' = list(
           '1' = list("img" = cardBoard[31], "act" = FALSE, "open" = FALSE),
           '2' = list("img" = cardBoard[32], "act" = FALSE, "open" = FALSE),
           '3' = list("img" = cardBoard[33], "act" = FALSE, "open" = FALSE),
           '4' = list("img" = cardBoard[34], "act" = FALSE, "open" = FALSE),
           '5' = list("img" = cardBoard[35], "act" = FALSE, "open" = FALSE),
           '6' = list("img" = cardBoard[36], "act" = FALSE, "open" = FALSE)
         )
         )
    )
}

checkCard <- function(cardmatrix, card1, card2){ 
  # print(ls(card1))
  row1 <- card1[["row"]]
  col1 <- card1[["col"]]
  row2 <- card2[["row"]]
  col2 <- card2[["col"]]
  # print(paste(row1, col1, row2, col2, sep=" "))
#card1, card2 entered same fashion as 
#gameVal$firstCard, e.g. list("row" = "1", "col" = "2")
  
  output = cardmatrix
  output[[row1]][[col1]][["open"]]  <-  TRUE
  output[[row2]][[col2]][["open"]]  <-  TRUE
  
  # to obtain the file name of the image
  img1 <- output[[row1]][[col1]][["img"]]
  img2 <- output[[row2]][[col2]][["img"]]
  # print(paste(img1, img2, sep=" "))
  
  # if both are action cards, (act1 & act2) will return TRUE
  act1 <- output[[row1]][[col1]][["act"]]
  act2 <- output[[row2]][[col2]][["act"]]
  
  if (identical(img1, img2)) {
    return(list ("check" = TRUE, 
                 "action" = act1 & act2,
                 "cardMatrix" = output))
  } else {
    return(list ("check" = FALSE, "cardMatrix" = output))
  }

  
  
}



a <- FALSE
b <- FALSE
a & b




























