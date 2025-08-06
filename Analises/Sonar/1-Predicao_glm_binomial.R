# Carregar pacotes
library(caret)
library(mlbench)
rm(list=ls())
# Carregar dados
data(Sonar)
str(Sonar)
dim(Sonar)



# A variável alvo (classe) é a última coluna
table(Sonar$Class)  # Verificar balanceamento

# Divisão treino/teste
set.seed(123)
particao <- createDataPartition(Sonar$Class, p = 0.8, list = FALSE)
treino <- Sonar[particao, ]
teste <- Sonar[-particao, ]

# Verificar se ficou balanceado no treino
prop.table(table(treino$Class))

# Treinar modelo com cross-validation
ctrl <- trainControl(method = "cv", number = 10)

# Modelo: Random Forest
modelo_log <- train(
  Class ~ ., 
  data = treino,
  method = "glm",
  family = binomial(link=logit), # ou "binomial" 
  trControl = ctrl
)


# Avaliação no conjunto de teste
predicoes_prob <- predict(modelo_log, newdata = teste,type = "prob")
predicoes_class <- predict(modelo_log, newdata = teste,type = "raw")
confusionMatrix(predicoes_class, teste$Class)


# Trocando o ponto de corte
library(pROC)


# Obter probabilidades para a classe 


probs_treino <- predict(modelo_log, type = "prob")

# Calcular curva ROC
roc_obj <- roc(treino$Class,probs_treino$M)

# Exibir AUC
auc(roc_obj)

# Melhor ponto de corte segundo critério "Youden" (max sens + esp - 1)
coords(roc_obj, "best", ret = c("threshold", "sensitivity", "specificity"))


# Obter threshold ótimo
melhor_corte <- coords(roc_obj, "best", ret = "threshold") |> c()

# Classificar com novo corte

probs <- predict(modelo_log, newdata = teste, type = "prob")
pred_ajustada <- ifelse(probs$M > melhor_corte, "M", "R")
pred_ajustada <- factor(pred_ajustada, levels = c("M", "R"))

# Avaliar com matriz de confusão
confusionMatrix(pred_ajustada, teste$Class)


