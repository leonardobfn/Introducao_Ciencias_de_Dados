
library(keras)

# Data generation ----------------------------------------------

n <- 1000

x <- matrix(runif(2*n, -1, 1), ncol = 2)
W <- matrix(c(-0.6, 0.7), nrow = 2)
B <- c(0.1)

sigmoid <- function(x) {
  1/(1 + exp(-x))
}

y <- sigmoid(x %*% W + B)
y <- ifelse(y > 0.5, 1, 0)

# Model definition ---------------------------------------------

input <- layer_input(shape = 2)

output <- input %>% 
  layer_dense(units = 1, activation = "sigmoid")

model <- keras_model(input, output)

summary(model)

model %>% 
  compile(
    loss = "binary_crossentropy",
    optimizer = "sgd",
    metrics = metric_binary_accuracy()
  )

# Model fitting ---------------------------------------------------

model %>% 
  fit(
    x = x,
    y = y,
    batch_size = 32, 
    epochs = 20
  )

get_weights(model)
table(
  predict(model, x) > 0.5,
  y
)






