#set.seed(123)
library(caret)
library(glmnet)
library(tidyverse)
data(mtcars)
str(mtcars)

mtcars2 <- mtcars |> mutate(
  vs = factor(vs, labels = c("V", "S")),
  am = factor(am, labels = c("automatic", "manual")),
  cyl  = ordered(cyl),
  gear = ordered(gear),
  carb = ordered(carb),
)


# Define o controle de treino
ctrl <- trainControl(method = "cv", number = 5)  # validação cruzada
particao <- createDataPartition(mtcars2$mpg, p = 0.7, list = FALSE)
treino <- mtcars2[particao, ]
teste  <- mtcars2[-particao, ]


ridge_model <- train(
  mpg~ .,
  data = treino,
  method = "glmnet",
  trControl = ctrl,
  tuneGrid = expand.grid(alpha = 0,  # Ridge: alpha = 0
                         lambda = seq(0.001, 50, length = 50))
)

plot(ridge_model)
ridge_model$bestTune
coef(ridge_model$finalModel, s = ridge_model$bestTune$lambda)
modelo_Ridge_ajuste <- ridge_model$finalModel


pred_teste <- predict(ridge_model, teste,s =ridge_model$bestTune$lambda )

# Calcula as métricas de desempenho no teste
metricas_ridge_model <- postResample(pred_teste, teste$mpg)

lasso_model <- train(
  mpg~ .,
  treino,
  method = "glmnet",
  trControl = ctrl,
  tuneGrid = expand.grid(alpha = 1,  # Lasso: alpha = 1
                         lambda = seq(0.001, 2, length = 20))
)

plot(lasso_model)
lasso_model$bestTune
coef(lasso_model$finalModel, s = lasso_model$bestTune$lambda)
lasso_model_ajuste <- lasso_model$finalModel


pred_teste <- predict(lasso_model, teste,s =lasso_model$bestTune$lambda )

# Calcula as métricas de desempenho no teste
metricas_lasso_model <- postResample(pred_teste, teste$mpg)


enet_model <- train(
  mpg~ .,
  treino,
  method = "glmnet",
  trControl = ctrl,
  tuneLength = 10  # Varia alpha e lambda automaticamente
)

plot(enet_model)
enet_model$bestTune
coef(enet_model$finalModel, s = enet_model$bestTune$lambda)
enet_model_ajuste <- enet_model$finalModel


pred_teste <- predict(enet_model, teste,s =enet_model$bestTune$lambda )

# Calcula as métricas de desempenho no teste
metricas_enet_model <- postResample(pred_teste, teste$mpg)



metricas_ridge_model
metricas_lasso_model
metricas_enet_model
