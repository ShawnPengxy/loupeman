#####数据量太小，无法提取奶咖绿#############
setwd("D:/")
library(reshape)
importdata<-`74774b`
importdata$Dis.[importdata$Dis.%in%c("","-")]<-NA
importdata<-rename(importdata,c(Measurements="measurement",Shape="shape",Carat="carat", Color="color", Clarity="clarity", Cut="cut", Pol="polish",Sym="symmetry",FLO="fluorescence",Lab="report",Report="reportno",Stock.id="stoneid", Rap="rapprice"))
back<--as.numeric(importdata$Dis.)
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
rapnetid<-rep(74774, length(importdata$measurement))


OPut<-cbind(rapnetid, colsh)

OPut<-cbind(OPut, back)

OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin1<-OOPut[Myvars]
write.csv(Fin1,file="./R_input/74774b.csv",row.names = F)