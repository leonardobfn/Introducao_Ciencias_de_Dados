library(ISLR2)
library(keras)

Gitters <- na.omit(Hitters)
n <- nrow(Gitters)
set.seed(13)
ntest <- trunc(n / 3)
testid <- sample(1:n, ntest)

model_frame = model.frame(Salary ~.- 1, data = Gitters)
x = (model.matrix(model_frame,data = Gitters))[,1:3]
y <- model.response(model_frame)

model <- keras_model_sequential() %>%
  layer_dense(units = 50,
              activation = "relu",
              input_shape = ncol(x)) %>%
  layer_dense(units = 1)

model %>% 
  compile(loss = "mse",
          optimizer = optimizer_rmsprop()
  )


model %>% fit(
  x[-testid, ], y[-testid], epochs = 10, batch_size = 32)

y_est = predict(model, x[testid, ])
head(y_est)
head(y)
mean((y[testid]-y_est)^2)

