setwd("D:/")
library(reshape)
importdata<-`63050`
importdata<-rename(importdata,c(Measurement="measurement",Shape="shape",Carat="carat", Color="color", Clarity="clarity", Cut="cut", Pol="polish",Sym="symmetry",Flo="fluorescence",Cert="report",Cert.No="reportno",Stone.ID="stoneid", Off..="back"
,Org.Rate="rapprice",Rate...CT="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
rapnetid<-as.numeric(rep("63050", length(importdata$measurement)))

temp1<-importdata$Lust%in%c("ML1","ML2","ML3")
milky[temp1]<-"带奶"
milky[!temp1]<-"无奶"

temp2<-importdata$Brown.Inc%in%c("BT","LB")
colsh[temp2]<-"带咖"
green[temp2]<-"无绿"

temp3<-importdata$Brown.Inc%in%"GT"
colsh[temp3]<-"无咖"
green[temp3]<-"带绿"

temp4<-importdata$Brown.Inc%in%"N"
colsh[temp4]<-"无咖"
green[temp4]<-"无绿"


OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin1<-OOPut[Myvars]
write.csv(Fin1,file="./R_input/63050.csv",row.names = F)