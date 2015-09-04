library(reshape)
importdata<-`46106` #导入变量名转换
importdata<-rename(importdata, c(Diameter="measurement",Shap="shape",Col="color",Cut="cut", Pol="polish",Qua="clarity", Carat="carat", Sym="symmetry", Flor="fluorescence",Certi="report", CerNo="reportno", Lot.Id="stoneid", Diss="back",Rap="rapprice",Pr.Ct="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

rapnetid<-rep(46106,length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
temp0<-importdata$Mlk%in%c("M1","M2","M3","MED")
milky[temp0]<-"带奶"
temp00<-importdata$Mlk%in%"N"
milky[temp00]<-"无奶"

temp1<-importdata$Brown%in%c("BR1","BR2","BR3")
colsh[temp1]<-"带咖"
temp2<-importdata$Brown%in%"N"
colsh[temp2]<-"无咖"

temp3<-importdata$Green%in%"N"
green[temp3]<-"无绿"
green[!temp3]<-"带绿"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/46106.csv",row.names = F)
