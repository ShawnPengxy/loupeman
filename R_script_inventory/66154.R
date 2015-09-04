library(reshape)
importdata<-`66154` #���������ת��
importdata<-rename(importdata, c(Measurement="measurement",Shape="shape",Weight="carat", Color="color",Clarity="clarity",Cut="cut", Polish="polish", Symm="symmetry", Flour="fluorescence",Lab="report", CertiNo="reportno", Barcode="stoneid", Disc="back", RapRate="rapprice"))

rapnetid<-rep(66154, length(importdata$measurement))

########��ȡComment�е���ɫ�����ҳ���ɫ��������ɫ���滻
ziduan<-importdata$Comments
last_number<-length(importdata$measurement)
colsh<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))

zongse<-regexpr("Brown", ziduan)
lvse<-regexpr("Green", ziduan)
naise<-regexpr("Milky", ziduan)
for(i in 1:last_number) {if(zongse[i]>0) colsh[i]<-"����";if(lvse[i]>0) green[i]<-"����";if(naise[i]>0) milky[i]<-"����"}


zongse2<-regexpr("No Brown", ziduan)
lvse2<-regexpr("No Green", ziduan)
naise2<-regexpr("No Milky", ziduan)
for(i in 1:last_number) {if(zongse2[i]>0) colsh[i]<-"�޿�";if(lvse2[i]>0) green[i]<-"����";if(naise2[i]>0) milky[i]<-"����"}

#################################################
milky[which(!is.na(colsh)|!is.na(green)&is.na(milky))]<-"����"
colsh[which(!is.na(milky)|!is.na(green)&is.na(colsh))]<-"�޿�"
green[which(!is.na(milky)|!is.na(colsh)&is.na(green))]<-"����"
milky[which(is.na(colsh)&is.na(green)&!is.na(milky))]<-NA
colsh[which(is.na(milky)&is.na(green)&!is.na(colsh))]<-NA
green[which(is.na(milky)&is.na(colsh)&!is.na(green))]<-NA

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/66154.csv",row.names = F)