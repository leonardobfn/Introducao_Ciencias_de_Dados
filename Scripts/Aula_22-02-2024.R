

# Exemplo com a função optim
f = function(x){
  fx = x^2 + 2*x -3
}
x = seq(-10,10)
fx = f(x)
plot(x,fx)
x[which.min(fx)]
optim(fn = f,par=0,method = "Brent",lower = -10,upper = 10)

# Regressao

n = 100
b0 = 2
b1 = .2
x = rnorm(n,3,1)
e = rnorm(n)
y = b0 + b1*x + e # resposta simulada


fx = function(b0_b1,x,y){
  b00 = b0_b1[1]
  b11 = b0_b1[2]
  erro =( y - (b00 +b11*x))^2
  sum_erro = sum(erro)
  return(sum_erro)
}


par_est = optim(par = c(1,1),fn = fx,y=y,x=x)
X = data.frame(b0 = rep(1,n),x) 
lm.fit(as.matrix(X),y)


y_est = par_est$par[1]+par_est$par[2]*x
resid = y_est - y





