library(reshape)
importdata<-`74655` #导入变量名转换
importdata<-rename(importdata, c(Shape="shape",Carats="carat", Color="color",Clarity="clarity",Cut="cut", Polish="polish", Sym="symmetry", Flour="fluorescence",Lab="report", Report.No="reportno", Stone.No="stoneid", Disc..="back", Rap="rapprice"))
importdata$back<-as.numeric(gsub("+ ","",importdata$back))
importdata$back<-as.numeric(gsub("- ","-",importdata$back))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back
importdata$shape[which(importdata$shape=="BR")]<-"圆形"
measurement<-paste(importdata$Length,importdata$Width,importdata$Depth)
rapnetid<-rep(74655, length(importdata$shape))
milky<-rep(NA, length(importdata$shape))
colsh<-rep(NA, length(importdata$shape))
green<-rep(NA, length(importdata$shape))
price<-rep(NA, length(importdata$shape))



OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)
OPut<-cbind(OPut, measurement)


OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/74655.csv",row.names = F)
