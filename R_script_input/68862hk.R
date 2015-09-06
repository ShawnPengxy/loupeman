library(reshape)
importdata<-`68862hk` #导入变量名转换
importdata<-rename(importdata, c(Shade="Shade",Measurements="measurement",Sha="shape",Size="carat", Col.="color",Cla.="clarity",Cut="cut", Pol="polish", Sym="symmetry", Fls="fluorescence",Lab="report", Report.No.="reportno", Stock.ID="stoneid", Disc.="back", Rap..Price="rapprice"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back


rapnetid<-rep("68862hk", length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
price<-rep(NA, length(importdata$measurement))

temp1<-importdata$Shade%in%c("FBR","PNK","VLB","YEL","LYL","LGY","ORB")
colsh[temp1]<-"带咖"
green[temp1]<-"无绿"
milky[temp1]<-"无奶"
temp2<-importdata$Shade%in%c("OWH","WHT","")
colsh[temp2]<-"无咖"
green[temp2]<-"无绿"
milky[temp2]<-"无奶"      
temp3<-importdata$Shade%in%"GRN"
colsh[temp3]<-"无咖"
green[temp3]<-"带绿"
milky[temp3]<-"无奶"


OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)
OOPut<-cbind(OPut, importdata)



Myvars<-c("Shade","shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
index_Fin<-Myvars%in%c("Shade")
Fin<-Fin[!index_Fin]
write.csv(Fin,file="./R_input/68862hk.csv",row.names = F)
