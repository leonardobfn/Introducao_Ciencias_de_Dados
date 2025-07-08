# Extração de métricas principais

resultados.modelo.linear = read.table("Analises/mtcars/metricas_linear_model.txt")
resultados.modelo.poly = read.table("Analises/mtcars/metricas_linear_poly_model.txt")


data.frame(
  Modelo = c("Linear", "Polinomial"),
  RMSE = c(resultados.modelo.linear["RMSE",], resultados.modelo.poly["RMSE",]),
  Rsquared = c(resultados.modelo.linear["Rsquared",], resultados.modelo.poly["Rsquared",]),
  MAE = c(resultados.modelo.linear["MAE",], resultados.modelo.poly["MAE",])
) |> print()

