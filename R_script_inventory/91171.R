setwd("D:/")
library(reshape)
importdata<-`91171`
importdata<-rename(importdata,c(Meas="measurement",Sh="shape",CTS="carat", Color="color", Clarity="clarity", Cut="cut", Polish="polish",Sym="symmetry",Flr="fluorescence",Lab="report",Cert.no="reportno",Lot.no.="stoneid", Discount="back",Rap.Price="rapprice"))

colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
rapnetid<-rep(91171, length(importdata$measurement))

Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin1<-OOPut[Myvars]
write.csv(Fin1,file="./R_input/91171.csv",row.names = F)