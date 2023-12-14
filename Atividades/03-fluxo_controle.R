# Questão 1 ---------------------------------------------------------------

#' Considere o código abaixo
#' Rode ele 100 vezes
#' Em cada loop, guarde a quantidade de tentativas
#' Dica: crie um vetor vazio para guardar a quantidade de tentativas
#' Dica: crie um contador de tentativas

numero_escolhido <- 6
resultado_dado = 1
while (resultado_dado!=numero_escolhido) {
  resultado_dado = sample(1:6,1,replace = T,prob = NULL) # sorteando número de 1 a 6
  cat("Número do dado é",resultado_dado,"\n")
}


# Questão 2 ---------------------------------------------------------------

#' Gere uma amostra da distribuição normal
#' Considere a média 30 e desvio padrão 5
#' calcule o valor do desvio padrão da amostra
#' calcule o erro abs entre o valor do desvio padrão da amostra e 5
#' Se o erro for menor que 10^(-3), pare
#' Comece com n=2 e incremente 
#' Dica: use repeat


# Questão 3 ---------------------------------------------------------------

#' Gere da distribuição normal com tamanho da amostra n=50 considerando:
#' loop 1:10
#' Se a posição da coluna for par, considere amostra com média 50 e desvio padrão 2 
#' Se a posição da coluna for ímpar, considere amostra com média 10 e desvio padrão 2 


# Questão 4 ---------------------------------------------------------------

#' Gere uma amostra da distribuição normal
#' Considere a média 30 e desvio padrão 5
#' calcule o valor do desvio padrão da amostra
#' calcule a razão entre o valor do desvio padrão da amostra e 5
#' Se a a diferença abs entre a razão obtida e 1 for menor que 10^(-3), pare
#' Comece com n=2 e incremente 
#' Dica: use repeat
