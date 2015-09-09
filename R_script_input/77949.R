library(reshape)
importdata<-`77949` #���������ת��
importdata<-rename(importdata,c(BGM="BGM",Measurements="measurement",Shape="shape",Weight="carat", Color="color", Clarity="clarity", Cut="cut", Pol="polish",Sym="symmetry",Flour.="fluorescence",LAB="report",Certifcate="reportno",STONEID="stoneid", Disc..="back",Rap="rapprice"))

importdata$shape[which(importdata$shape=="RBC")]<-"Բ��"
importdata$back<-gsub("%","",importdata$back)
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

rapnetid<-rep("77949", length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))

milky<-rep(NA, length(importdata$measurement))
price<-rep(NA, length(importdata$measurement))


temp1<-importdata$BGM%in%c("BR","BR ","LB","MB","MT")
colsh[temp1]<-"����"
milky[temp1]<-"����"
green[temp1]<-"����"

temp2<-importdata$BGM%in%"MIL"
colsh[temp2]<-"�޿�"
milky[temp2]<-"����"
green[temp2]<-"����"

temp0<-importdata$BGM%in%c("","-")
colsh[temp0]<-"�޿�"
green[temp0]<-"����"
milky[temp0]<-"����"

temp3<-importdata$BGM%in%"GR"
colsh[temp3]<-"�޿�"
milky[temp3]<-"����"
green[temp3]<-"����"


OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/77949.csv",row.names = F)