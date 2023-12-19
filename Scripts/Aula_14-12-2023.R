## .watch-out {
##   border: 3px solid gray;
##   font-weight: bold;
## }
## 

## ----setup, include = FALSE-----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment  = "#>",
  class.source = "watch-out",
  fig.height = 3, 
  fig.width = 3, 
  fig.align = "center"
)


## ----eval=F---------------------------------------------------------------------------
## if (condition) true_action


## ----eval=F---------------------------------------------------------------------------
## if (condition) true_action else false_action


## -------------------------------------------------------------------------------------
x = "Leonardo"
if(class(x)=="character"){
  cat(" O objeto x=",x,"é da classe character",sep=" ")
}


## -------------------------------------------------------------------------------------
x = 1

if(class(x)=="character"){
  paste(" O objeto x=",x,"é da classe character",sep=" ")
} else{
  paste(" O objeto x=",x,"não é da classe character",sep=" ")
}


## -------------------------------------------------------------------------------------
x = 70
 if (x >= 90 & x <= 100) {
    "A"
  } else if (x >= 80 & x < 90) {
    "B"
  } else {
    "C"
  }


## -------------------------------------------------------------------------------------
x = 80
 if (x >= 100 | x <= 70) {
    "Extremo"
  } else {
    "Não é extremo"
  } 


## -------------------------------------------------------------------------------------
x = 1:10
ifelse(x %% 2 == 0, "par", "ímpar")


## ----eval=F---------------------------------------------------------------------------
## for (variavel in sequencia) {
##   # código a ser executado em cada iteração
## }


## -------------------------------------------------------------------------------------
for (i in 1:5) {
  quadrado <- i^2
  cat("O quadrado de", i, "é", quadrado, "\n")
}


## -------------------------------------------------------------------------------------
soma <- 0
for (i in 1:10) {
  soma <- soma + i
}
cat("A soma dos primeiros 10 números naturais é:", soma, "\n")

cumsum(1:10) # forma alternativa


## -------------------------------------------------------------------------------------
n = 10 # linhas
m=3 # colunas
matrix_normal = matrix(0,nrow = n,ncol = m) # criando a matriz

set.seed(8) # gerar sempre as mesmas amostras
for(k in 1:m){
  x = rnorm(n,mean = 0,sd = 1) # gerando amostra da distribuição normal
  matrix_normal[,k] <- x # guardando a amostra gerada na coluna
}
matrix_normal

# forma alternativa
set.seed(2)
replicate(m,rnorm(n,mean = 0,sd = 1))


## -------------------------------------------------------------------------------------
# Criar uma matriz 3x3
matriz <- matrix(0, nrow = 3, ncol = 3)

# Preencher a matriz com números sequenciais usando um loop for
contador <- 1

for (i in 1:3) {
  for (j in 1:3) { # fixa o i e varia o j
    matriz[i, j] <- contador 
    contador <- contador + 1
  }
}

print(matriz)



## ----eval=F---------------------------------------------------------------------------
## while (condition) {
##   # código executado enquanto a condição for verdade
## }


## -------------------------------------------------------------------------------------
i = 0
while(i<5){
  cat(i,"é menor que 5","\n")
  i = i+1
}


## -------------------------------------------------------------------------------------
numero_escolhido <- 6
resultado_dado = 1
while (resultado_dado!=numero_escolhido) {
  resultado_dado = sample(1:5,1,replace = T,prob = NULL) # sorteando número de 1 a 6
  cat("Número do dado é",resultado_dado,"\n")
}


## ----eval=F---------------------------------------------------------------------------
## repeat {
##   # código será executado repetidamente
##   if (condition) {
##     break  # se a condição for satisfeita, para a repetição
##   }
## }


## ----eval =F--------------------------------------------------------------------------
## # Gera um número aleatório entre 1 e 10
numero_correto <- sample(1:10, 1,replace = T)

# Inicializa a variável para armazenar a tentativa do usuário
tentativa_usuario <- NULL

# Use um loop repeat para continuar o jogo até que o número correto seja adivinhado
repeat {
  # Solicita que o usuário insira uma tentativa
  tentativa_usuario <- as.integer(readline("Tente adivinhar o número (entre 1 e 10): "))

  # Verifica se a tentativa do usuário é correta
  if (tentativa_usuario == numero_correto) {
    cat("Parabéns! Você adivinhou corretamente.\n")
    break  # Sai do loop quando adivinha corretamente
  } else {
    cat("Tente novamente. Dica: ", ifelse(tentativa_usuario < numero_correto, "Tente um número maior.", "Tente um número menor."), "\n")
  }
}


## ----eval = F-------------------------------------------------------------------------
## 
media = 30
desvio_padrao = 5
erro = 10^(-3) # escolha com cuidado, pode travar o computador
n = 1 # tamanho da amostra inicial
crescimento_do_n = 3 # se a condição não for satisfeita, o n anterior será multiplicado por 3
# escolha com cuidado, pode travar o computador

repeat{
  x = rnorm(n,mean = media,sd = desvio_padrao) # gerando amostra
  media_x = mean(x) # média da amostra

  if(abs(media_x-media)<erro){
    cat("n=",n,"media_x"=",media_x=",media_x,"\n")
    break
  }else{
    n = n*crescimento_do_n
     cat("n=",n,"media_x"=",media_x",media_x,"\n")
  }
}


## -------------------------------------------------------------------------------------
numero = 1
dia <- switch(numero,
                "1"="Domingo",
                "2"="Segunda-feira",
                "3"="Terça-feira",
                "4"="Quarta-feira",
                "5"="Quinta-feira",
                "6"="Sexta-feira",
                "7"="Sábado"
               )
cat("O dia correspondente ao número", numero, "é", dia, "\n")


## -------------------------------------------------------------------------------------
PROP = "25%"
prop <- switch (PROP,
    "25%" = 0.25,
    "50%" = 0.5,
    "75%" = 0.75
  )
prop


## ----eval = F-------------------------------------------------------------------------
## name <- function(arguments) {
##   body
##   return(objeto que guarda o resultado final)
## }


## -------------------------------------------------------------------------------------
f_x = function(x){
  f_x = 2*x
  return(f_x)
}

x = c(1,2,3,4)
y = f_x(x)
plot(x,y)


## -------------------------------------------------------------------------------------
media = function(x){
  media_x = sum(x)/length(x)
  return(media_x)
}
y = sample(1:100,20,replace=T)
media(y)


## -------------------------------------------------------------------------------------
dia_semana <- function(numero_dia) {
  dia <- switch(
    numero,
    "1" = "Domingo",
    "2" = "Segunda-feira",
    "3" = "Terça-feira",
    "4" = "Quarta-feira",
    "5" = "Quinta-feira",
    "6" = "Sexta-feira",
    "7" = "Sábado"
  )
  return(cat("O dia correspondente ao número", numero, "é", dia, "\n"))
}
dia_semana(2)

