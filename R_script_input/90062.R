setwd("D:/")
library(reshape)
importdata<-`90062` #导入变量名转换
importdata<-rename(importdata, c(Shape="shape",Carat="carat", Col="color",Clarity="clarity",Cut="cut", Pol="polish", Sym.="symmetry", Flo="fluorescence",Cert="report", Report.No="reportno", Disc..="back",RapRate="rapprice",Stone.ID="stoneid",Total.Amount..="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back
measurement<-unlist(paste(importdata$Mesurement,importdata$X,importdata$X.1,sep = "*"))
#importdata$price<-as.numeric(importdata$price)*as.numeric(importdata$carat)
rapnetid<-rep(90062, length(importdata$shape))

milky<-rep(NA, length(importdata$shape))
colsh<-rep(NA, length(importdata$shape))
green<-rep(NA, length(importdata$shape))

temp1<-importdata$Milky%in%c("light milky","milky","STRONG MILKY")
milky[temp1]<-"带奶"
temp2<-importdata$Milky%in%""
milky[temp2]<-"无奶"

temp3<-importdata$Shd%in%c("brown","light brown","STG BROWN")
colsh[temp3]<-"带咖"
green[temp3]<-"无绿"
temp4<-importdata$Shd%in%c("FNT GREEN","MED GREEN")
colsh[temp4]<-"无咖"
green[temp4]<-"带绿"
temp5<-importdata$Shd%in%""
colsh[temp5]<-"无咖"
green[temp5]<-"无绿"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, measurement)

OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/90062.csv",row.names = F)
