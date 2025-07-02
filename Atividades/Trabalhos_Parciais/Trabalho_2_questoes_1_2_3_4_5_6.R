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
dplyr::full_join(d1,d2,by = c("x","y"))

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
# Faça um gráfico de setores ou barras para algumas perguntas. Seja criativo



# Questão 3 ---------------------------------------------------------------
#' 1 ponto
# Criando um dataframe fictício para temperaturas e umidade relativa em alguns municípios do Amazonas
dados_climaticos_amazonas <- data.frame(
  Municipio = c("Manaus", "Parintins", "Itacoatiara", "Coari", "Tefé", "Manacapuru", "Humaitá"),
  Temperatura_C = c(30, 28, 31, 29, 27, 29, 33),
  Umidade_Relativa = c(70, 75, 80, 65, 85, 78, 60)
)

# Em formato de texto
dados_climaticos_amazonas_texto <- paste(
  "Em", dados_climaticos_amazonas$Municipio,
  "a temperatura é", dados_climaticos_amazonas$Temperatura_C, "°C e a umidade relativa é",
  dados_climaticos_amazonas$Umidade_Relativa, "%."
)

## Letra a ---------- (0,5)
#' Coloque a base dados_climaticos_amazonas_texto no formato da base dados_climaticos_amazonas
##Letra b ----------- (0,5)
#' Após transformar, coloque com três variáveis: "municipio", "variavel_meteo","valores"


# Questão 4 ---------------------------------------------------------------
#' 1 ponto
#' Considere a base dados_meteorologicos_am para fazer os seguintes gráficos utilizando 
#' ggplot

## Letra a------------

#'Comportamento da variável rh por mês. Pode ser um boxplot. O que pode ser observado?
#'Comporatamento da variável rh por mês e em cada cidade (use facet_grid ou facet_wrap).O que pode ser observado?
#'Total de precp por mês. Pode ser um gráfico de barras
#'Total de precp por cidade. Pode ser um gráfico de barras organizado do menor para o maior nível de precp



# Questão 5 ---------------------------------------------------------------

#' Considere a base de dados Introducao_Ciencias_de_Dados/dados/am_dados_meteorologicos/dados_simulados.rds
#' 1 ponto
##letra a)-------
#' Separe a coluna data_hora em: ano, mes, dia e hora
#' obtenha o coeficiente de variação para as variáveis temperatura e umidade em cada cidade e em cada hora. 
#' Qual hora há maior dispersão, justifique?



# Questão 6 ---------------------------------------------------------------
#' 2 pontos

#' Considere o banco de dados Introducao_Ciencias_de_Dados/dados/nascidos_vivos_am_2022_DATASUS.rds
#' Organize os dados:
#' sem acentuação nos nomes das variáveis e nos nomes dos Municípios. Pesquise sobre o pacote "janitor"
#' Letras minúsculas nos nomes das variáveis e nos nomes dos Municípios
#' Separe a coluna Município em: codigo e municipio. Remova a parte "130" do código
#' Transforme as colunas  Nascim_p_resid_mãe e Nascim_p_ocorrência em tipo_nascimento
#' Faça alguma análise estatística

