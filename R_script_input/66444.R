library(reshape)
importdata<-`66444` #导入变量名转换
importdata<-rename(importdata, c(Tng="Tng",Shape="shape",Weight="carat", Col="color",Clrt="clarity",Cut="cut", Pol="polish", Sym="symmetry", Flor="fluorescence",Lab="report", Report.No="reportno", Packet.Id="stoneid", Rap.Dis="back", Rap.Rte="rapprice",Pr.Ct="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

##交换Measurement大小顺序###
minD<-rep(NA, length(importdata$Measurement))
maxD<-rep(NA, length(importdata$Measurement))
countt<-length(importdata$Measurement)
trans<-importdata$Measurement
for(i in 1:countt) {Temp1<-unlist(strsplit(trans[i],"-",fixed = TRUE)); minD[i]<-Temp1[2]; maxD[i]<-Temp1[1]}
Diameter<-c(unlist(paste(minD, maxD,sep=" - ")))
measurement<-c(unlist(paste(Diameter, importdata$Height, sep="*")))

rapnetid<-rep(66444, length(measurement))

##########################Tng##############
milky<-rep(NA, length(measurement))
colsh<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))

  temp1<-importdata$Tng%in%c("DB","LB","VB","MT")
  colsh[temp1]<-"带咖"
  milky[temp1]<-"无奶"
  green[temp1]<-"无绿"
  temp2<-importdata$Tng%in%"-"
  colsh[temp2]<-"无咖"
  milky[temp2]<-"无奶"
  green[temp2]<-"无绿"


OPut<-cbind(measurement,rapnetid)
OPut<-cbind(OPut, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("Tng","shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
index_Fin<-Myvars%in%c("Tng")
Fin<-Fin[!index_Fin]
write.csv(Fin,file="./R_input/66444.csv",row.names = F)
