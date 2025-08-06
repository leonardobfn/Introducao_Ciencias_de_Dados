# Instale se necessário:
# install.packages("ISLR")
# install.packages("caret")
rm(list=ls())
library(ISLR)
library(caret)

data(Smarket)

# Verificando estrutura
str(Smarket)
dim(Smarket)

# A variável alvo (classe) é a última coluna
table(Smarket$Direction) |> prop.table()  # Verificar balanceamento

# Divisão treino/teste
set.seed(123)
particao <- subset(Smarket, Year < 2005) |> row_number() |> sort()
treino <- Smarket[particao, ]
teste <- Smarket[-particao, ]

# Verificar se ficou balanceado no treino
prop.table(table(treino$Direction))

ctrl <- trainControl(
  method = "timeslice", 
  initialWindow =  200,
  horizon = 12,     
  fixedWindow = TRUE ,
  verboseIter = TRUE,
  classProbs = TRUE # para a curva roc
)

# ctrl_ts <- trainControl(
#   method = "timeslice",
#   initialWindow = 800,   # primeiros 800 dias para treino
#   horizon = 100,         # 100 dias para teste
#   fixedWindow = TRUE,
#   classProbs = TRUE
#   #summaryFunction = twoClassSummary,
#   #savePredictions = "final"
# )

set.seed(123)
modelo_log <- train(
  Direction ~ Lag1+Lag2+Lag3+Lag4+Lag5+Volume ,
  data = treino,
  method = "glm",
  family = binomial(link = "logit"),
  trControl = ctrl
)


# Prever classe ponto de corte 0.5
pred_class <- predict(modelo_log, newdata = teste,type = "raw")

# Prever probabilidade
pred_prob <- predict(modelo_log, newdata = teste, type = "prob")

# Matriz de confusão
confusionMatrix(pred_class, teste$Direction)


# Trocando o ponto de corte


# Obter probabilidades para a classe "Up"

#probs_treino <- predict(modelo, type = "raw")

probs_treino <- predict(modelo_log, type = "prob")

# Calcular curva ROC
roc_obj <- roc(treino$Direction,probs_treino$Up)

# Exibir AUC
auc(roc_obj)

# Melhor ponto de corte segundo critério "Youden" (max sens + esp - 1)
coords(roc_obj, "best", ret = c("threshold", "sensitivity", "specificity"))


# Obter threshold ótimo
melhor_corte <- coords(roc_obj, "best", ret = "threshold") |> c()

# Classificar com novo corte

probs <- predict(modelo_log, newdata = teste, type = "prob")
pred_ajustada <- ifelse(probs$Up > melhor_corte, "Up", "Down")
pred_ajustada <- factor(pred_ajustada, levels = c("Down", "Up"))

# Avaliar com matriz de confusão
confusionMatrix(pred_ajustada, teste$Direction)












