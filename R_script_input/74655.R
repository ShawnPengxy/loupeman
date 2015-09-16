library(reshape)
importdata<-`74655` #导入变量名转换
importdata<-rename(importdata, c(Shade="Shade",Milky="Milky",Shape="shape",Carats="carat", Color="color",Clarity="clarity",Cut="cut", Polish="polish", Sym="symmetry", Flour="fluorescence",Lab="report", Report.No="reportno", Stone.No="stoneid", Disc..="back", Rap="rapprice"))
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

index1<-importdata$Shade%in%c("","WHITE")
colsh[index1]<-"无咖"
green[index1]<-"无绿"
index2<-importdata$Shade%in%c("BROWN")
colsh[index2]<-"带咖"
green[index2]<-"无绿"
index3<-importdata$Milky%in%c("N0","","NO")
milky[index3]<-"无奶"
index4<-importdata$Milky%in%c("MILKY-1","MILKY-2","YES")
milky[index4]<-"带奶"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)
OPut<-cbind(OPut, measurement)


OOPut<-cbind(OPut, importdata)



Myvars<-c("Milky","Shade","shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
index_Fin<-Myvars%in%c("Milky","Shade")
Fin<-Fin[!index_Fin]
write.csv(Fin,file="./R_input/74655.csv",row.names = F)
