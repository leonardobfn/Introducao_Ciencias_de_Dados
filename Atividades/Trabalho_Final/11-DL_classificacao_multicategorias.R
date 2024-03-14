#'A dataset containing the choice among general program, 
#'vocational program and academic program for 
#'200 high school students as well as some explanatory variables.
#' A variável resposta é prog, tipo de programa. 
#' As variáveis preditoras são status socioeconômico, "ses", 
#' uma variável categórica de três níveis, 
#' e pontuação de escrita, "write", uma variável contínua.
#' Faça uma classificação do tipo de programa. Utilize
#' as variáveis "ses" e "write" como covariáveis
dados = foreign::read.dta("https://stats.idre.ucla.edu/stat/data/hsbdemo.dta")
head(dados)
