library(reshape)
importdata<-`93297` #导入变量名转换
importdata<-rename(importdata, c(Measurements="measurement",Shape="shape",Weight="carat", Color="color",Clarity="clarity",Cut.Grade="cut", Polish="polish", Symmetry="symmetry", Fluorescence.Intensity="fluorescence",Lab="report", Certificate..="reportno", Stock..="stoneid", Rapnet..Discount..="back", RapNet.Price="rapprice"))
rapnetid<-rep(93297, length(importdata$measurement))

########提取Comment中的三色，先找出带色，再用无色的替换
ziduan<-importdata$Member.Comment....
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

colsh[which(!is.na(milky)|!is.na(green)&is.na(colsh))]<-"无咖"
milky[which(!is.na(green)|!is.na(colsh)&is.na(milky))]<-"无奶"
green[which(!is.na(milky)|!is.na(colsh)&is.na(green))]<-"无绿"



OPut<-cbind(rapnetid, colsh)

OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/93297.csv",row.names = F)