library(reshape)
importdata<-`33162b` #导入变量名转换
importdata<-rename(importdata, c(Shape="shape",Color="color",Cut="cut", Pol="polish",Clarity="clarity", Size="carat", Symm="symmetry", Flur.="fluorescence",Lab="report", Certificate..="reportno", Stock..="stoneid", Disc.="back", Rappaport="rapprice"))

measurement<-c(unlist(paste(importdata$Length, importdata$Width, importdata$Height, sep="*")))
rapnetid<-rep(33162, length(measurement))

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
write.csv(Fin,file="./R_input/33162b.csv",row.names = F)
