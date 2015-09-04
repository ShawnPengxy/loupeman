library(reshape)
importdata<-`67233a` #导入变量名转换
importdata<-rename(importdata, c(Shape="shape",Size="carat", Color="color",Clarity="clarity",Cut="cut", Pol="polish", Sym="symmetry", Flo.="fluorescence",Lab="report", Report.No="reportno", Ref.No.="stoneid", S.Disc="back", Rap.Price="rapprice"))

measurement<-c(unlist(paste(importdata$Length,importdata$Width, importdata$Height, sep="*")))
rapnetid<-rep(67233, length(measurement))
milky<-rep(NA, length(measurement))
colsh<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, measurement)
OOPut<-cbind(OPut, importdata)

Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/67233a.csv",row.names = F)
