library(reshape)
importdata<-`73440` #导入变量名转换
importdata<-rename(importdata, c(Shape="shape",Carat="carat", Col="color",Clarity="clarity",Cut="cut", Pol="polish", Sym="symmetry", Fls="fluorescence",Lab="report", Report.No="reportno", Packet.No="stoneid",Disc..="back",Rap....="rapprice"))

measurement<-c(unlist(paste(importdata$Length,importdata$Width,importdata$Depth, sep="*")))
rapnetid<-rep(73440, length(measurement))
###################Shade, only choose WHT as No Colsh################
milky<-rep(NA, length(measurement))
colsh<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))
#temp1<-importdata$Shade%in%"WHT"
#colsh[temp1]<-"无咖"

OPut<-cbind(measurement,rapnetid)
OPut<-cbind(OPut, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/73440.csv",row.names = F)
