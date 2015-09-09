library(reshape)
importdata<-`98722` #导入变量名转换
#importdata<-rename(importdata, c(Cert.comment="Cert.comment",Measurements="measurement",Shape="shape",Weight="carat", Color="color",Clarity="clarity",Cut.Grade="cut", Polish="polish", Symmetry="symmetry", Fluorescence.Intensity="fluorescence",Lab="report", Certificate..="reportno", Stock..="stoneid", Rapnet.Discount.="back", Rap.Price="rapprice",Cash.price="price"))
importdata<-rename(importdata, c(Cert.comment="Cert.comment",Measurements="measurement",Shape="shape",Weight="carat", Color="color",Clarity="clarity",Cut.Grade="cut", Polish="polish", Symmetry="symmetry", Fluorescence.Intensity="fluorescence",Lab="report", Certificate..="reportno", Stock..="stoneid", Rapnet.Discount.="back", RapNet.Price="rapprice",Cash.price="price"))
importdata$rapprice=gsub(",","",importdata$rapprice)
importdata$price=gsub(",","",importdata$price)

rapnetid<-rep(98722, length(importdata$measurement))
#if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back
back<-as.numeric(sub(pattern = "%", replacement = "", importdata$back))
if(length(which(back>0))>length(which(back<0))) back=-back

########提取Comment中的三色，先找出带色，再用无色的替换
ziduan<-importdata$Cert.comment
last_number<-length(importdata$measurement)
colsh<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))

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

colsh[which(is.na(colsh)&!is.na(milky)|!is.na(green))]<-"无咖"
milky[which(is.na(milky)&!is.na(colsh)|!is.na(green))]<-"无奶"
green[which(is.na(green)&!is.na(colsh)|!is.na(milky))]<-"无绿"

#############添加彩钻###############
index1<-importdata$color%in%"N/A"
importdata$color[index1]<-paste(importdata$Fancy.Color.Intensity[index1],importdata$Fancy.Color.Overtone[index1],importdata$Fancy.Color[index1],sep=" ")

OPut<-cbind(rapnetid, colsh)

OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, back)

OOPut<-cbind(OPut, importdata)



Myvars<-c("Cert.comment","shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
index_Fin<-Myvars%in%c("Cert.comment")
Fin<-Fin[!index_Fin]

write.csv(Fin,file="./R_input/98722.csv",row.names = F)