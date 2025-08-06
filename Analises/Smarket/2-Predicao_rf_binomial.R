# Instale se necessário:
# install.packages("ISLR")
# install.packages("caret")
# install.packages("pROC")
rm(list=ls())
library(ISLR)
library(caret)
library(pROC)

data(Smarket)

# Verificando estrutura
str(Smarket)
dim(Smarket)

# A variável alvo (classe) é a última coluna
table(Smarket$Direction) |> prop.table()  # Verificar balanceamento

# Divisão treino/teste: treino até 2004, teste em 2005
set.seed(123)
treino <- subset(Smarket, Year < 2005)
teste <- subset(Smarket, Year == 2005)

# Verificar balanceamento no treino
prop.table(table(treino$Direction))

# Controle para treino com timeslice (séries temporais)
ctrl <- trainControl(
  method = "timeslice", 
  initialWindow =  200,
  horizon = 12,     
  fixedWindow = TRUE ,
  verboseIter = TRUE,
  classProbs = TRUE # para a curva roc
)

# Tuning para Random Forest
# Parâmetro principal: mtry = número de variáveis testadas em cada split
# Geralmente, mtry varia entre sqrt(n_features) e n_features/2
# Para 5 features, testamos mtry de 2 a 5 (exemplo)

set.seed(123)
#tune_grid <- expand.grid(mtry = 2)

modelo_rf <- train(
  Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume,
  data = treino,
  method = "rf",
  #metric = "ROC",  # otimizar AUC no tuning
  #tuneGrid = tune_grid,
  trControl = ctrl
)

print(modelo_rf)
# Visualizar gráfico de desempenho por mtry
plot(modelo_rf)

# Previsão de classe com ponto de corte padrão 0.5
pred_class <- predict(modelo_rf, newdata = teste, type = "raw")

# Previsão de probabilidades
pred_prob <- predict(modelo_rf, newdata = teste, type = "prob")

# Matriz de confusão com corte 0.5
confusionMatrix(pred_class, teste$Direction)

# Calcular curva ROC no treino para encontrar melhor ponto de corte
probs_treino <- predict(modelo_rf, newdata = treino, type = "prob")
roc_obj <- roc(response = treino$Direction, predictor = probs_treino$Up)

# AUC
auc(roc_obj)

# Melhor ponto de corte segundo critério Youden
melhor_corte <- coords(roc_obj, "best", ret = "threshold")

# Classificar teste usando corte otimizado
pred_ajustada <- ifelse(pred_prob$Up > melhor_corte$threshold, "Up", "Down")
pred_ajustada <- factor(pred_ajustada, levels = c("Down", "Up"))

# Matriz de confusão com corte ajustado
M = confusionMatrix(pred_ajustada, teste$Direction)
M$byClass

