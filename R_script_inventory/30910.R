library(reshape)
importdata<-`30910`
importdata<-rename(importdata, c(MEASUREMENT="measurement",SH="shape",CO="color",CT="cut", PO="polish",PU="clarity", CRTWT="carat", SY="symmetry", FL="fluorescence",CERT="report", CERT.NO.="reportno", Stock.NO.="stoneid", Rap_Disc="back", Rap.Vlu="rapprice"))

rapnetid<-rep(30910, length(importdata$polish))

colsh<-rep(NA, length(importdata$polish))
milky<-rep(NA, length(importdata$polish))
green<-rep(NA, length(importdata$polish))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)

Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/30910.csv",row.names = F)
