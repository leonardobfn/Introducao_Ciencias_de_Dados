

require(keras)
require(tidyverse)
require(caret)
rm(list=ls())
dados = iris
head(dados)

table(dados$Species) # balanceado
id.treino = createDataPartition(dados$Species,p=0.6, list=F) 

mf = model.frame(Species~.-1,data = dados)
X.original = model.matrix(mf,data=dados)
X = scale(X.original)
y.bruto = model.response(mf)
yn = y.bruto %>% as.numeric() - 1
y = to_categorical(yn)

model = keras_model_sequential() %>%
  layer_dense(
    input_shape = ncol(X),
    units = 12,
    use_bias = T
  ) %>%
  layer_dense(
    units = ncol(y),
    use_bias = T,
    activation = "softmax"
  )

model %>% compile(optimizer = "adam", 
                  loss = "categorical_crossentropy",
                  metrics = "accuracy")


model %>% fit(X[id.treino,],y = y[id.treino,],batch_size = 30,epochs = 100)

prob.pred = predict(model,X[-id.treino,])

cbind(prob.pred,y[-id.treino,])

y.pred = model %>% predict(X[-id.treino,]) %>% k_argmax() %>%
  as.array(pre) 

(tab = table(
  Pred = y.pred,
  Obs = yn[-id.treino]
))
sum(diag(tab))/sum(tab)
caret::confusionMatrix(tab,mode = "everything")

require(nnet)

dados.mul = cbind(yn = as.factor(yn),X) %>% data.frame()

model.mul = nnet::multinom(yn ~ .,data = dados.mul[id.treino,])
ClassPredicted <- predict(model.mul,
                          newdata = dados.mul[-id.treino,], 
                          type = "class")

# Building classification table
tab2 <- table(Pred = ClassPredicted, Obs = dados.mul$yn[-id.treino])

# Calculating accuracy - sum of diagonal elements divided by total obs
caret::confusionMatrix(tab2,mode = "everything")
