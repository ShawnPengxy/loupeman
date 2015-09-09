library(reshape)
importdata<-`68862india` #导入变量名转换
importdata<-rename(importdata, c(Shade="Shade",Shape="shape",Carat="carat", Col="color",Clarity="clarity",Cut="cut", Pol="polish", Sym="symmetry", Fls="fluorescence",Lab="report", Report.No="reportno", Packet.No="stoneid", Disc..="back", Rap....="rapprice"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

measurement<-paste(importdata$Length,importdata$Width,importdata$Depth,sep="*")
rapnetid<-rep("68862india", length(importdata$shape))
milky<-rep(NA, length(importdata$shape))
colsh<-rep(NA, length(importdata$shape))
green<-rep(NA, length(importdata$shape))
price<-rep(NA, length(importdata$shape))

index1<-importdata$Shade%in%c("BR","FN", "FTBR","GY","LBR","LYB","LYL","VGY","VLB","VYB")
colsh[index1]<-"带咖"
green[index1]<-"无绿"
index2<-importdata$Shade%in%c("VGN")
colsh[index2]<-"无咖"
green[index2]<-"带绿"
index3<-importdata$Shade%in%c("-","OWH","WHT")
colsh[index3]<-"无咖"
green[index3]<-"无绿"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)
OPut<-cbind(OPut, measurement)

OOPut<-cbind(OPut, importdata)



Myvars<-c("Shade","shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
index_Fin<-Myvars%in%c("Shade")
Fin<-Fin[!index_Fin]
write.csv(Fin,file="./R_input/68862india.csv",row.names = F)
