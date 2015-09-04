library(reshape)
importdata<-`67000` #导入变量名转换
importdata<-rename(importdata, c(Diam.="measurement",Shape="shape",Carats="carat", Color="color",Clarity="clarity",Cut="cut", Polish="polish", Sym="symmetry", FL="fluorescence",Cert.="report", Cert.No.="reportno", LotNo="stoneid", R.Dn="back", Rap.="rapprice"))

options(digits=10)
rapnetid<-rep(67000, length(importdata$shape))
milky<-rep(NA, length(importdata$shape))
colsh<-rep(NA, length(importdata$shape))
green<-rep(NA, length(importdata$shape))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/67000.csv",row.names = F)
