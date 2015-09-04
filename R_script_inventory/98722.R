library(reshape)
importdata<-`98722` #���������ת��
importdata<-rename(importdata, c(Measurements="measurement",Shape="shape",Weight="carat", Color="color",Clarity="clarity",Cut.Grade="cut", Polish="polish", Symmetry="symmetry", Fluorescence.Intensity="fluorescence",Lab="report", Certificate..="reportno", Stock..="stoneid", Rapnet.Discount.="back", Rap.Price="rapprice",Cash.price="price"))
importdata$rapprice=gsub(",","",importdata$rapprice)
importdata$price=gsub(",","",importdata$price)

rapnetid<-rep(98722, length(importdata$measurement))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back
back<-as.numeric(sub(pattern = "%", replacement = "", importdata$back))
if(length(which(back>0))>length(which(back<0))) back=-back

########��ȡComment�е���ɫ�����ҳ���ɫ��������ɫ���滻
ziduan<-importdata$Cert.comment
last_number<-length(importdata$measurement)
colsh<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))

zongse<-regexpr("BROWN", ziduan)
lvse<-regexpr("GREEN", ziduan)
naise<-regexpr("MILKY", ziduan)
for(i in 1:last_number) {if(zongse[i]>0) colsh[i]<-"����";if(lvse[i]>0) green[i]<-"����";if(naise[i]>0) milky[i]<-"����"}

zongse<-regexpr("brown", ziduan)
lvse<-regexpr("green", ziduan)
naise<-regexpr("milky", ziduan)
for(i in 1:last_number) {if(zongse[i]>0) colsh[i]<-"����";if(lvse[i]>0) green[i]<-"����";if(naise[i]>0) milky[i]<-"����"}

zongse2<-regexpr("NO BGM", ziduan)
lvse2<-regexpr("NO BGM", ziduan)
naise2<-regexpr("NO BGM", ziduan)
for(i in 1:last_number) {if(zongse2[i]>0) colsh[i]<-"�޿�";if(lvse2[i]>0) green[i]<-"����";if(naise2[i]>0) milky[i]<-"����"}

zongse2<-regexpr("no bgm", ziduan)
lvse2<-regexpr("no bgm", ziduan)
naise2<-regexpr("no bgm", ziduan)
for(i in 1:last_number) {if(zongse2[i]>0) colsh[i]<-"�޿�";if(lvse2[i]>0) green[i]<-"����";if(naise2[i]>0) milky[i]<-"����"}

#############���Ӳ���###############
index1<-importdata$color%in%"N/A"
importdata$color[index1]<-paste(importdata$Fancy.Color.Intensity[index1],importdata$Fancy.Color.Overtone[index1],importdata$Fancy.Color[index1],sep=" ")

OPut<-cbind(rapnetid, colsh)

OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, back)

OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/98722.csv",row.names = F)