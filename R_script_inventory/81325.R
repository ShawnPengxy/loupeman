library(reshape)
importdata<-`81325` #导入变量名转换
importdata<-rename(importdata,c(Measurement="measurement",Shape="shape",Size="carat", Color="color", Clarity="clarity", Cut="cut", Pol="polish",Sym="symmetry",Fls="fluorescence",Lab="report",Certi.No.="reportno",RefNo="stoneid", Disc..="back",RapPrice....="rapprice"))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))

milky<-rep(NA, length(importdata$measurement))






rapnetid<-rep("81325", length(importdata$measurement))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/81325.csv",row.names = F)