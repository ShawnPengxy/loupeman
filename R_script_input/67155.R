setwd("D:/")
library(reshape)
importdata<-`67155`
#importdata<-rename(importdata,c(Milky="Milky",Brown="Brown",Tint="Tint”,Shape="shape",Carats="carat", Color="color", Clarity="clarity", Cut="cut", Pol="polish",Sym="symmetry",Fluor="fluorescence",CERT="report",Certificate.No="reportno",STKID="stoneid", RapDis="back",RapRate="rapprice",Price.Per.Crt="price"))
importdata<-rename(importdata,c(Tinge="Tinge",Lustre="Luster",Measurements="measurement",Shape="shape",Carats="carat", Color="color", Clarity="clarity", Cut="cut", Pol="polish",Sym="symmetry",Fluor="fluorescence",Cert="report",Certificate.No="reportno",Packet.Id="stoneid", Rap.Dis="back",Rap.Rte="rapprice",X..Ct="price"))

if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back
#Dia<-c(unlist(paste(importdata$MinDia,importdata$MinDia, sep="-")))
#measurement<-c(unlist(paste(Dia,importdata$Ms2,importdata$Depth.., sep="*")))
measurement<-c(unlist(paste(importdata$Length,importdata$Width,importdata$Height,sep="*")))

colsh<-rep(NA, length(importdata$shape))
green<-rep(NA, length(importdata$shape))
milky<-rep(NA, length(importdata$shape))
rapnetid<-as.numeric(rep("67155", length(importdata$shape)))

if(F){
  temp1<-importdata$Milky%in%c("M1","M2","M3","M4")
  milky[temp1]<-"带奶"
  temp2<-importdata$Milky%in%c("M0","NONE")
  milky[temp2]<-"无奶"
  
  temp3<-importdata$Brown%in%c("BR1","BR2","BR3")
  colsh[temp3]<-"带咖"
  temp4<-importdata$Brown%in%"NONE"
  colsh[temp4]<-"无咖"
  
  temp5<-importdata$Tint%in%c("G1","G2")
  green[temp5]<-"带绿"
  temp6<-importdata$Tint%in%"NONE"
  green[temp6]<-"无绿"
  
}

temp1<-importdata$Tinge%in%c("LB","MB","MS")
colsh[temp1]<-"带咖"
green[temp1]<-"无绿"
temp2<-importdata$Tinge%in%""
colsh[temp2]<-"无咖"
green[temp2]<-"无绿"

temp3<-importdata$Luster%in%c("MED_MIL","SL_MIL")
milky[temp3]<-"带奶"
temp4<-importdata$Luster%in%c("EX","GD","VG")
milky[temp4]<-"带奶"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, measurement)

OOPut<-cbind(OPut, importdata)

if(F){
  Myvars<-c("Milky","Brown","Tint","shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
  Fin<-OOPut[Myvars]
  index_Fin<-Myvars%in%c("Milky","Brown","Tint")
  Fin<-Fin[!index_Fin]
}

Myvars<-c("Tinge","Luster","shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
index_Fin<-Myvars%in%c("Tinge","Luster")
Fin<-Fin[!index_Fin]

write.csv(Fin,file="./R_input/67155.csv",row.names = F)