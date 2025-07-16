# ============================================================
# SCRIPT: Regressão Linear Polinomial com e sem Validação Cruzada
# OBJETIVO: Ajustar modelo com caret e avaliar com k-fold CV
# BASE: mtcars
# ============================================================

# Secção 0 - Limpar Ambiente --------------------------------
#rm(list = ls())  # Remove todos os objetos da memória do R

# Secção 1 - Carregar e Inspecionar os Dados ----------------
data(mtcars)     # Base nativa do R com dados sobre veículos

#' Visualizar as primeiras linhas dos dados
head(mtcars)

#' Verificar a estrutura da base (tipos de variáveis)
str(mtcars)

# Secção 2 - Divisão Treino/Teste ---------------------------
set.seed(10)  # Define uma semente para garantir reprodutibilidade

# Selecionar 70% dos dados para treino, mantendo a proporção de 'mpg'
particao <- createDataPartition(mtcars$mpg, p = 0.7, list = FALSE)
treino <- mtcars[particao, ]
teste  <- mtcars[-particao, ]

# Secção 3 - Ajuste Preliminar do Modelo --------------------

#' Ajuste do modelo polinomial (grau 2), apenas no conjunto de treino
#' poly(wt, degree = 2): insere termo quadrático de wt
#' preProcess = c("center", "scale"): centraliza e padroniza as variáveis

# modelo_poly <- train(
#   mpg ~ wt + I(wt^2),
#   data = treino,
#   method = "lm",
#   preProcess = c("center", "scale")
# )

# Secção 4 - Controle da Validação Cruzada ------------------

#' Define uma validação cruzada com 5 subdivisões (folds)

controle_cv <- trainControl(
  method = "cv",   # Método: cross-validation (validação cruzada)
  number = 5,      # Número de folds
  p = 0.7          # OBS: esse argumento é ignorado no método "cv"
)

# Secção 5 - Ajustar Modelo com CV --------------------------
# Ajusta o modelo polinomial novamente, agora com validação cruzada
# Usa a base completa (mtcars) com avaliação por k-fold
modelo_poly <- train(
  mpg ~ wt+I(wt^2), #ou mpg ~ poly(wt,2,raw = T)
  data = mtcars,
  method = "lm",
  trControl = controle_cv
)

# Secção 6 - Avaliar Resultados do Modelo -------------------
# Exibe os resultados médios do modelo ajustado nos 5 folds
# Inclui métricas como RMSE (erro médio quadrático), R², MAE
modelo_poly$results

# Extrai o modelo final ajustado (objeto do tipo lm)
modelo_poly_ajuste <- modelo_poly$finalModel

# Secção 7 - Avaliação no Conjunto de Teste -----------------
# Utiliza o modelo treinado para prever os valores de mpg nos dados de teste
pred_teste <- predict(modelo_poly, newdata = teste)

# Calcula métricas de desempenho da predição:
# RMSE (erro quadrático médio), R² (coef. de determinação), MAE (erro absoluto médio)
metricas <- postResample(pred_teste, teste$mpg)

# Salva essas métricas em um arquivo .txt para consulta posterior
write.table(metricas, "Analises/mtcars/metricas_linear_poly_model.txt")

# Secção 8 - Diagnóstico de Resíduos ------------------------
# Gera os gráficos diagnósticos clássicos para modelos lineares (função plot.lm)
# Inclui: resíduos vs valores ajustados, escala dos resíduos, etc.
x11()
par(mfrow = c(2, 2))
plot(modelo_poly_ajuste)

# Comentário:
# - Se os pontos estão aleatoriamente espalhados ao redor da linha zero, o modelo está adequado.
# - Se formar um desenho (curva, funil, etc.), pode haver problemas no modelo.

# Secção 9 - Histograma dos Resíduos ------------------------
# Exibe a distribuição dos resíduos do modelo final
# Idealmente deve ser aproximadamente simétrica (forma de sino)
hist(modelo_poly_ajuste$residuals,
     main = "Distribuição dos erros (resíduos)",
     xlab = "Resíduo", col = "skyblue", border = "white")
