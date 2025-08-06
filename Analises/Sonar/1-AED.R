library(caret)
library(mlbench)
require(tidyverse)

# Carregar dados
data(Sonar)
str(Sonar)
dim(Sonar)



plot.ts(Sonar[1,1:60] |> c() |> unlist(),col=1,ylim=c(0,1))
for(i in 2:nrow(Sonar)){
  lines(Sonar[i,1:60]|> c() |> unlist(),col=ifelse(Sonar$Class[i]=="R",1,2))  
}

      
      