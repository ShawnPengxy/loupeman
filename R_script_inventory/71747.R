library(reshape)
importdata<-`71747` #导入变量名转换
importdata<-rename(importdata, c(Diam.="measurement",Shape="shape",Carats="carat", Color="color",Clarity="clarity",Cut="cut", Polish="polish", Sym.="symmetry", FL="fluorescence",LAB="report", CertNo="reportno", StockID="stoneid", Back.="back", Rapa="rapprice"))


rapnetid<-rep(71747, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/71747.csv",row.names = F)
