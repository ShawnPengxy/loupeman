library(reshape)
importdata<-`83357` #导入变量名转换
importdata<-rename(importdata, c(Shape="shape",Bal.Cts="carat", Color="color",Clarity="clarity",Cut="cut", Polish="polish", Symm="symmetry", Fluo.="fluorescence",Lab="report", Certificate.No="reportno", Lot.ID="stoneid",cn="back", List="rapprice",X="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back
importdata$rapprice<-as.numeric(gsub(",","",importdata$rapprice))
importdata$price<-as.numeric(gsub(",","",importdata$price))


measurement<-c(unlist(paste(importdata$Ms1,importdata$Ms2,importdata$Ms3, sep="*")))
rapnetid<-(rep(83357, length(measurement)))
milky<-rep(NA, length(measurement))
colsh<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))

importdata$shape[which(importdata$shape=="BR")]<-"圆形"


temp2<-importdata$Tinge%in%"Brown"
colsh[temp2]<-"带咖"
green[temp2]<-"无绿"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)

OPut<-cbind(OPut, measurement)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/83357.csv",row.names = F)
