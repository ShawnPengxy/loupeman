library(reshape)
importdata<-`66658` 
importdata<-rename(importdata, c(MEASUREMENT="measurement",SHAPE="shape",CARAT="carat", COLOR="color",CLARITY="clarity",CUT="cut", POL="polish", SYM="symmetry", FLR="fluorescence",LAB="report", REPORT="reportno", NO="stoneid",DISC="back",RAP="rapprice"))
options(digits=10)
rapnetid<-rep(66658, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
price<-rep(NA, length(importdata$measurement))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)

OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/66658.csv",row.names = F)
