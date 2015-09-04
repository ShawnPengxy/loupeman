library(reshape)
importdata<-`73199` #导入变量名转换
importdata<-rename(importdata, c(M="measurement",SH="shape",WT="carat", CO="color",CL="clarity",X="cut", POL="polish", SYM="symmetry", FLO="fluorescence",CERT="report", GIA.NO="reportno",ID="stoneid", Disc="back", RAP="rapprice",PER.CT="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

rapnetid<-rep(73199, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/73199.csv",row.names = F)
