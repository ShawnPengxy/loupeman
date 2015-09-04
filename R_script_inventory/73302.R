library(reshape)
importdata<-`73302b` #导入变量名转换
importdata<-rename(importdata, c(Measurements="measurement",Shape="shape",Size="carat", Color="color",Clarity="clarity", CUT="cut",Polish="polish", Sym="symmetry", FLRN="fluorescence",LAB="report", Certi.No="reportno", Stock.ID="stoneid", Disc.="back", RAP.Price="rapprice"))


rapnetid<-rep(73302, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
color<-rep(NA, length(importdata$measurement))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, color)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/73302b.csv",row.names = F)
