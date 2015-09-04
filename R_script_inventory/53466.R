library(reshape)
importdata<-`53466` #导入变量名转换
importdata<-rename(importdata, c(Shape="shape",Carat="carat", Color="color",Clarity="clarity",Cut="cut", Pol="polish", Sym="symmetry", Flour="fluorescence",Lab="report", Certificate.No="reportno", Stock.ID="stoneid", Diss..1="back", Rap="rapprice"))

measurement<-c(unlist(paste(importdata$Length,importdata$Width,importdata$Depth, sep="*")))
rapnetid<-rep(53466, length(measurement))
milky<-rep(NA, length(measurement))
colsh<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))

OPut<-cbind(measurement,rapnetid)
OPut<-cbind(OPut, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/43566.csv",row.names = F)
