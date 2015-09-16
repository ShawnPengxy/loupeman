library(reshape)
importdata<-`94654` #导入变量名转换
importdata<-rename(importdata, c(Cert.comment="Cert.comment",Milky="Milky",Measurements="measurement",Shape="shape",Weight="carat", Color="color",Clarity="clarity",Cut.Grade="cut", Polish="polish", Symmetry="symmetry", Fluorescence="fluorescence",Lab="report", Certificate..="reportno", Stock..="stoneid", Back="back", rapaport="rapprice"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

rapnetid<-rep(94654, length(importdata$measurement))
ziduan<-importdata$Cert.comment
last_number<-length(importdata$measurement)
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
price<-rep(NA, length(importdata$measurement))

zongse<-regexpr("BROWN", ziduan)
lvse<-regexpr("GREEN", ziduan)
naise<-regexpr("MILKY", ziduan)
for(i in 1:last_number) {if(zongse[i]>0) colsh[i]<-"带咖";if(lvse[i]>0) green[i]<-"带绿";if(naise[i]>0) milky[i]<-"带奶"}

zongse<-regexpr("brown", ziduan)
lvse<-regexpr("green", ziduan)
naise<-regexpr("milky", ziduan)
for(i in 1:last_number) {if(zongse[i]>0) colsh[i]<-"带咖";if(lvse[i]>0) green[i]<-"带绿";if(naise[i]>0) milky[i]<-"带奶"}

zongse2<-regexpr("NO BGM", ziduan)
lvse2<-regexpr("NO BGM", ziduan)
naise2<-regexpr("NO BGM", ziduan)
for(i in 1:last_number) {if(zongse2[i]>0) colsh[i]<-"无咖";if(lvse2[i]>0) green[i]<-"无绿";if(naise2[i]>0) milky[i]<-"无奶"}

zongse2<-regexpr("no bgm", ziduan)
lvse2<-regexpr("no bgm", ziduan)
naise2<-regexpr("no bgm", ziduan)
for(i in 1:last_number) {if(zongse2[i]>0) colsh[i]<-"无咖";if(lvse2[i]>0) green[i]<-"无绿";if(naise2[i]>0) milky[i]<-"无奶"}

index1<-importdata$Cert.comment%in%""
colsh[index1]<-"无咖"
milky[index1]<-"无奶"
green[index1]<-"无绿"

temp1<-importdata$Milky%in%"None"
milky[temp1]<-"无奶"
temp2<-importdata$Milky%in%c("Light","Medium")
milky[temp2]<-"带奶"

colsh[which(is.na(colsh)&!is.na(milky)|!is.na(green))]<-"无咖"
milky[which(is.na(milky)&!is.na(colsh)|!is.na(green))]<-"无奶"
green[which(is.na(green)&!is.na(colsh)|!is.na(milky))]<-"无绿"



OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)

OOPut<-cbind(OPut, importdata)



Myvars<-c("Cert.comment","Milky","shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
index_Fin<-Myvars%in%c("Milky","Cert.comment")
Fin<-Fin[!index_Fin]
write.csv(Fin,file="./R_input/94654.csv",row.names = F)
