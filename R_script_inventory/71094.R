library(reshape)
importdata<-`71094` #导入变量名转换
importdata<-rename(importdata,c(Measurement="measurement",Shape="shape",Carat="carat", Color="color", Clarity="clarity", Cut="cut", Pol="polish",Sym="symmetry",Flo="fluorescence",Cert="report",Cert..No="reportno",Stone.ID="stoneid",Rap="rapprice"))
back<--importdata$R..Off..

colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))

milky<-rep(NA, length(importdata$measurement))


temp1<-importdata$SHADE%in%c("BT","LB")

colsh[temp1]<-"带咖"
green[temp1]<-"无绿"
milky[temp1]<-"无奶"

temp2<-importdata$SHADE%in%"N"
colsh[temp2]<-"无咖"

colsh[which(is.na(milky)&is.na(green)&!is.na(colsh))]<-NA
rapnetid<-rep("71094", length(importdata$measurement))

OPut<-cbind(rapnetid, colsh)

OPut<-cbind(OPut, back)


OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/71094.csv",row.names = F)