library(reshape)
importdata<-`73688` #导入变量名转换
importdata<-rename(importdata,c(Shape="shape",Cts="carat", Color="color", Clarity="clarity", Cut="cut", Polish="polish",Symmetry="symmetry",Fluorescence="fluorescence",Lab="report",Report.No="reportno",Stone.ID="stoneid", Selling.Disc="back",Selling.Price="rapprice"))
measurement<-c(unlist(paste(importdata$Length, importdata$Width, importdata$Height, sep="*")))


colsh<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))
milky<-rep(NA, length(measurement))

temp0<-importdata$Shades%in%"GR"
green[temp0]<-"带绿"
colsh[temp0]<-"无咖"



temp1<-importdata$Shades%in%c("BR","LB","FB")

colsh[temp1]<-"带咖"
green[temp1]<-"无绿"

temp2<-importdata$Shades%in%"WH"
colsh[temp2]<-"无咖"
green[temp2]<-"无绿"

temp3<-importdata$Milky%in%c("M1","M2")
milky[temp3]<-"带奶"
temp4<-importdata$Milky%in%"NM"
milky[temp4]<-"无奶"


milky[which(!is.na(milky)&is.na(green)&is.na(colsh))]<-NA
colsh[which(is.na(milky)&!is.na(green)&!is.na(colsh))]<-NA
green[which(is.na(milky)&!is.na(green)&!is.na(colsh))]<-NA

rapnetid<-rep("73688", length(measurement))

OPut<-cbind(rapnetid, colsh)

OPut<-cbind(OPut, measurement)

OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/73688.csv",row.names = F)
