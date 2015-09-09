library(reshape)
importdata<-`92736` #导入变量名转换
importdata<-rename(importdata, c(Brown="Brown",Lust="Lust",Len.Width.Or.Dia="measurement",Shape="shape",Carat="carat",Col="color",Clarity="clarity",Cut="cut", Pol="polish", Sym="symmetry", Flo="fluorescence",Cert="report", Rep.No="reportno", StoneID="stoneid", Off.="back", Rap="rapprice"))
importdata$back<-as.numeric(gsub("%","",importdata$back))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back


rapnetid<-rep(92736, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
price<-rep(NA, length(importdata$measurement))

index1<-importdata$Brown%in%c("BT","LB","MT")
colsh[index1]<-"带咖"
milky[index1]<-"无奶"
green[index1]<-"无绿"
index2<-importdata$Brown%in%c("MLK")
colsh[index2]<-"无咖"
milky[index2]<-"带奶"
green[index2]<-"无绿"
index3<-importdata$Brown%in%c("LG")
colsh[index3]<-"无咖"
milky[index3]<-"无奶"
green[index3]<-"带绿"
index3<-importdata$Brown%in%c("N")
colsh[index3]<-"无咖"
milky[index3]<-"无奶"
green[index3]<-"无绿"


OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)


OOPut<-cbind(OPut, importdata)



Myvars<-c("Brown","Lust","shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
index_Fin<-Myvars%in%c("Brown","Lust")
Fin<-Fin[!index_Fin]
write.csv(Fin,file="./R_input/92736.csv",row.names = F)
