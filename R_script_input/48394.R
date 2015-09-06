library(reshape)
importdata<-`48394` #导入变量名转换
importdata<-rename(importdata, c(Tinge="Tinge",Milky="Milky",Measurement="measurement",Shape="shape",Carats="carat", Color="color",Clarity="clarity",Cut="cut", Polish="polish", Symm="symmetry", Fluo.Int="fluorescence",Lab="report", Certificate="reportno", Stone.ID="stoneid", Disc..="back", Rap..="rapprice",Amount.U.="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

rapnetid<-as.numeric(rep("48394", length(importdata$measurement)))
green<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))

milky<-importdata$Milky
milk1<-importdata$Milky%in%"M0"
milky[milk1]<-"无奶"
milk2<-importdata$Milky%in%c("M1","M2")
milky[milk2]<-"带奶"

temp1<-importdata$Tinge%in%"White"
colsh[temp1]<-"无咖"
green[temp1]<-"无绿"

temp2<-importdata$Tinge%in%c("VLB,LB","VVLB,LB","BR,LB","LBR,LB")
colsh[temp2]<-"带咖"
green[temp2]<-"无绿"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("Milky","Tinge","shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
index_Fin<-Myvars%in%c("Milky","Tinge")
Fin<-Fin[!index_Fin]
write.csv(Fin,file="./R_input/48394.csv",row.names = F)
