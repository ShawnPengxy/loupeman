setwd("D:/")
library(reshape)
importdata<-`90109`
importdata<-rename(importdata,c(Measurements="measurement",Shape="shape",Wts="carat", Color="color", Clarity="clarity", Cut="cut", Polish="polish",Sym="symmetry",Fluor="fluorescence",Lab="report",Certificate..="reportno",Stock..="stoneid", Disc..="back"))

colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
rapprice<-rep(NA, length(importdata$measurement))

rapnetid<-rep(90109, length(importdata$measurement))


OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, rapprice)

OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin1<-OOPut[Myvars]
write.csv(Fin1,file="./R_input/90109.csv",row.names = F)