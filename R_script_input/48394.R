library(reshape)
importdata<-`48394` #���������ת��
importdata<-rename(importdata, c(Measurement="measurement",Shape="shape",Carats="carat", Color="color",Clarity="clarity",Cut="cut", Polish="polish", Symm="symmetry", Fluo.Int="fluorescence",Lab="report", Certificate="reportno", Stone.ID="stoneid", Disc...="back", Rap..="rapprice",Amount.US.="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

rapnetid<-as.numeric(rep("48394", length(importdata$measurement)))
green<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))

milky<-importdata$Milky
milk1<-importdata$Milky%in%"M0"
milky[milk1]<-"����"
milk2<-importdata$Milky%in%c("M1","M2")
milky[milk2]<-"����"

temp1<-importdata$Tinge%in%"White"
colsh[temp1]<-"�޿�"
green[temp1]<-"����"

temp2<-importdata$Tinge%in%c("VLB,LB","VVLB,LB","BR,LB","LBR,LB")
colsh[temp2]<-"����"
green[temp2]<-"����"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/48394.csv",row.names = F)