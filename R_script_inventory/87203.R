library(reshape)
importdata<-`87203` #���������ת��
importdata<-rename(importdata,c(Shape="shape",Size="carat", Color="color", Clarity="clarity", Cut="cut", Polish="polish",Symn="symmetry",Flor="fluorescence",COMT="report",Cert.No.="reportno",Stk.id="stoneid", Back="back",RapaPrice="rapprice"))
measurement<-c(unlist(paste(importdata$Length, importdata$Width, importdata$Height, sep="*")))


colsh<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))
milky<-rep(NA, length(measurement))


temp1<-importdata$Shades%in%c("BR","LB","Light Brown","Faint Brown","Very Light Brown","VLB","VVLB")

colsh[temp1]<-"����"
green[temp1]<-"����"

temp2<-importdata$Shades%in%"-"
colsh[temp2]<-"�޿�"
green[temp2]<-"����"

temp3<-importdata$Milky%in%c("HEAVY","LIGHT","MEDIUM")
milky[temp3]<-"����"
temp4<-importdata$Milky%in%"-"
milky[temp4]<-"����"


milky[which(!is.na(milky)&is.na(green)&is.na(colsh))]<-NA
colsh[which(is.na(milky)&!is.na(green)&!is.na(colsh))]<-NA
green[which(is.na(milky)&!is.na(green)&!is.na(colsh))]<-NA

rapnetid<-rep("87203", length(measurement))

OPut<-cbind(rapnetid, colsh)

OPut<-cbind(OPut, measurement)

OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/87203.csv",row.names = F)