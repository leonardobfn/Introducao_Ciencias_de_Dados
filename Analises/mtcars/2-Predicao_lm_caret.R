# ============================================================
# SCRIPT: Regressão Linear Simples com e sem Validação Cruzada
# OBJETIVO: Ajustar modelo linear com caret, avaliar em teste e CV
# BASE: mtcars
# ============================================================

# Secção 0 - Limpar Ambiente --------------------------------
#rm(list = ls())  # Remove todos os objetos da memória

# Secção 1 - Carregar e Inspecionar os Dados ----------------
data(mtcars)     # Base nativa do R com dados de carros

# Visualizar as primeiras observações
head(mtcars)

# Ver estrutura das variáveis da base
str(mtcars)

# Secção 2 - Divisão em Conjuntos Treino e Teste ------------
set.seed(10)  # Garante reprodutibilidade da partição

# Seleciona 70% dos dados para treino
particao <- createDataPartition(mtcars$mpg, p = 0.7, list = FALSE)
treino <- mtcars[particao, ]
teste  <- mtcars[-particao, ]

# Secção 3 - Ajuste do Modelo Linear (sem CV) ---------------
# Ajuste simples com padronização (scale), apenas no conjunto de treino

# modelo_linear <- train(
#   mpg ~ wt,
#   data = treino,
#   method = "lm",
#   preProcess = c("scale")  # Padroniza a variável preditora (wt)
# )

# Secção 4 - Controle da Validação Cruzada ------------------
# Define a validação cruzada k-fold com k = 5
controle_cv <- trainControl(
  method = "cv",
  number = 5,
  p = 0.70 
)

# Secção 5 - Ajuste do Modelo com Validação Cruzada ---------

# Reajusta o modelo linear simples, agora usando validação cruzada
modelo_linear <- train(
  mpg ~ wt,
  data = mtcars,
  method = "lm",
  trControl = controle_cv
)

# Secção 6 - Avaliar Resultados do Modelo -------------------
# Resultados médios da validação cruzada: RMSE, R², MAE
modelo_linear$results
modelo_linear$resample |> dplyr::select(-Resample) |> colMeans()

# Extrai o modelo final ajustado (objeto lm)
modelo_linear_ajuste <- modelo_linear$finalModel

# Secção 7 - Avaliação no Conjunto de Teste -----------------
# Predição nos dados de teste
pred_teste <- predict(modelo_linear, newdata = teste)

# Calcula as métricas de desempenho no teste
metricas <- postResample(pred_teste, teste$mpg)

# Salva as métricas em um arquivo .txt
write.table(metricas, "Analises/mtcars/metricas_linear_model.txt")

# Secção 8 - Diagnóstico dos Resíduos -----------------------
# Gera os gráficos diagnósticos clássicos de regressão linear
par(mfrow = c(2, 2))
plot(modelo_linear_ajuste)

# Comentário:
# - Se os resíduos estiverem aleatórios ao redor da linha 0, o modelo está adequado.
# - Padrões (curvas, funil) indicam possíveis problemas na especificação.

# Secção 9 - Histograma dos Resíduos ------------------------
# Exibe a distribuição dos resíduos do modelo final
hist(modelo_linear_ajuste$residuals,
     main = "Distribuição dos erros (resíduos)",
     xlab = "Resíduo", col = "skyblue", border = "white")
