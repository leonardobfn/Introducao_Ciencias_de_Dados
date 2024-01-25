# Exemplo como unir duas tibbles
n = 12
d1 = tibble(
  x = LETTERS[1:n],
  y = month.abb %>% factor(levels = month.abb),
  z1 = rnorm(n)
)
d2 = tibble(
  x = LETTERS[1:n],
  y = month.abb %>% factor(levels = month.abb),
  z2 = rnorm(n)
)

purrr::reduce(
  list(d1,d2),
  dplyr::full_join,
  by = c("x","y"))


# Questão 1  ---------------------------------------------------------------
#' 3 pontos
##letra a)---------
#'Considere os seguintes dados meteorologicos:
  #'umidade: menor média diária registrada no mês, 
  #'tbu: temperatura bulbo úmido, 
  #'tbs: temperatura bulbo seco,
  #'precp: quantidade de chuva registrada no mês (mm)

#'Os dados estão na pasta: "dados/am_dados_meteorologico" 
#'Organize os dados semelhante à base: dados_meteorologicos.rds

##letra b)---------
#' Obtenha estatísticas descritias para as variáveis
#' Seja criativo

##letra c)---------
#' Faça gráficos de linhas ou boxplot. Seja criativo. Tente usar ggplot2


# Questão 2 ---------------------------------------------------------------
#' 2 pontos
#' Considere os dados questionario.xlsx
#' os números são as possíveis respostas para cada pergunta
#' Os números representam textos e possuem significados diferentes em cada pergunta
require(readxl)
dados = readxl::read_xlsx("dados/questionario.xlsx",col_types = "text")

# Quantas pessoas (abs e porcentagem) responderam "2" na pergunta_1?
# Quantas pessoas (abs e porcentagem) responderam "3" na pergunta_2?

# Construa uma tabela que dê a frequência (abs e porcentagem) das respostas dentro de cada pergunta

