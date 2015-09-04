library(reshape)
importdata<-`86373` #导入变量名转换
importdata<-rename(importdata,c(Shape="shape",Carats="carat", Color="color", Clarity="clarity", Cut="cut", Polish="polish",Symm="symmetry",Flour.="fluorescence",Lab="report",Report.No="reportno",Stone.No="stoneid", Disc..="back",Rap..Price="rapprice"))
measurement<-c(unlist(paste(importdata$Length, importdata$Width, importdata$Height, sep="*")))

colsh<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))

milky<-rep(NA, length(measurement))



temp4<-importdata$Milky%in%"NO"
milky[temp4]<-"无奶"
milky[which(!is.na(milky)&is.na(green)&is.na(colsh))]<-NA


rapnetid<-rep("86373", length(measurement))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, measurement)

OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/86373.csv",row.names = F)
