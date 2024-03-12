# Ajuste um modelo para prever se a manchete é sarcástica ou não.

df <- readr::read_csv(
  pins::pin("https://storage.googleapis.com/deep-learning-com-r/headlines.csv")
)
