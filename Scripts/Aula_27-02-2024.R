


# Exemplo com a função optim
f = function(x) {
  fx = x ^ 2 + 2 * x - 3
}
x = seq(-10, 10)
fx = f(x)
plot(x, fx)
x[which.min(fx)]
optim(
  fn = f,
  par = 0,
  method = "Brent",
  lower = -10,
  upper = 10
)

# Regressao
require(tidyverse)
n = 1000
b0 = 2
b1 = .6
# resposta simulada
dados = tibble(x1 = rnorm(n, 3, 1),
               y = b0 + b1 * x1 + rnorm(n))
dados

dados_mf = model.frame(y ~ x1, data = dados) # colocar no formato mf
X = model.matrix(dados_mf, data = dados) # matriz X regressoras
Y = model.response(dados_mf) # resposta

fx = function(b0_b1, X_matriz, Y_matriz) {
  beta_vetor = b0_b1
  XB = X %*% beta_vetor
  erro = t(Y - XB) %*% (Y - XB)
  sum_erro = sum(erro)
  return(sum_erro)
}


par_est = optim(
  par = c(1, 1),
  fn = fx,
  Y_matriz = Y,
  X_matriz = X
)
par_est$par
beta_est = par_est$par
y_est = X %*% beta_est
(mse = mean((y - y_est) ^ 2))
resid = (y - y_est)
