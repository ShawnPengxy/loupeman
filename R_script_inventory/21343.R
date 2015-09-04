library(reshape)
importdata<-`21343` #导入变量名转换
importdata<-rename(importdata,c(Shape="shape",Carat="carat", Color="color", Clarity="clarity", Cut="cut", Pol="polish",Sym="symmetry",Fluor="fluorescence",Certificate="report",Certificate.Number="reportno",Parcel.Name="stoneid", X..Below="back",Rap="rapprice",Rate...ct.="price"))
#缺成色三项

#处理measurement
measurement<-c(unlist(paste(importdata$Meas.1, importdata$Meas.2, importdata$Meas.3, sep="*")))

if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

##################Shade only choose BR TBR GRN TGRN###########
colsh<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))

milky<-rep(NA, length(measurement))

temp3<-importdata$Milky%in%c("ML","SL","VS","VVS")
milky[temp3]<-"带奶"

temp4<-importdata$Milky%in%""
milky[temp4]<-"无奶"

temp1<-importdata$Shade%in%c("BR","TBR")
colsh[temp1]<-"带咖"
green[temp1]<-"无绿"

temp2<-importdata$Shade%in%c("GRN","TGRN","GYGRN")
green[temp2]<-"带绿"
colsh[temp2]<-"无咖"

temp2<-importdata$Shade%in%c("")
green[temp2]<-"无绿"
colsh[temp2]<-"无咖"


rapnetid<-as.numeric(rep("21343", length(measurement)))

OPut<-cbind(measurement, rapnetid)
OPut<-cbind(OPut, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/21343.csv",row.names = F)
