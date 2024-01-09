
# Questão 1 (3,0 pontos) ---------------------------------------------------------------

#' Crie objetos da classe produto com os atributos: preco, vencimento e class
#' Os produtos que serão utilizados estão no objeto "produto"
#' Os precos que serão utilizados estão no objeto "preco"
#' As datas para o vencimento que serão utilizadas estão no objeto "data_formatada"

n = 12 # quantidade de produtos

set.seed(1) # semente para simular os preços
preco = round( runif(n,3.50,6.75),2) # simulando preços entre $3,50 e 6,75
produto = c(LETTERS[1:n]) # simulando os nomes do produto

exem_data = seq.Date(from = as.Date("2024-01-01"),to=as.Date("2024-12-01"),by="month")# ano-mês-dia
data_formatada = format(exem_data, format = "%d/%m/%Y") # dia-mês-ano
data_formatada # simulando as datas de vencimento

#' exemplo

produto_A = structure(
  produto[1],
  class = "Produto",
  Vencimento = data_formatada[1],
  Preço = preco[1]
)

#' Faça o mesmo para os produtos "B" "C" "D",...,"L"
# Dica----------
#' Use: as funções assign, paste0, e loop. Também pode usar uma lista para guardar os objetos criados
#' Isso é apenas uma maneira
#' Atenção - Não faça isso:
produtos = structure(
  produto,
  class = "Produto",
  Vencimento = data_formatada,
  Preço = preco
)


# Questão 2 (3,0)---------------------------------------------------------------


#' Considere que em uma urna possuem 7 bolas numeradas de 1 a 7
#' Escolha um número (objeto): numero_escolhido
#' Sortei um número dentro da urna e verifique se é igual ao número escolhido
#' Enquanto o número sorteado for diferente do numero_escolhido, repita o sorteio



# Questão 3 (2,0) ---------------------------------------------------------------


## letra a 1,0 -----------------------------------------------------------------

#' Escreva uma função chamada divide_numeros que aceite dois argumentos (numerador e denominador) e retorne o resultado da divisão. 
#' No entanto, a função deve incluir uma verificação usando a função try() para lidar com a divisão por zero. 
#' Se ocorrer uma divisão por zero, a função deve retornar uma mensagem de erro adequada.

## letra b 1,0 -----------------------------------------------------------------

#' Escreva uma função chamada divide_numeros que aceite dois argumentos (numerador e denominador) e retorne o resultado da divisão. 
#' No entanto, a função deve incluir uma verificação usando a função try() para lidar com a divisão por zero. 
#' Se ocorrer uma divisão por zero, a função deve substituir o valor do denominador por .Machine$double.eps e 
#' retornar uma mensagem de warning adequada avisando o que foi realizado.


# Questão 4 (2,0) ---------------------------------------------------------------

#' Crie uma função com o argumento '...'




# Questão 5 (1,0) Bônus ---------------------------------------------------------------

#' Repita o procedimento da questão 2 N vezes. Em cada vez, guarde o número de tentativas que foram necessárias até
#' aparecer o número escolhido
#' 
#' Defina: falhas = vetor com número de tentativas - 1 # Se falhas  = 3, então foram necessárias 3 tentativas antes do sucesso
#' Conte quantas vezes "falhas" foi igual a 3 e divida esse valor por N
#' Compare esse resultado com: dgeom(3,1/7)# usando a função de distrubuição geométrica
#' Esse resultado indica a probabilidade de ter 3 fracassos antes do sucesso
  


criar_produto <- function(preco, produto, data_formatada) {
  prod <- list(
    preco = preco,
    produto = produto,
    data_formatada = data_formatada,
    exibir_info = function() {
      cat("Nome do produto:", prod$produto, "\n")
      cat("Preço:", prod$preco, "\n")
      cat("Data:", prod$data_formatada, "\n")
    }
  )
  class(prod) <- "Prod"
  return(prod)
}

# Acessando os produtos de A a L (basta trocar o número fixado e o nome
# do objeto), exemplo: 

produtoC <- criar_produto(preco[3], produto[3], data_formatada[3])

# Acesse os atributos do objeto
print(produtoC$preco)
print(produtoC$produto)
print(produtoC$data_formatada)



simulacao_urna <- function(N, numero_escolhido) {
  prob_falhas_3 <- 1/7  # Probabilidade de sucesso em uma tentativa
  resultados <- numeric(N)  # Vetor para armazenar o número de tentativas até o sucesso
  
  for (i in 1:N) {
    tentativas <- 0
    
    while (TRUE) {
      tentativas <- tentativas + 1
      numero_sorteado <- sample(1:7, 1)
      
      cat("Simulação", i, "- Número sorteado:", numero_sorteado, "\n")
      
      if (numero_sorteado == numero_escolhido) {
        resultados[i] <- tentativas
        break
      }
    }
  }
  
  falhas_3 <- sum(resultados - 1 == 3)
  prob_simulada <- falhas_3 / N
  
  prob_teorica <- dgeom(3, prob_falhas_3)
  
  cat("Probabilidade simulada de ter 3 falhas antes do sucesso:", prob_simulada, "\n")
  cat("Probabilidade teórica de ter 3 falhas antes do sucesso:", prob_teorica, "\n")
}

# teste com N = 100 e número escolhido = 5
simulacao_urna(1000, 5)

bolas = 1:7

N = 10000
tentativas = 0
numero_escolhido = 3
vetor_tentativas = c()
for (i in 1:N){
  tentativas = 0
  numero_sort = sample(bolas,1, replace = T)
  if (numero_escolhido == numero_sort){
    tentativas = 1
  }else{
    while (numero_escolhido != numero_sort) {
      numero_sort = sample(bolas, 1, replace = T)
      tentativas = tentativas+1
    }
  }
  vetor_tentativas[i] = tentativas
}
vetor_tentativas

falhas = (vetor_tentativas) 
(prob_3_fracassos = length(falhas[falhas==3])/N)

dgeom(4,1/7) # 0.08996252

#Resultados parecidos, faz todo sentido probabilístico

