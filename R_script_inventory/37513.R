library(reshape)
importdata<-`37513` #导入变量名转换
importdata<-rename(importdata, c(Shape="shape",Color="color",Cut.Grade="cut", Polish="polish",Clarity="clarity", Weight="carat", Symmetry="symmetry", Fluor="fluorescence",Lab="report", Certificate..="reportno", Lot..="stoneid", X..Off.RAP="back", Rapaport.Price="rapprice"))

importdata$back<--importdata$back
measurement<-c(unlist(paste(importdata$Length, importdata$Width, importdata$Depth, sep="*")))
rapnetid<-rep(37513, length(measurement))

colsh<-rep(NA, length(measurement))
milky<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))

OPut<-cbind(measurement,rapnetid)
OPut<-cbind(OPut, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/37513.csv",row.names = F)

