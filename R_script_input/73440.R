library(reshape)
importdata<-`73440` #导入变量名转换
importdata<-rename(importdata, c(Shade="Shade",Shape="shape",Carat="carat", Col="color",Clarity="clarity",Cut="cut", Pol="polish", Sym="symmetry", Fls="fluorescence",Lab="report", Report.No="reportno", Packet.No="stoneid",Disc..="back",Rap....="rapprice"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

measurement<-c(unlist(paste(importdata$Length,importdata$Width,importdata$Depth, sep="*")))
rapnetid<-rep(73440, length(measurement))
###################Shade, only choose WHT as No Colsh################
milky<-rep(NA, length(measurement))
colsh<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))
price<-rep("", length(measurement))

temp1<-importdata$Shade%in%c("WHT","OWH","")
colsh[temp1]<-"无咖"
milky[temp1]<-"无奶"
green[temp1]<-"无绿"
temp2<-importdata$Shade%in%c("GRN")
colsh[temp2]<-"无咖"
milky[temp2]<-"无奶"
green[temp2]<-"带绿"
temp3<-importdata$Shade%in%c("FBR","FN","FTBR","LBR","LBY","LGY","LYB","LYL","ORB","PNK","VGY","VLB","VYB","YEL")
colsh[temp3]<-"带咖"
milky[temp3]<-"无奶"
green[temp3]<-"无绿"

OPut<-cbind(measurement,rapnetid)
OPut<-cbind(OPut, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)
OOPut<-cbind(OPut, importdata)



Myvars<-c("Shade","shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
index_Fin<-Myvars%in%c("Shade")
Fin<-Fin[!index_Fin]
write.csv(Fin,file="./R_input/73440.csv",row.names = F)
