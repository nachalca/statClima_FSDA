
# # File: imputa_dlm_basico.r
# Description : Imputacion con DLM basico 

# datos y bibliotecas ---------------------
paquetes <- c("tidyverse","lubridate","dlm")
sapply(paquetes,require,character.only=T)
rm(paquetes)

dtmin <- read.table('data/tmin.csv', header = TRUE)
dtmax <- read.table('data/tmax.csv', header = TRUE)

# Funciones para armar modelo ------------------

# con d series los parametros son 2 matrices simetricas dxd
# usamos: V = sigma*I (1 parametro), W = full
# hay  d*(d-1)/2  + 1 
rwBuild <- function(par) {
  p <- length(par) - 1
  wpar <- par[-1]
  d <- (sqrt(1+ 8*length(wpar))-1)/2
  
  W1 <- diag(rep(0, d))  
  W1[upper.tri(W1, diag = TRUE)] <- wpar
  
  dlm(
    m0 = rep(0, d), 
    C0 = diag(d)*1e3,
    FF = diag(d),
    V = exp(par[1])*diag(d),
    GG = diag(d),
    W =  crossprod(W1)
  )
}

# completo ------------------------------
# Modelo con las 11 estaciones y todo el periodo ...... 

smfn_dlmbasico <- function(dd) {
  yy <- dd %>% 
    mutate(fecha = make_date(year, month, day))  %>% 
    arrange(fecha) %>% select(Artigas:Salto) %>% 
    as.matrix() %>% ts(frequency = 365)  
  
  # Modelo usando la varianza muestral (momentos?)
  spvar <- var(yy, na.rm = TRUE)
  ch <- chol(spvar) 
  mod.mm <- rwBuild( c( log(mean(diag(spvar))) , 
                        ch[upper.tri(ch, diag = TRUE)] ) )
  
  # Kalman smother
  sm <- yy %>% dlmSmooth( mod = mod.mm )
  pred <- tcrossprod(sm$s[-1,], mod.mm$FF) %>% data.frame() %>% 
    set_names(nm=colnames(yy) ) %>% 
    gather(location, yhat.mm)
  
  list(mod.mm=mod.mm, sm.mm=sm, pred=pred)
}

tn.dlmbasico <- smfn_dlmbasico(dtmin)
tx.dlmbasico <- smfn_dlmbasico(dtmax)

res.dlmbasico <- gather(dtmin, location, tn, Artigas:Salto) %>% 
  inner_join( gather(dtmax, location, tx, Artigas:Salto)  ) %>% 
  mutate(fecha = make_date(year, month, day))  %>% 
  arrange(location, fecha) %>% 
  bind_cols( tn.dlmbasico$pred, tx.dlmbasico$pred) %>% 
  rename( tn.hat = 'yhat.mm', tx.hat = 'yhat.mm1') %>% 
  select(-location1, -location2)


# save imputed data
ll <- list(res.dlmbasico= res.dlmbasico, 
           tnmod.dlmbasico = tn.dlmbasico$mod.mm, 
           txmod.dlmbasico = tx.dlmbasico$mod.mm)
           
saveRDS(ll, file = 'series_completas/res_dlmbasico.rds')

