library(reshape)
importdata<-`94654` #导入变量名转换
importdata<-rename(importdata, c(Measurements="measurement",Shape="shape",Weight="carat", Color="color",Clarity="clarity",Cut.Grade="cut", Polish="polish", Symmetry="symmetry", Fluorescence.Intensity="fluorescence",Lab="report", Certificate..="reportno", Stock..="stoneid", Discount="back", Rapaport="rapprice",Total="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

rapnetid<-rep(94654, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))

temp1<-importdata$Milky%in%"None"
milky[temp1]<-"无奶"
temp2<-importdata$Milky%in%c("Light","Medium")
milky[temp2]<-"带奶"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/94654.csv",row.names = F)
