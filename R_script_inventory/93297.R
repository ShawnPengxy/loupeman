library(reshape)
importdata<-`93297` #���������ת��
importdata<-rename(importdata, c(Measurements="measurement",Shape="shape",Weight="carat", Color="color",Clarity="clarity",Cut.Grade="cut", Polish="polish", Symmetry="symmetry", Fluorescence.Intensity="fluorescence",Lab="report", Certificate..="reportno", Stock..="stoneid", Rapnet..Discount..="back", RapNet.Price="rapprice"))
rapnetid<-rep(93297, length(importdata$measurement))

########��ȡComment�е���ɫ�����ҳ���ɫ��������ɫ���滻
ziduan<-importdata$Member.Comment....
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

colsh[which(!is.na(milky)|!is.na(green)&is.na(colsh))]<-"�޿�"
milky[which(!is.na(green)|!is.na(colsh)&is.na(milky))]<-"����"
green[which(!is.na(milky)|!is.na(colsh)&is.na(green))]<-"����"



OPut<-cbind(rapnetid, colsh)

OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/93297.csv",row.names = F)