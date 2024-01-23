## ----setup, include = FALSE-----------------------------------------------------------

knitr::opts_chunk$set(
 
  collapse = TRUE,

  comment  = "#>",

  class.source = "watch-out",

  fig.height = 3,

  fig.width = 3,

  fig.align = "center"

)
require(tidyverse)
require(tidyr)
require(dplyr)
temperatura_simulada = readRDS(file = "../dados/temperatura_simulada.rds")



## -------------------------------------------------------------------------------------
library(tibble)

# Criar um tibble
exemplo_tibble <- tibble::tibble(
  Nome = c("Alice", "Bob", "Charlie"),
  Idade = c(25, 30, 22),
  Salario = c(50000, 60000, 45000)
)

exemplo_tibble


## -------------------------------------------------------------------------------------
(df <- data.frame(
  Nome = c("Alice", "Bob", "Charlie"),
  Idade = c(25, 30, 22),
  Salario = c(50000, 60000, 45000)
))

(df.tibble <- as_tibble(df))


## -------------------------------------------------------------------------------------
# Acessar uma coluna específica
nomes <- exemplo_tibble[,1]

# Ou usando a notação $ diretamente
nomes <- exemplo_tibble$Nome

# Acessar várias colunas
subset_tibble <- exemplo_tibble[, c("Nome", "Idade")]

# Acessar uma linha específica
linha1 <- exemplo_tibble[1, ]

# Acessar um valor específico
valor <- exemplo_tibble$Idade[2]



## -------------------------------------------------------------------------------------
tibble::tibble(
  x = rnorm(6,180,3),
  y = 1.75+1*x
)


## ----echo=FALSE-----------------------------------------------------------------------
temperatura_simulada


## ----echo=F---------------------------------------------------------------------------
temp_longer  = tidyr::pivot_longer(
    temperatura_simulada,
    cols = !Cidade,# selecionar as colunas diferente de Cidade
    names_to = "Datas", # as colunas selecionadas serão os valores da variável Data
    values_to = "Valores" # As observações nas colunas selecionadas serão as observações da variável Valores
  )
temp_longer


## ----echo=FALSE-----------------------------------------------------------------------
temperatura_simulada


## -------------------------------------------------------------------------------------
(
  temp_longer  = tidyr::pivot_longer(
    temperatura_simulada,
    cols = !Cidade,# selecionar as colunas diferente de Cidade
    names_to = "Datas", # as colunas selecionadas serão os valores da variável Data
    values_to = "Valores" # As observações nas colunas selecionadas serão as observações da variável Valores
  )
)



## -------------------------------------------------------------------------------------
# Forma 1
(
  temp_wider = tidyr::pivot_wider(
    temp_longer,
    id_cols = Cidade, #coluna que identifica cada observação
    names_from = "Datas", # nome da coluna
    values_from = "Valores" # valores de cada coluna
  )
)

# Forma 2
(
  temp_wider = tidyr::pivot_wider(
    temp_longer,
    id_cols = Datas, #coluna que identifica cada observação
    names_from = "Cidade", # nome da coluna
    values_from = "Valores" # valores de cada coluna
  )
)






## -------------------------------------------------------------------------------------
dados_am = readRDS("../dados/dados_am") %>% as_tibble()
dados_am$n_dengue = c(rpois(30,1500),rpois(32,2500))
dados_am


## -------------------------------------------------------------------------------------
dados_am %>% relocate(GEOCODIGO,NOME,n_dengue) # realocando Colunas


## -------------------------------------------------------------------------------------
dados_am %>% select(NOME,n_dengue) # selecionando Colunas
dados_am %>% select(NOME:MICROREGIA) 
dados_am %>% select(1:3)
dados_am %>% select(-GEOCODIGO)


## -------------------------------------------------------------------------------------
dados_am %>% arrange(NOME) # ordenando 
dados_am_select = dados_am %>% arrange(NOME) %>% relocate(NOME,n_dengue)# ordenando


## -------------------------------------------------------------------------------------
dados_am_select %>% filter(n_dengue>1500) # filtro


## -------------------------------------------------------------------------------------
dados_am_select %>% filter(n_dengue>1500 & MESOREGIAO=="NORTE AMAZONENSE") #e


## -------------------------------------------------------------------------------------
dados_am_select %>% filter(n_dengue>1500 | MESOREGIAO=="NORTE AMAZONENSE") # ou
dados_am %>% slice(1:3) # selecionando as 3 primeiras linhas


## -------------------------------------------------------------------------------------
dados_tx = dados_am_select %>% mutate(
  total_pop_municipio = c(rpois(30, 10000), rpois(32, 20000)),
  # simulando a pop total por município
  Taxa = (n_dengue / total_pop_municipio) * 1000
)
dados_tx


## -------------------------------------------------------------------------------------
dados_tx %>% summarise(media_tx_am = mean(Taxa))


## -------------------------------------------------------------------------------------
dados_tx %>% group_by(MESOREGIAO) %>% 
  summarise(media = mean(Taxa),
            variancia = var(Taxa),
            n = length(Taxa)) %>%
  arrange(n) %>%
  relocate(MESOREGIAO,n)


## -------------------------------------------------------------------------------------
dados_am = readRDS("../dados/dados_am") %>% as_tibble()
dados_am = dados_am %>%
  mutate(n_dengue = c(rpois(30, 1500), rpois(32, 2500)),
         n_malaria = c(rpois(30,2000),rpois(32,5000)),
         n_covid = c(rpois(30,1000),rpois(32,2000))
         ) %>% 
  relocate(n_dengue,n_malaria,n_covid)
dados_am



## -------------------------------------------------------------------------------------
dados_am %>% summarise(across(
  .cols = c(n_dengue, n_malaria, n_covid),
  .fns = mean,
  na.rm = T
))


## -------------------------------------------------------------------------------------
dados_am %>% group_by(MESOREGIAO) %>%
  summarise(across(
    .cols = c(n_dengue, n_malaria, n_covid),
    .fns = mean,
    na.rm = T
  ))


## -------------------------------------------------------------------------------------
dados_am %>% group_by(MESOREGIAO) %>%
  summarise(across(where(is.integer),
                   .fns = mean,
                   na.rm = T)
            )


## -------------------------------------------------------------------------------------
dados_am %>% rename(CIDADE = NOME)


## -------------------------------------------------------------------------------------
dados_am %>%
  rename_with(toupper,contains("n_")) 


