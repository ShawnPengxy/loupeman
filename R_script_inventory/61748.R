library(reshape)
importdata<-`61748` #导入变量名转换
importdata<-rename(importdata,c(DIAM="measurement",SHAPE="shape",WEIGHT="carat", COLOR="color", CLARITY="clarity", CUT="cut", POLISH="polish",SYMM="symmetry",FLOUR="fluorescence",CERT="report",CERTNO="reportno",REFNO="stoneid", DISCOUNT="back",RAP.PRICE="rapprice"))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))

milky<-rep(NA, length(importdata$measurement))


temp1<-importdata$SHADE%in%c("BR","FAINT BROWN","FB", "VERY LIGHT BROWN")

colsh[temp1]<-"带咖"
green[temp1]<-"无绿"
milky[temp1]<-"无奶"

temp2<-importdata$SHADE%in%""
colsh[temp2]<-"无咖"
green[temp2]<-"无绿"
temp3<-importdata$MILKY%in%c("M01","M02","M03","M04")
milky[temp3]<-"带奶"
temp4<-importdata$MILKY%in%""
milky[temp4]<-"无奶"


milky[which(!is.na(milky)&is.na(green)&is.na(colsh))]<-NA
colsh[which(is.na(milky)&!is.na(green)&!is.na(colsh))]<-NA
green[which(is.na(milky)&!is.na(green)&!is.na(colsh))]<-NA

rapnetid<-rep("61748", length(importdata$measurement))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/61748.csv",row.names = F)
