#' Essa base de dados é melhor ajustada quando considerada a correlação temporal.
#' Aqui será utilizada sem considerar a correlação temporal, apenas um
#' exemplo de como utilizar deep learning.
#' Trabalhando com duas categorias. 1 se umidade >= 0.70 e 0 cc 

require(tidyverse)
require(keras)
library(caret)
rm(list=ls())
dados_brutos = readRDS("dados/am_dados_meteorologicos/dados_meteorologicos_am.rds")
head(dados_brutos)

dados  =  dados_brutos %>% select("rh","tbs","precp")
dados$rh = ifelse(dados$rh>=0.70,1,0)
head(dados)
(tab = table(dados$rh)) # desbalanceado 
(tab.prop = prop.table(tab))
id.treino <- createDataPartition(dados$rh, p=0.7, list=F) # 70% dos dados para treinamento
dados$rh[id.treino] %>% table() %>% prop.table()

mf = model.frame(rh~.-1,data = dados)
y = model.response(mf)
X.original = model.matrix(mf,data=dados) 
X = scale(model.matrix(mf,data=dados)) # normalizando


model = keras::keras_model_sequential() %>%
  keras::layer_dense(50, use_bias = T, input_shape = ncol(X)) %>%
  keras::layer_dense(1, use_bias = T) %>%
  keras::layer_dense(1, use_bias = T, activation = "sigmoid")

model %>%
  compile(loss = "binary_crossentropy", 
          optimizer = "sgd",
          metrics = list(metric_recall(),metric_precision(),metric_binary_accuracy())
          )


model %>%
  fit(x=X[id.treino,],y = y[id.treino],batch_size = 20,epochs = 100)

prob_est = predict(model,X[-id.treino,])
mc = table(prob_est>0.5,y[-id.treino],dnn = c("Pred","Obs")) # matriz de confusão
rownames(mc) = c("0","1")

caret::confusionMatrix(mc,mode = "everything",positive = "1")
(ac = sum(diag(mc))/sum(mc))
(pr = 398/(398+98))
(rc = 398/(398+36))
(f1 = 2*pr*rc/(pr+rc))

# Usando glm

dados.glm = cbind(X,y) %>% as.data.frame()
model_2 <- glm(y ~ ., family = "binomial",data=dados.glm[id.treino,])
prob_est.2 = predict(model_2, dados.glm[-id.treino,], type = "response")
mc2 = table(prob_est.2>0.5,y[-id.treino],dnn = c("Pred","Obs")) # matriz de confusão
rownames(mc2) = c("0","1")
caret::confusionMatrix(mc2,mode = "everything",positive = "1")



