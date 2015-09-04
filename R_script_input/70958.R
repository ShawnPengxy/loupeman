library(reshape)
importdata<-`70958` #导入变量名转换
importdata<-rename(importdata, c(Shape="shape",Weight="carat", Color="color",Clarity="clarity",Cut="cut", Polish="polish", Symm="symmetry", Fls="fluorescence",Lab="report", Report.No="reportno", Packet.No="stoneid", Disc..="back", Rap.Price="rapprice",Amount="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

measurement<-c(unlist(paste(importdata$Length,importdata$Width, importdata$Depth, sep="*")))
rapnetid<-rep(70958, length(measurement))
milky<-rep(NA, length(measurement))
colsh<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))

OPut<-cbind(measurement,rapnetid)
OPut<-cbind(OPut, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)


Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/70958.csv",row.names = F)
