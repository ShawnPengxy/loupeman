setwd("D:/")
library(reshape)
importdata<-`67016`
importdata<-rename(importdata,c(SHAPE="shape",SIZE="carat", COLOR="color", CLARITY="clarity", CUT="cut", POLISH="polish",SYMM="symmetry",FLU="fluorescence",CERT="report",CERTNO="reportno",REF.NO="stoneid", Stock.DIS="back",Rap.Price="rapprice",Price.P.Ct="price"))

if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

measurement<-c(unlist(paste(importdata$L,importdata$W,importdata$H,sep="*")))

colsh<-rep(NA, length(importdata$shape))
green<-rep(NA, length(importdata$shape))
milky<-rep(NA, length(importdata$shape))
rapnetid<-as.numeric(rep("67016", length(importdata$shape)))




temp1<-importdata$REMARKS%in%c("No GM No GM","(Color K, FAINT BRoWN)")
colsh[temp1]<-"����"
green[temp1]<-"����"
milky[temp1]<-"����"

temp2<-importdata$REMARKS%in%"No BG"
colsh[temp2]<-"�޿�"
green[temp2]<-"����"
milky[temp2]<-"����"

temp3<-importdata$REMARKS%in%c("No BM","No BM (FLo: MEDIUM GREEN)")
colsh[temp3]<-"�޿�"
green[temp3]<-"����"
milky[temp3]<-"����"

temp3<-importdata$REMARKS%in%c("No BGM","No BGM ","No BGM -Cert Not In Hand")
colsh[temp3]<-"�޿�"
green[temp3]<-"����"
milky[temp3]<-"����"


OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, measurement)

OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/67016.csv",row.names = F)