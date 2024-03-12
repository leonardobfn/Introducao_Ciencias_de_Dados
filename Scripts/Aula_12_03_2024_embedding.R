library(keras)
rm(list=ls())
layer.vectorization <- 
  layer_text_vectorization(
    max_tokens = 10,
    output_mode = "int"
  )

frases <- c("eu gosto de gatos",
            "eu gosto de cachorros",
            "eu gosto de gatos e cachorros")

#' adaptando os dados
#' mapping between string tokens and integer indices

adapt(layer.vectorization,frases)

layer.vectorization(matrix(frases, ncol = 1))

vocab <- get_vocabulary(layer.vectorization) # lista de vocabulários

input <- layer_input(shape = 1, dtype = "string")

output <- input %>%
  layer.vectorization() %>%
  layer_embedding(input_dim = length(vocab), output_dim = 2)# constroi a matriz de pesos ; output_dim quantidades de pesos

model <- keras_model(input, output)
#' quantidade de parâmetros = length(vocab)* output_dim
out <- predict(model, matrix(frases, ncol = 1))


dim(out)
out[1, , ]
vocab.pesos = get_weights(model)[[2]]
rownames(vocab.pesos) = vocab
out[1,,]
