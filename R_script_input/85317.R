library(reshape)
importdata<-`85317` #导入变量名转换
importdata<-rename(importdata, c(Shape="shape",size="carat", GIA="color",X="clarity",Final.Cut="cut", Polish="polish", sym="symmetry", Fluor="fluorescence",Report.No="reportno", sr.no.="stoneid", Discount="back", Rap="rapprice"))
importdata$rapprice<-as.numeric(gsub("\\$","",importdata$rapprice))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

measurement<-paste(importdata$Length,importdata$Width,importdata$Depth,sep="*")
rapnetid<-rep(85317, length(importdata$shape))
milky<-rep(NA, length(importdata$shape))
colsh<-rep(NA, length(importdata$shape))
green<-rep(NA, length(importdata$shape))

price<-rep(NA, length(importdata$shape))
report<-rep("GIA", length(importdata$shape))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)
OPut<-cbind(OPut, measurement)
OPut<-cbind(OPut, report)

OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/85317.csv",row.names = F)
