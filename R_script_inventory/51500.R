library(reshape)
importdata<-`51500` #���������ת��
importdata<-rename(importdata,c(��״="shape",����="carat", ��ɫ="color", ����="clarity", �й�="cut", �׹�="polish",�Գ�="symmetry",ӫ��="fluorescence",֤���="reportno",����="stoneid", �ۿ�="back",���ʱ���="rapprice",�ۺ󵥼�="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

Dia<-c(unlist(paste(importdata$��Сֱ��, importdata$���ֱ��, sep=" - ")))
measurement<-c(unlist(paste(Dia, importdata$ͤ���, importdata$̨���, sep="*")))
colsh<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))
milky<-rep(NA, length(measurement))
report<-rep("GIA", length(measurement))########����Ƿ��֤������#######

temp1<-importdata$��%in%c("BR","FTBR")
colsh[temp1]<-"����"
green[temp1]<-"����"

temp2<-importdata$��%in%c("WH","OWH")
colsh[temp2]<-"�޿�"
green[temp2]<-"����"

temp3<-importdata$��%in%c("GNY","GNGR","YLGN")
colsh[temp3]<-"�޿�"
green[temp3]<-"����"

temp3<-importdata$��%in%"ML1"
milky[temp3]<-"����"
temp4<-importdata$��%in%"EX"
milky[temp4]<-"����"




rapnetid<-as.numeric(rep("51500", length(measurement)))



OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, measurement)


OPut<-cbind(OPut, report)

OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/51500.csv",row.names = F)