library(reshape)
importdata<-`71930` #导入变量名转换
importdata<-rename(importdata, c(Shape="shape",Size="carat", Color="color",Clarity="clarity",Cut="cut", Pol="polish", Sym="symmetry", Flou="fluorescence",Lab="report", Certi.No.="reportno", Parcel.No.="stoneid", Disc..="back", Price.List.Cts....="rapprice"))
importdata$back<-as.numeric(gsub("%","",importdata$back))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back
measurement<-paste(importdata$Length,importdata$Width,importdata$Height,sep="*")

rapnetid<-rep(71930, length(importdata$shape))
milky<-rep(NA, length(importdata$shape))
colsh<-rep(NA, length(importdata$shape))
green<-rep(NA, length(importdata$shape))

price<-rep(NA, length(importdata$shape))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)
OPut<-cbind(OPut, measurement)


OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/71930.csv",row.names = F)
