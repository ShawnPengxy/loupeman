library(reshape)
importdata<-`87028` #导入变量名转换
importdata<-rename(importdata, c(MILKY="MILKY",SHADE="SHADE",MEASUREMENTS="measurement",SHAPE="shape",size="carat", COLOR="color",CLARITY="clarity",CUT ="cut", POLISH="polish", SYMMETRY="symmetry", FLUO="fluorescence",LAB="report", CERT.NUM="reportno",STOCK.NUM="stoneid", RAP..="back", Rap.Price="rapprice",TOTAL="price"))
importdata$rapprice<-gsub("\\$","",importdata$rapprice)
importdata$back<-gsub("%","",importdata$back)
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

rapnetid<-rep(87028, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))

index1<-importdata$MILKY%in%"NONE"
milky<-"无奶"
index3<-importdata$SHADE%in%"NONE"
colsh[index3]<-"无咖"
green[index3]<-"无绿"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/87028.csv",row.names = F)