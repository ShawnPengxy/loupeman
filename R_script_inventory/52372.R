library(reshape)
importdata<-`52372` #导入变量名转换
importdata<-rename(importdata, c(L.W.Diam="measurement",Shape="shape",Cts="carat", Color="color",Clar="clarity",Cut="cut", Polish="polish", Symm="symmetry", Fl="fluorescence",Lab="report", Cert.No="reportno", Hopno="stoneid", Disc.="back", Rap.="rapprice"))

rapnetid<-rep(52372, length(importdata$measurement))

milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/52372.csv",row.names = F)
