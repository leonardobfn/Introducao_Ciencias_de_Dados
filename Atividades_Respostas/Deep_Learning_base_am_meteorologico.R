#' Essa base de dados é melhor ajustada quando considerada a correlação temporal.
#' Aqui será utilizada sem considerar a correlação temporal, apenas um
#' exemplo de como utilizar deep learning.

require(tidyverse)
require(keras)
rm(list=ls())
dados_brutos = readRDS("dados/am_dados_meteorologicos/dados_meteorologicos_am.rds")
head(dados_brutos)

dados  =  dados_brutos %>% select("rh","tbs","precp")


mf = model.frame(rh~.-1,data = dados)
y = model.response(mf)
#X = model.matrix(mf,data=dados) 
X = scale(model.matrix(mf,data=dados)) # normalizando
n = nrow(dados)
n_treino = trunc(n*0.30)
id_treino = sample(1:nrow(dados),n_treino,prob = NULL)

model = keras::keras_model_sequential() %>%
  keras::layer_dense(50, use_bias = T, input_shape = ncol(X)) %>%
  keras::layer_dense(1, use_bias = T) %>%
  keras::layer_dense(1, use_bias = T, activation = "sigmoid")

model %>%
  compile(loss = "mse",optimizer = "rmsprop")
  #compile(loss = "mse",optimizer = "sgd")
model %>%
  fit(x=X[id_treino,],y = y[id_treino],batch_size = 20,epochs = 100)

y.est = predict(model,X[-id_treino,]) # fazer a predição com X teste
(MAPE = mean(abs(y[-id_treino]-y.est)/y[-id_treino]))
(MSE = mean((y[-id_treino]-y.est)^2))

resid = y[-id_treino]-y.est
acf(resid) # ainda falta modelar. 

# utilizando a função lm

dados.glm = cbind(X,y) %>% data.frame()

model.lm = lm(y~tbs+precp,data =dados.glm[id_treino,])

y.est.lm = predict(model.lm,dados.glm[-id_treino,] %>% as.data.frame() )
(MAPE = mean(abs(y[-id_treino]-y.est.lm)/y[-id_treino]))
(MSE = mean((y[-id_treino]-y.est.lm)^2))

resid.lm = y[-id_treino]-y.est.lm
acf(resid.lm) # ainda falta modelar. 




