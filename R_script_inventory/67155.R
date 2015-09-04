setwd("D:/")
library(reshape)
importdata<-`67155`
#importdata<-rename(importdata,c(Shape="shape",Carats="carat", Color="color", Clarity="clarity", Cut="cut", Polish="polish",Symm="symmetry",Flour.="fluorescence",Lab="report",Report.No="reportno",Packet.No="stoneid", Disc..="back",Rap..Price="rapprice",Net.Rate="price"))
importdata<-rename(importdata,c(Measurements="measurement",Shape="shape",Carats="carat", Color="color", Clarity="clarity", Cut="cut", Pol="polish",Sym="symmetry",Fluor="fluorescence",Cert="report",Certificate.No="reportno",Packet.Id="stoneid", Rap.Dis="back",Rap.Rte="rapprice",X..Ct="price"))

if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back
#Dia<-c(unlist(paste(importdata$MinDia,importdata$MinDia, sep="-")))
#measurement<-c(unlist(paste(Dia,importdata$Ms2,importdata$Depth.., sep="*")))

colsh<-rep(NA, length(importdata$shape))
green<-rep(NA, length(importdata$shape))
milky<-rep(NA, length(importdata$shape))
rapnetid<-as.numeric(rep("67155", length(importdata$shape)))

if(F){
  temp1<-importdata$Milky%in%c("M1","M2","M3","M4")
  milky[temp1]<-"����"
  temp2<-importdata$Milky%in%c("M0","NONE")
  milky[temp2]<-"����"
  
  temp3<-importdata$Brown%in%c("BR1","BR2","BR3")
  colsh[temp3]<-"����"
  temp4<-importdata$Brown%in%"NONE"
  colsh[temp4]<-"�޿�"
  
  temp5<-importdata$Tint%in%c("G1","G2")
  green[temp5]<-"����"
  temp6<-importdata$Tint%in%"NONE"
  green[temp6]<-"����"
  
}

temp1<-importdata$Tinge%in%c("LB","MB","MS")
colsh[temp1]<-"����"
green[temp1]<-"����"
temp2<-importdata$Tinge%in%""
colsh[temp2]<-"�޿�"
green[temp2]<-"����"

temp3<-importdata$Lustre%in%c("MED_MIL","SL_MIL")
milky[temp3]<-"����"
temp4<-importdata$Lustre%in%c("EX","GD","VG")
milky[temp4]<-"����"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
#OPut<-cbind(OPut, measurement)

OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/67155.csv",row.names = F)