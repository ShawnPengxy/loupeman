library(reshape)
importdata<-`61666` #导入变量名转换
importdata<-rename(importdata,c(Measurements="measurement",Shape="shape",Cts="carat", Color="color", Grade="clarity", Cut="cut", Pol="polish",Sym="symmetry",Flour="fluorescence",Lab="report",Report.No="reportno",Stock="stoneid", Disc..="back",Rap="rapprice"))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
rapnetid<-rep("61666", length(importdata$measurement))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/61666.csv",row.names = F)
