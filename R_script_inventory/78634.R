library(reshape)
importdata<-`78634` #导入变量名转换
importdata<-rename(importdata, c(measur="measurement",Shape="shape",cts="carat", col="color",cla="clarity",cut="cut", pol="polish", sym="symmetry", flo="fluorescence",lab="report", rapno="reportno", id="stoneid", back="back", rap="rapprice"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

rapnetid<-rep(78634, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
price<-rep(NA, length(importdata$measurement))

milk1<-importdata$milky%in%c("M1","M2","M1 ","M2 ")
milky[milk1]<-"带奶"
milk2<-importdata$milky%in%c("M0","MO","M0 ","MO ")
milky[milk2]<-"无奶"
index1<-importdata$cs%in%c("wh","wh ")
colsh[index1]<-"无咖"
green[index1]<-"无绿"
index2<-importdata$cs%in%c("br ","br1 ","br2 ","br3 ","br","br1","br2","br3")
colsh[index2]<-"带咖"
green[index2]<-"无绿"
index3<-importdata$cs%in%c("gr ","gr1 ","gr2 ","gr3 ","gr","gr1","gr2","gr3")
colsh[index3]<-"无咖"
green[index3]<-"无绿"


importdata$shape[importdata$shape%in%c("RBC ","RBC")]<-"圆形"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)

OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/78634.csv",row.names = F)
