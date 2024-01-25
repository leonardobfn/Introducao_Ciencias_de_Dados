


# Questão 1 ---------------------------------------------------------------

#' Considere a lista abaixo
#' Use map para contar quantos caracteres tem cada palavra
palavras <- list("gato", "cachorro", "elefante", "leão")


# Questão 2 ---------------------------------------------------------------

#' Crie um json com as seguintes variáveis: produto,preço e vencimento
#' Considere 3 produtos
#' Selecione o segundo argumento


# Questão 3 ---------------------------------------------------------------
#' O código a seguir simula o desempenho de um teste t para dados normais. 
#' Repita o teste N vezes usando map
#' Extraia o valor p de cada teste.
t.test( rnorm(100, 10), rnorm(90, 10) )


# Questão 4 ---------------------------------------------------------------
#' Reproduza o exemplo abaixo usando snowfall
n = 200
x = rnorm(n,1.80,4) # covariável
a = 2
b = 1
y  = a + b*x + rnorm(n,0,1) # resposta simulada
plot(x,y)
dados = data.frame(y,x)
rs = lm(y~x,data = dados) # aplicando modelo de regressão

B = 100 # quantidade de repetições
results = matrix(0,B,2)
for(i in 1:B){
  id_B = sample(1:n,n,replace = T)
  dados_B = dados[id_B,]
  rs_b = lm(y~x,data = dados_B)
  COEF = coef(rs_b)
  results[i,] = COEF
}

hist(results[,1])
hist(results[,2])
colMeans(results)


# Questão 5 ---------------------------------------------------------------

#' Elabore um exemplo para usar a função map2 ou pmap
