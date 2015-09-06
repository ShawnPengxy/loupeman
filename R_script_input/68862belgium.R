library(reshape)
importdata<-`68862belgium` #导入变量名转换
importdata<-rename(importdata, c(Measurements="measurement",Shape="shape",Cts="carat", Color="color",Grade="clarity",Cut="cut", Pol="polish", Sym="symmetry", Flour="fluorescence",Lab="report", Report.No="reportno", Stock="stoneid", Disc..="back", Rap="rapprice"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back


rapnetid<-rep("68862belgium", length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
price<-rep(NA, length(importdata$measurement))



OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/68862belgium.csv",row.names = F)
