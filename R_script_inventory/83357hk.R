library(reshape)
importdata<-`83357hk` #导入变量名转换
importdata<-rename(importdata, c(Shape="shape",Bal.Cts="carat", Color="color",Clarity="clarity",Cut="cut", Polish="polish", Symm="symmetry", Fluo.="fluorescence",Lab="report", Certificate.No="reportno", Lot.ID="stoneid",X....SC3="back", List="rapprice"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back<--importdata$back
importdata$rapprice<-as.numeric(gsub(",","",importdata$rapprice))

measurement<-c(unlist(paste(importdata$Ms1,importdata$Ms2,importdata$Ms3, sep="*")))
rapnetid<-(rep(83357, length(measurement)))
milky<-rep(NA, length(measurement))
colsh<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))
price<-rep(NA, length(measurement))

importdata$shape[which(importdata$shape=="BR")]<-"圆形"

temp2<-importdata$Remark%in%c("Milky\n","Milky","ML","ML-1")
colsh[temp2]<-"无咖"
green[temp2]<-"无绿"
milky[temp2]<-"带奶"

temp2<-importdata$Remark%in%c("Br","BR","Brown","Brown ","Dark br ","DARK BROWN ","Faint Brown")
colsh[temp2]<-"带咖"
green[temp2]<-"无绿"
milky[temp2]<-"无奶"

temp2<-importdata$Remark%in%c("Green")
colsh[temp2]<-"无咖"
green[temp2]<-"带绿"
milky[temp2]<-"无奶"


OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)

OPut<-cbind(OPut, price)

OPut<-cbind(OPut, measurement)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/83357hk.csv",row.names = F)
