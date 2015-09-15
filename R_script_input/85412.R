library(reshape)
importdata<-`85412` #导入变量名转换
importdata<-rename(importdata, c(Len.Width.Or.Dia="measurement",Shape="shape",Carat="carat", Col="color",Clarity="clarity",Cut="cut", Pol="polish", Sym="symmetry", Flo="fluorescence",Cert="report", Rep.No="reportno", StoneID="stoneid",Off.="back", Rap="rapprice"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

rapnetid<-rep(85412, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
price<-rep(NA, length(importdata$measurement))
temp1<-importdata$Brown%in%"N"
#colsh[temp1]<-"无咖"
colsh[!temp1]<-"带咖"
milky[!temp1]<-"无奶"
green[!temp1]<-"无绿"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/85412.csv",row.names = F)
