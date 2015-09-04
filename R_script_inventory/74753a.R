library(reshape)
importdata<-`74753a` #���������ת��
#importdata<-rename(importdata, c(MSRSMNT="measurement",Shape="shape",Weight="carat", Color="color",Clarity="clarity",Cut.Grade="cut", Polish="polish", Symmetry="symmetry", Fluorescence.Intensity="fluorescence",Lab="report", Certificate..="reportno", Stock..="stoneid", RAP.="back", Rap.Price="rapprice",price.cts="price"))
importdata<-rename(importdata, c(�ߴ�="measurement",��״="shape",����="carat", ��ɫ="color",����="clarity",�й�="cut", �׹�="polish", �Գ�="symmetry", ӫ��="fluorescence",֤��="report", ֤�����="reportno", ����="stoneid", �ۿ�="back", ���ʼ۸�="rapprice",�ܼ�="price"))

back<-as.numeric(gsub("%","",importdata$back))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back<--importdata$back


rapnetid<-rep(74753, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
milk1<-importdata$��ɫ%in%"N"
milky[milk1]<-"����"
milk2<-importdata$��ɫ%in%c("M1","M2","M3","M4")
milky[milk2]<-"����"

temp1<-importdata$�̿�%in%c("N","N ")
green[temp1]<-"����"
colsh[temp1]<-"�޿�"
temp2<-importdata$�̿�%in%c("B1", "BRN1", "BRN2", "BRN3", "BRN4","LB")
green[temp2]<-"����"
colsh[temp2]<-"����"
temp3<-importdata$�̿�%in%c("DG", "G", "LG", "MG", "VLG")
green[temp3]<-"����"
colsh[temp3]<-"�޿�"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, back)

OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/74753a.csv",row.names = F)