
rm(list=ls())

# Carregar base de dados -------
data(mtcars)

# Olhar os primeiros dados -------
head(mtcars)
str(mtcars)


# Ajuste ------------------------------------------------------------------


#' Regressão linear simples: mpg (consumo) ~ wt (peso do carro)
#' Como o peso do carro (wt) afeta o consumo de combustível (mpg) em milhas por galão?
modelo <- lm(mpg ~ wt, data = mtcars)

#' Ver resumo do modelo
modelo


# Gráfico da regressão --------------------------

#' Gráfico de dispersão com a reta de regressão
plot(mtcars$wt, mtcars$mpg,
     main = "Peso do carro vs Consumo (mpg)",
     xlab = "Peso (mil libras)", ylab = "Consumo (mpg)",
     pch = 19, col = "darkblue",ylim=c(8,35))

#' Adiciona a reta do modelo
abline(modelo, col = "red", lwd = 2)

pred <- predict(modelo) #ou modelo$fitted.values
segments(mtcars$wt, mtcars$mpg, mtcars$wt, pred, col = "gray")

#' Essas linhas mostram o "erro" da previsão (resíduo)

pred_mean_wt <- predict(modelo,newdata = data.frame(wt=mean(mtcars$wt)))
predict(modelo,newdata = data.frame(wt=2.5))

#' Gráfico dos resíduos # --------------------------

res = residuals(modelo) # ou modelo$residuals

#' Gráfico de resíduos vs valores ajustados
par(mfrow=c(1,2))

plot(modelo$fitted.values, modelo$residuals,
     main = "Erros (resíduos) vs Previsões",
     xlab = "Valor previsto (mpg)", ylab = "Erro da previsão (resíduo)",
     pch = 19, col = "darkgreen")
abline(h = 0, col = "red", lty = 2)

# Gráfico de wt vs valores ajustados
plot(mtcars$wt, modelo$residuals,
     main = "Erros (resíduos) vs Previsões",
     xlab = "(wt)", ylab = "Erro da previsão (resíduo)",
     pch = 19, col = "darkgreen")
abline(h = 0, col = "red", lty = 2)


par(mfrow=c(2,2))
plot(modelo)


#' Comentário: 
#' Se os pontos estão aleatoriamente espalhados ao redor da linha zero, o modelo está ok.
#' Se formar desenho (curva, funil, etc.), o modelo pode estar com problemas.

# 3. Histograma dos resíduos --------------------------

hist(modelo$residuals,
     main = "Distribuição dos erros (resíduos)",
     xlab = "Resíduo", col = "skyblue", border = "white")

# Comentário:
# Resíduos simétricos em torno de zero (parecendo uma curva de sino) são desejáveis.



