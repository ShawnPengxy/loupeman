library(reshape)
importdata<-`66154` #导入变量名转换
importdata<-rename(importdata, c(Measurement="measurement",Shape="shape",Weight="carat", Color="color",Clarity="clarity",Cut="cut", Polish="polish", Symm="symmetry", Flour="fluorescence",Lab="report", CertiNo="reportno", Barcode="stoneid", Disc="back", RapRate="rapprice"))

rapnetid<-rep(66154, length(importdata$measurement))

########提取Comment中的三色，先找出带色，再用无色的替换
ziduan<-importdata$Comments
last_number<-length(importdata$measurement)
colsh<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))

zongse<-regexpr("Brown", ziduan)
lvse<-regexpr("Green", ziduan)
naise<-regexpr("Milky", ziduan)
for(i in 1:last_number) {if(zongse[i]>0) colsh[i]<-"带咖";if(lvse[i]>0) green[i]<-"带绿";if(naise[i]>0) milky[i]<-"带奶"}


zongse2<-regexpr("No Brown", ziduan)
lvse2<-regexpr("No Green", ziduan)
naise2<-regexpr("No Milky", ziduan)
for(i in 1:last_number) {if(zongse2[i]>0) colsh[i]<-"无咖";if(lvse2[i]>0) green[i]<-"无绿";if(naise2[i]>0) milky[i]<-"无奶"}

#################################################
milky[which(!is.na(colsh)|!is.na(green)&is.na(milky))]<-"无奶"
colsh[which(!is.na(milky)|!is.na(green)&is.na(colsh))]<-"无咖"
green[which(!is.na(milky)|!is.na(colsh)&is.na(green))]<-"无绿"
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
