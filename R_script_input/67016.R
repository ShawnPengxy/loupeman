setwd("D:/")
library(reshape)
importdata<-`67016`
importdata<-rename(importdata,c(bgm="REMARKS",SHAPE="shape",SIZE="carat", COLOR="color", CLARITY="clarity", CUT="cut", POLISH="polish",SYMM="symmetry",FLU="fluorescence",CERT="report",CERTNO="reportno",ref.num="stoneid", final.disc="back",Rap.Price="rapprice"))

if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

measurement<-c(unlist(paste(importdata$L,importdata$W,importdata$H,sep="*")))

colsh<-rep(NA, length(importdata$shape))
green<-rep(NA, length(importdata$shape))
milky<-rep(NA, length(importdata$shape))
price<-rep(NA, length(importdata$shape))
rapnetid<-as.numeric(rep("67016", length(importdata$shape)))




temp1<-importdata$REMARKS%in%c("No GM No GM","(Color K, FAINT BRoWN)")
colsh[temp1]<-"带咖"
green[temp1]<-"无绿"
milky[temp1]<-"无奶"

temp2<-importdata$REMARKS%in%"No BG"
colsh[temp2]<-"无咖"
green[temp2]<-"无绿"
milky[temp2]<-"带奶"

temp3<-importdata$REMARKS%in%c("No BM","No BM (FLo: MEDIUM GREEN)")
colsh[temp3]<-"无咖"
green[temp3]<-"带绿"
milky[temp3]<-"无奶"

temp3<-importdata$REMARKS%in%c("No BGM","No BGM ","No BGM -Cert Not In Hand")
colsh[temp3]<-"无咖"
green[temp3]<-"无绿"
milky[temp3]<-"无奶"


OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, measurement)
OPut<-cbind(OPut, price)

OOPut<-cbind(OPut, importdata)
Myvars<-c("REMARKS","shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
index_Fin<-Myvars%in%c("REMARKS")
Fin<-Fin[!index_Fin]
write.csv(Fin,file="./R_input/67016.csv",row.names = F)