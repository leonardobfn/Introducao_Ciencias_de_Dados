## ----------------------------------------------------------------------------------------------------------------------------------------------------
nome <- "Leonardo"
ls(globalenv())
nome


## ----------------------------------------------------------------------------------------------------------------------------------------------------
novo_ambiente = new.env() # criando o ambiente
novo_ambiente$nome <- "Nascimento" #criando objeto dentro do ambiente ou
assign(nome,"Nascimento",envir = novo_ambiente ) #criando objeto dentro do ambiente
nome
get("nome",envir = novo_ambiente)


## ----------------------------------------------------------------------------------------------------------------------------------------------------
rlang::env_print(novo_ambiente)


## ----------------------------------------------------------------------------------------------------------------------------------------------------
novo_ambiente$idade = 30
rlang::env_print(novo_ambiente)


## ----eval=F------------------------------------------------------------------------------------------------------------------------------------------
## novo_ambiente$idade = 30
## idade


## ----------------------------------------------------------------------------------------------------------------------------------------------------
a = 1 # criando um objeto no ambiente global
get("a",envir = novo_ambiente) # buscar o objeto "a" no ambiente novo_ambiente


## ----------------------------------------------------------------------------------------------------------------------------------------------------
parent.env(novo_ambiente)


## ----------------------------------------------------------------------------------------------------------------------------------------------------
novo_ambiente_2 = new.env(parent = novo_ambiente) 
parent.env(novo_ambiente_2)
rlang::env_print(novo_ambiente)


## ----------------------------------------------------------------------------------------------------------------------------------------------------
rlang::env_parents(novo_ambiente_2)


## ----------------------------------------------------------------------------------------------------------------------------------------------------
rlang::env_parents(novo_ambiente_2,last = rlang::empty_env())


## ----------------------------------------------------------------------------------------------------------------------------------------------------
novo_ambiente_3 = new.env(parent = rlang::empty_env())
rlang::env_parents(novo_ambiente_3)


## ----------------------------------------------------------------------------------------------------------------------------------------------------
rlang::current_env()
identical(globalenv(), environment()) #ou 
identical(rlang::global_env(), rlang::current_env())


## ----------------------------------------------------------------------------------------------------------------------------------------------------
x <- 0
f <- function() {
  x <<- 1
}
f()
x
#> [1] 1


## ----------------------------------------------------------------------------------------------------------------------------------------------------
search()
rlang::search_envs()



## ----------------------------------------------------------------------------------------------------------------------------------------------------
y <- 1
f <- function(x) x + y
environment(f)


## ----------------------------------------------------------------------------------------------------------------------------------------------------
criar_funcao <- function() {
  
  funcao_interna <- function() {
    a=1
    print("aqui")
    list(ran.in = rlang::current_env(), 
         parent = rlang::env_parent(rlang::current_env()), 
         objects = ls.str(rlang::current_env()))
  }
  return(funcao_interna)
}
minha_funcao <- criar_funcao()
minha_funcao()
environment(minha_funcao)
environment(criar_funcao)


## ----------------------------------------------------------------------------------------------------------------------------------------------------
show_env <- function(){
  a = 1
  list(ran.in = rlang::current_env(), 
    parent = rlang::env_parent(rlang::current_env()), 
    objects = ls.str(rlang::current_env()))
}
show_env()


## ----------------------------------------------------------------------------------------------------------------------------------------------------
x = 10
a = 4
x+a
h <- function(x) {
  # 1.
  a <- 2 # 2.
  x + a
}
y <- h(1) # 3.
y


## ----------------------------------------------------------------------------------------------------------------------------------------------------
rf <- function(f) f(rnorm(100))
rf(mean)
rf(sum)


## ----------------------------------------------------------------------------------------------------------------------------------------------------
x = NULL
y = 1:10
for(i in 1:length(y)){
  x[i] <- 2*y[i]
}
x

f = function(x){2*x}
purrr::map(y,f)


## ----------------------------------------------------------------------------------------------------------------------------------------------------
require(purrr)
head(mtcars)

map_chr(mtcars, typeof) # character
map_lgl(mtcars, is.double) # lógical
map_int(mtcars, ~length(unique(x))) # inteiro
#map_int(mtcars, function(x) length(unique(x))) # inteiro
map_dbl(mtcars, mean) # double



## ----------------------------------------------------------------------------------------------------------------------------------------------------
x <- list(
  list(5, x = 2, y = c(1), z = "A"),
  list(9, x = 1, y = c(1, 6), z = "B"),
  list(2, x = 10, y = c(2, 3, 5))
)

map_dbl(x, "x")
map_dbl(x, 1)
map_dbl(x, list("y", 1))
map_chr(x, "z", .default = NA)



## ----------------------------------------------------------------------------------------------------------------------------------------------------
dados_json <- '[
  {"nome": "Alice", "idade": 25, "cidade": "São Paulo"},
  {"nome": "Bob", "idade": 30, "cidade": "Rio de Janeiro"},
  {"nome": "Charlie", "idade": 22, "cidade": "Belo Horizonte"}
]'

lista_pessoas <- rjson::fromJSON(dados_json)

# Usar map para extrair os nomes de cada pessoa
(nomes <- map_chr(lista_pessoas, "nome"))
(idade <- map_dbl(lista_pessoas, 2))


## ----------------------------------------------------------------------------------------------------------------------------------------------------
trims <- c(0, 0.1, 0.2, 0.5)
x <- rcauchy(1000)

map_dbl(trims, ~ mean(x, trim = .))#



## ----------------------------------------------------------------------------------------------------------------------------------------------------
map(1:3, ~ rnorm(2))


## ----------------------------------------------------------------------------------------------------------------------------------------------------
obs <- list(c(1,2,3),c(4,5,NA))
wd <- list(c(1,2,3),c(4,5,6))
map2_dbl(obs,wd,weighted.mean,na.rm=T)



## ----------------------------------------------------------------------------------------------------------------------------------------------------
obs <- list(c(1,2,3),c(4,5,NA))
wd <- list(c(1,2,3),c(4,5,6))
pmap_dbl(list(obs, wd), weighted.mean, na.rm = TRUE)


## ----------------------------------------------------------------------------------------------------------------------------------------------------
n = list(1,2,3)
min = list(0,10,100)
max = list(1,100,1000)
pmap(list(n,min,max),runif)


## ----eval=F------------------------------------------------------------------------------------------------------------------------------------------
## library(parallel)
## num_nucleos <- detectCores()
## nucleos = round(0.60*num_nucleos)
## 
## f <- function(i) {
##   lm(Petal.Width ~  Species, data = iris)
## }
## 
## require(snowfall)
## sfInit(parallel=TRUE, cpus=nucleos)
## system.time(sfLapply(1:100000, fun=f))
## sfStop()
## system.time(
## for(i in 1:100000){
##   f(i)
## }
## )

