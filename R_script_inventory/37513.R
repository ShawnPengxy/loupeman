library(reshape)
importdata<-`37513` #导入变量名转换
importdata<-rename(importdata, c(Measurements="measurement",Shape="shape",Color="color",Cut="cut", Polish="polish",Clarity="clarity", Carats="carat", Symmetry="symmetry", Fluorescence="fluorescence",Lab.Name="report", Cert.Report.No.="reportno", Lot.No...Stone.ID="stoneid", Final="back", Rap.Price="rapprice"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

rapnetid<-rep(37513, length(importdata$shape))
importdata$shape[which(importdata$shape=="RBC")]<-"圆形"
colsh<-rep(NA, length(importdata$shape))
milky<-rep(NA, length(importdata$shape))
green<-rep(NA, length(importdata$shape))
price<-rep(NA, length(importdata$shape))

OPut<-cbind(price,rapnetid)
OPut<-cbind(OPut, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/37513.csv",row.names = F)

