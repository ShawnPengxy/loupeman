library(reshape)
importdata<-`71657` #导入变量名转换
importdata<-rename(importdata, c(Shape="shape",Cts="carat", Color="color",Clarity="clarity",Cut="cut", Polish="polish", Symm="symmetry", Fls="fluorescence",Lab="report", Certi.No="reportno", Ref..No="stoneid",Disc....="back",Rap.Price...="rapprice"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

measurement<-c(unlist(paste(importdata$Length,importdata$Width,importdata$Depth, sep="*")))
rapnetid<-rep(71657, length(measurement))
milky<-rep(NA, length(measurement))
colsh<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))
price<-rep(NA, length(measurement))
#if(F){
  temp1<-importdata$Luster%in%c("M1","M2")
  milky[temp1]<-"带奶"
  temp2<-importdata$Luster%in%"M0"
  milky[temp2]<-"带奶"
  
  temp3<-importdata$Shade%in%"WHITE"
  colsh[temp3]<-"无咖"
  green[temp3]<-"无绿"
  temp4<-importdata$Shade%in%"BROWN"
  colsh[temp4]<-"带咖"
  green[temp4]<-"无绿"
#}


OPut<-cbind(measurement,rapnetid)
OPut<-cbind(OPut, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/71657.csv",row.names = F)
