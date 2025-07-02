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
# ou
purrr::reduce(
  list(d1,d2),
  dplyr::full_join,
  by = c("x","y"))