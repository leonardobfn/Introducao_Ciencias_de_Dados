require(tidyverse)
require(keras)

# Exemplo 1 ---------------------------------------------------------------


w10= 0.90
w11= 0.20
n = 1000
X = matrix(runif(n))

g = function(z){ # função de ativação
ifelse(z > 0, z, 0) # relu  
}


y <- g(w10+w11*X) # dados simulados

model = keras_model_sequential() %>%
  layer_dense(
    units = 1, #quantidade de neurônios
    use_bias = T,
    input_shape = 1, # quantidade de colunas de X
    activation = "relu"
  )


#' Forma alternativa

# input <- layer_input(shape = 1)
# output <- input %>%
#   layer_dense(units = 1,use_bias = T,activation = "relu") %>%
# model <- keras_model(input, output)

summary(model) 

model %>% 
  compile(
    loss = "mse",
    optimizer = optimizer_sgd(learning_rate = 0.01)
  )


model %>% 
  fit(X, y, batch_size = 10, epochs = 50)

get_weights(model)
y_est = predict(model, X)
plot(y,y_est)
hist(y-y_est)
# Exemplo 2 -----------------------------------------------------------------


w10= 0.90 # vies
w11= 0.20
w12 = 0.35

w = matrix(c(w11,w12),byrow = T)
n = 1000
X = replicate(2,runif(n))

g = function(z){ # função de ativação
  ifelse(z > 0, z, 0) # relu  
}


y <- g(w10+X%*%w) # dados simulados

model = keras_model_sequential() %>%
  layer_dense(
    units = 1, #quantidade de neurônios
    use_bias = T,
    input_shape = 2, # quantidade de colunas de X
    #activation = "relu"
  )


summary(model) 

model %>% 
  compile(
    loss = "mse",
    optimizer = optimizer_sgd(learning_rate = 0.01)
  )


model %>% 
  fit(X, y, batch_size = 10, epochs = 50)

get_weights(model)
y_est = predict(model, X)
plot(y_est,y)

# Exemplo 4-----------------------------------------------------------------

# pesos do primeiro neurônio

w10= -2 # vies
w11= 3
w12 = 1
w13 = 5
w14 = -4

# pesos do segundo neurônio
w20 = -2 # vies
w21 = -1.5 
w22 = -3 
w23 = 7.1 
w24 = 0.07

# pesos do terceiro neurônio
w30 = -2 # vies
w31 = 2 
w32 = 1
w33 = -6 
w34 = 2.9 

# guardando os pesos de cada neurônio em cada coluna (t())
w = matrix(c(w11,w12,w13,w14, 
             w21,w22,w23,w24,
             w31,w32,w33,w34),ncol=4,nrow = 3,byrow = T) %>%
  t()
vies_w = c(w10,w20,w30)

betas = matrix(c(-2,5,1),nrow = 3)
vies_betas = 0.6
n = 1
X = matrix(c(0.5,2.8,0,-.1),ncol=4) # p = 4  e n=1

g = function(z){
 exp(z)/(1+exp(z)) #sigmoid
 #ifelse(z > 0, z, 0) # relu  
}


y <- g(vies_w+X%*%w)%*%(betas)+vies_betas # dados simulados
y = g(y)

model = keras_model_sequential() %>%
  layer_dense(
    units = 3, #quantidade de neurônios
    use_bias = T,
    input_shape = 4, # quantidade de colunas de X
    activation = "relu"
  ) %>%
  layer_dense(
    units = 1, #quantidade de neurônios
    activation = "sigmoid"
  )
summary(model)  


#' Forma alternativa

# input <- layer_input(shape = 4)
# output <- input %>%
#   layer_dense(units = 3,
#               use_bias = T,
#               activation = "relu") %>%
#   layer_dense(units = 1,
#               use_bias = T,
#               activation = "sigmoid")
# 
# model <- keras_model(input, output)

summary(model) 

model %>% 
  compile(
    loss = "mse",
    optimizer = optimizer_sgd(learning_rate = 0.01)
  )


model %>% 
  fit(X, y, batch_size = 20, epochs = 80)

get_weights(model)
y_est = predict(model, X)
y_est
plot(y_est,y)


# Exemplo 5-----------------------------------------------------------------

# pesos do primeiro neurônio

w10= -2 # vies
w11= 3
w12 = 1
w13 = 5
w14 = -4

# pesos do segundo neurônio
w20 = -2 # vies
w21 = -1.5 
w22 = -3 
w23 = 7.1 
w24 = 0.07

# pesos do terceiro neurônio
w30 = -2 # vies
w31 = 2 
w32 = 1
w33 = -6 
w34 = 2.9 

# guardando os pesos de cada neurônio em cada coluna (t())
w = matrix(c(w11,w12,w13,w14, 
             w21,w22,w23,w24,
             w31,w32,w33,w34),ncol=4,nrow = 3,byrow = T) %>%
  t()
vies_w = c(w10,w20,w30)

betas = matrix(c(-2,5,1),nrow = 3)
vies_betas = 0.6
n = 1
X = matrix(c(0.5,2.8,0,-.1),ncol=4) # p = 4  e n=1

g = function(z){
  exp(z)/(1+exp(z)) #sigmoid
  #ifelse(z > 0, z, 0) # relu  
}


y <- g(vies_w+X%*%w)%*%(betas)+vies_betas # dados simulados
y = g(y)

model = keras_model_sequential() %>%
  layer_dense(
    units = 3,#quantidade de neurônios
    use_bias = T,
    input_shape = 4,# quantidade de colunas de X
    activation = "relu"
  ) %>%
  layer_dense(units = 3, #quantidade de neurônios
              use_bias = T,
              activation = "relu") %>%
  layer_dense(units = 1,#quantidade de neurônios
              activation = "sigmoid" 
  ) # camada: output ( Y)
summary(model)  

model %>% 
  compile(
    loss = "mse",
    optimizer = optimizer_sgd(learning_rate = 0.01)
  )


model %>% 
  fit(X, y, batch_size = 20, epochs = 80)

get_weights(model)
y_est = predict(model, X)
y_est

