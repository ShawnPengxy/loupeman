library(reshape)
importdata<-`85241` #导入变量名转换
importdata<-rename(importdata, c(MEASUREMENT="measurement",SHAPE="shape",CARAT="carat", COLOR="color",CLARITY="clarity",CUT="cut", POL="polish", SYM="symmetry", FLORE="fluorescence",LAB="report", REPORT.NO="reportno", STOCK.ID="stoneid", DISC="back", RAP="rapprice"))

rapnetid<-rep(85241, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/85241.csv",row.names = F)
