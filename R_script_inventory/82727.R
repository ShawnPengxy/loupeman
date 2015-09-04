library(reshape)
importdata<-`82727` #���������ת��
importdata<-rename(importdata,c(��״="shape",����="carat", ��ɫ="color", ����="clarity", �й�="cut", ��ĥ="polish",�Գƶ�="symmetry",ӫ��="fluorescence",֤��="report",֤�����="reportno",�����="stoneid", �ۿ�="back",���ʱ���="rapprice"))
measurement<-c(unlist(paste(importdata$̨��, importdata$֤��, sep="*")))
colsh<-rep(NA, length(importdata$shape))
green<-rep(NA, length(importdata$shape))

milky<-rep(NA, length(importdata$shape))



rapnetid<-rep("82727", length(importdata$shape))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, measurement)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/82727.csv",row.names = F)