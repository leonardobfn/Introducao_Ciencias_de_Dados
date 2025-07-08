# ============================================================
# SCRIPT: Executor geral de scripts R
# OBJETIVO: Rodar automaticamente todos os scripts de uma pasta
# ============================================================


# Lista todos os arquivos .R na pasta
arquivos <- list.files("Analises/mtcars", pattern = "\\.R$", full.names = TRUE)[-c(1,5)]

# Exibe quais scripts serão executados
cat("Executando os seguintes scripts:\n")
print(arquivos)

# Executa cada script em ordem
for (arquivo in arquivos) {
  cat("\n-----------------------------\n")
  cat("Executando:", arquivo, "\n")
  source(arquivo)
  cat("Finalizado:", arquivo, "\n")
}


