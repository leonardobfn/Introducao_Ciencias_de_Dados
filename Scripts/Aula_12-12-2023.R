## .watch-out {
##   border: 3px solid gray;
##   font-weight: bold;
## }
## 

## ----setup, include = FALSE---------------------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment  = "#>",
  class.source = "watch-out",
  fig.height = 3, 
  fig.width = 3, 
  fig.align = "center"
)


## -----------------------------------------------------------------------------------------------------
a <- 2
a = 2
print(a)


## -----------------------------------------------------------------------------------------------------
b <- 1:6
print(b)


## -----------------------------------------------------------------------------------------------------
lgl_var <- c(TRUE, FALSE)# lógico
lgl_var <- c(T, F)# lógico
typeof(lgl_var)# verificar o tipo
is.logical(lgl_var) # testar se o vetor é do tipo lógico
is.integer(lgl_var)
length(lgl_var)


## -----------------------------------------------------------------------------------------------------
dbl_var <- c(1, 2.5, 4.5)#forma decimal 
dbl_var <- c(1.23e4)##forma científica 
typeof(dbl_var) 
is.double(dbl_var) # testar se o vetor é do tipo Double 
is.character(lgl_var)
length(dbl_var)


## -----------------------------------------------------------------------------------------------------
dbl_var <- c(Inf,-Inf,NaN)
typeof(dbl_var)


## -----------------------------------------------------------------------------------------------------
int_var <- c(1L, 6L, 10L)# inteiro
typeof(int_var)
is.integer(int_var)
is.character(int_var)
length(int_var)


## -----------------------------------------------------------------------------------------------------
chr_var <- c("Leonardo", "Nascimento")
chr_var <- c("Ótimo", "Bom","Ruim")
chr_var <- c("Masculino", "Feminino")
is.character(chr_var)
typeof(chr_var)


## -----------------------------------------------------------------------------------------------------
meu_vetor = c(1,2,10,4,5)
meu_vetor[3]


## -----------------------------------------------------------------------------------------------------
vetor_null <- c(NULL)
vetor_null
typeof(vetor_null)


## -----------------------------------------------------------------------------------------------------
meu_vetor <- c(10,NA)
2*meu_vetor


## -----------------------------------------------------------------------------------------------------
x <- c(1, 2,3,NA, 5)
is.na(x)



## -----------------------------------------------------------------------------------------------------
notas_alunos <- c(10, 7, NA, 8, 8.5)
mean(notas_alunos, na.rm = TRUE) # média


## -----------------------------------------------------------------------------------------------------
meu_vetor <- c(1, 2,3, 4, NA)
meu_vetor[is.na(meu_vetor)] <- 0


## -----------------------------------------------------------------------------------------------------
y1 <- c(1L,"leonardo") # inteiro, character
y1
typeof(y1)

y2 <- c(5.5,10L) # double, inteiro
y2
typeof(y2)


## -----------------------------------------------------------------------------------------------------
l1 <- list(
  1:3, 
  "a", 
  c(TRUE, FALSE, TRUE), 
  c(2.3, 5.9)
)
print(l1)
typeof(l1)



## -----------------------------------------------------------------------------------------------------
l1 <- list(
  1:3, 
  "a", 
  c(TRUE, FALSE, TRUE), 
  c(2.3, 5.9)
)
l1[[4]]
l1[[4]][1]


## -----------------------------------------------------------------------------------------------------
minha_lista = list(1:3)
print(minha_lista)
is.list(minha_lista)
vec <- c(1,2,3)
is.list(vec)
as.list(vec)



## -----------------------------------------------------------------------------------------------------
minha_lista = list(1:3,4:10)
print(minha_lista)
unlist(minha_lista)


## -----------------------------------------------------------------------------------------------------
# Criando uma matriz 2x2
vec1 = c(1,2)
vec2 = c(3,4)
minha_matriz <- matrix(c(vec1,vec2), nrow = 2, ncol = 2)
minha_matriz
is.matrix(minha_matriz)


## -----------------------------------------------------------------------------------------------------
vec1 = c(1,2)
vec2 = c(3,4)
minha_matriz <- matrix(c(vec1,vec2), nrow = 2, ncol = 2,byrow = T)
minha_matriz
dim(minha_matriz)
ncol(minha_matriz)
nrow(minha_matriz)


## -----------------------------------------------------------------------------------------------------
minha_matriz[1,2] # Acessando o elemento na primeira linha e segunda coluna


