library(reshape)
importdata<-`32952` #导入变量名转换
importdata<-rename(importdata, c(Shape="shape",Carat="carat", Color="color",Purity="clarity",Cut="cut", Polish="polish", Symmetry="symmetry", Fluoresent="fluorescence",Lab="report", CertificateNo="reportno", PktCode="stoneid", TermsOff="back", RapaportPrice="rapprice",TermsPrice="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

Dia<-c(unlist(paste(importdata$DiameterMinimum, importdata$DiameterMaximum, sep="-")))
measurement<-c(unlist(paste(Dia, importdata$Length, importdata$Width, sep="*")))

rapnetid<-as.numeric(rep("32952", length(measurement)))
green<-rep(NA, length(measurement))
colsh<-rep(NA, length(measurement))
milky<-rep(NA, length(measurement))
  milky<-importdata$Milky
  milk2<-importdata$Milky%in%c("M1","M2","M3")
  milky[milk2]<-"带奶"
  milk3<-importdata$Milky%in%c("L1","L2")
  milky[milk2]<-"无奶"
  
  #################Tinge  only White as no colsh###
  
temp1<-importdata$ColorShade%in%c("BR","FBR","LBR")
colsh[temp1]<-"带咖"
green[temp1]<-"无绿"
  
temp2<-importdata$ColorShade%in%c("GR","LGR")
colsh[temp2]<-"无咖"
green[temp2]<-"带绿"  
  
temp3<-importdata$ColorShade%in%"None"
colsh[temp3]<-"无咖"
green[temp3]<-"无绿"  

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, measurement)


OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/32952.csv",row.names = F)
