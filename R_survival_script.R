#Este es el script del analisis de supervivencia.

#Cargamos los datos y la libreria que vamos a utilizar

library(survival)
data = read.csv("turnover.csv")

#Vemos las primeras observaciones
library(dplyr)
head(data)

#Inicializamos el objeto de supervivencia 
surv_obj = Surv(data$stag, data$event)

#Hacemos el ajuste Kaplan-Maier
fit= survfit(surv_obj ~ data$greywage, conf.type = 'plain', type = 'kaplan-meier', conf.int = 0.95)

#Hacemos la grafica.
plot(fit, col = c(1,2), xlab = 'Tiempo', ylab = 'Probabilidad')
title(main = 'Funcion de supervivencia por greywage')
legend(x = 'topright', legend = c('grey', 'white'), fill = c(1,2))

#Aplicamos la prueba de Log-Rank
survdiff(surv_obj ~ data$greywage , rho = 0, data = data)