## -----------------------------------------------------------------------------------------------------
# Criando um array 2x3x2 - linhas X colunas X camadas
vec1 = c(1L,2L,3L,4L)
vec2 = c(5L,6L,7L,8L)
vec2 = c(5L,6L,7L,8L)
meu_array <- array(c(vec1,vec2), dim = c(2,2,3))
meu_array
typeof(meu_array)


## -----------------------------------------------------------------------------------------------------
meu_array[1,2,2]# linhas X colunas X camadas
meu_array[,,1] # acessando a matriz da primeira camada
meu_array[,,2]# acessando a matriz da segunda camada


## -----------------------------------------------------------------------------------------------------
meu_data_frame <- data.frame(
  Nome = c("Alice","Leo","Vitor"),
  Idade = c(25,30,22),
  Nota = c(85, 92, 78)
)
meu_data_frame


## -----------------------------------------------------------------------------------------------------
dados_climaticos <- data.frame(
  Dia = seq(from = as.Date("2023-01-01"), by = "days", length.out = 5),
  Temperatura = c(25.3, 24.5, 22.0, 26.8, 23.5),
  Umidade = c(65, 70, 75, 60, 80),
  VelocidadeVento = c(10, 12, 8, 15, 9)
)

# Exibindo o data frame
print(dados_climaticos)
head(dados_climaticos,3)


## -----------------------------------------------------------------------------------------------------
dados_climaticos$Temperatura
dados_climaticos[,2]


## -----------------------------------------------------------------------------------------------------
meu_vetor <- c(1, 2, 3)
names(meu_vetor) <- c("primeiro", "segundo", "terceiro")
meu_vetor
attributes(meu_vetor)


## -----------------------------------------------------------------------------------------------------
x1 <- c(a = 1, b = 2, c = 3)
x1

x2 <- setNames(1:3, c("a", "b", "c"))
x2


## -----------------------------------------------------------------------------------------------------
meu_vetor <- 1:5
meu_vetor
dim(meu_vetor) <- c(5, 1) # linha x coluna
meu_vetor
attributes(meu_vetor)


## -----------------------------------------------------------------------------------------------------
vec1 = c(1,2)
vec2 = c(3,4)
class(vec1)
minha_matriz <- matrix(c(vec1,vec2), nrow = 2, ncol = 2)
minha_matriz
class(minha_matriz)


## -----------------------------------------------------------------------------------------------------
vec <- c(1,2,3,4)
class(vec)
class(vec)<- "minha_classe"
class(vec)



## -----------------------------------------------------------------------------------------------------

pessoa1 <- structure(
  c("Leonardo"), 
  idade = 31,
  last_name = "Nascimento",
  class = "Pessoa",
  names = c("nome_pessoa")
)
pessoa1
class(pessoa1)
attr(pessoa1,"idade") # selecionado o atributo idade
names(pessoa1)


## -----------------------------------------------------------------------------------------------------
dados_sexo_curso <- read.csv("~/GitHub/Introducao_Ciencias_de_Dados/dados/tab_sexo_curso.csv")
head(dados_sexo_curso)


## -----------------------------------------------------------------------------------------------------
exemplo_csv = data.frame(Pessoa = c("Leo","Lennon"),Idade=c(30,29))
write.csv(exemplo_csv ,"~/GitHub/Introducao_Ciencias_de_Dados/dados/exemplo_csv.csv")


## -----------------------------------------------------------------------------------------------------
dados_temperatura <- read.table("~/GitHub/Introducao_Ciencias_de_Dados/dados/temperatura.txt") 
head(dados_temperatura)


## -----------------------------------------------------------------------------------------------------
exemplo_txt = data.frame(Pessoa = c("Leo","Lennon"),Idade=c(30,29)) 
write.table(exemplo_txt ,"~/GitHub/Introducao_Ciencias_de_Dados/dados/exemplo_txt.txt")


## -----------------------------------------------------------------------------------------------------
dados <- readRDS("~/GitHub/Introducao_Ciencias_de_Dados/dados/tempo_exercicio_perda_peso.rds") 
head(dados)


## -----------------------------------------------------------------------------------------------------
exemplo_rds = data.frame(Pessoa = c("Leo","Lennon"),Idade=c(30,29))  
saveRDS(exemplo_rds ,"~/GitHub/Introducao_Ciencias_de_Dados/dados/exemplo_rds.rds")

