library(reshape)
importdata<-`95849` #导入变量名转换
importdata<-rename(importdata, c(SHAPE="shape",SIZE="carat", COLOR="color",CLARITY="clarity",CUT="cut", POLISH="polish", SYMM="symmetry", FLU="fluorescence",CERT="report", CERTNO="reportno", REF.NO="stoneid", Stock.DIS="back", Rap.Price="rapprice"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

measurement<-c(unlist(paste(importdata$L, importdata$W,importdata$D, sep="*")))
rapnetid<-rep(95849, length(measurement))
milky<-rep(NA, length(measurement))
colsh<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))
price<-rep(NA, length(measurement))
temp1<-importdata$REMARKS%in%c("No BGM","NO BGM","No BGM ","no bgm")
milky[temp1]<-"无奶"
colsh[temp1]<-"无咖"
green[temp1]<-"无绿"

OPut<-cbind(measurement,rapnetid)
OPut<-cbind(OPut, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/95849.csv",row.names = F)
