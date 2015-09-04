library(reshape)
importdata<-`51637` 
importdata<-rename(importdata,c(MEASUREMENT="measurement",SHAPE="shape",CRTWT="carat", COL="color", CLR="clarity", CUT="cut", POL="polish",SYM="symmetry",FLOUR="fluorescence",LAB="report",CERT_NO="reportno",Stock.NO="stoneid", RAP_DIS="back",RAP_RTE="rapprice",RTE="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))

  temp3<-importdata$MILK%in%c("M1","M2")
  milky[temp3]<-"带奶"
  
  temp4<-importdata$MILK%in%"M0"
  milky[temp4]<-"无奶"
  if(F){  
  temp0<-importdata$COL.SHADE%in%"WH"
  colsh[temp0]<-"无咖"
  green[temp0]<-"无绿"
  
  temp1<-importdata$COL.SHADE%in%c("BRN1","BRN2","BRN3")
  colsh[temp1]<-"带咖"
  green[temp1]<-"无绿"
  
  temp2<-importdata$COL.SHADE%in%"GRN"
  colsh[temp2]<-"无咖"
  green[temp2]<-"带绿"
}


rapnetid<-as.numeric(rep("51637", length(importdata$measurement)))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/51637.csv",row.names = F)
