library(keras)
rm(list=ls())
#' layer_text_vectorization transforma texto em vetor
layer <- layer_text_vectorization(
  max_tokens = 10, # token = palavras
  output_mode = "int") # texto como uma seq de inteiros

frases <- c(
  "eu gosto de gatos",
  "eu gosto de cachorros",
  "eu gosto de gatos e cachorros" # trocar cachorro por passarinhos
)

#' adaptando os dados
#' mapping between string tokens and integer indices

adapt(layer,frases)

layer(matrix(frases, ncol = 1))

(vocab <- get_vocabulary(layer))

frases.2 <- c(
  "eu gosto de gatos",
  "eu gosto de carro",
  "eu gosto de gatos e cachorros" 
)

layer(matrix(frases.2, ncol = 1))
