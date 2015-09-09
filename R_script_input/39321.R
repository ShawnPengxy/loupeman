library(reshape)
importdata<-`39321` #导入变量名转换
importdata<-rename(importdata, c(Measurements="measurement",Shape="shape",Color="color",Cut....Prop.="cut", Pol.="polish",Quality="clarity", Carats="carat", Sym.="symmetry", Fluo.="fluorescence",Cert.="report",Parcel.No.="reportno",Dis.="back", Rap..Price="rapprice"))

#importdata$back<--importdata$back
#measurement<-c(unlist(paste(importdata$Length, importdata$Width, importdata$Depth, sep="*")))
stoneid<-rep("", length(importdata$measurement))
rapnetid<-rep(39321, length(importdata$measurement))

colsh<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
price<-rep(NA, length(importdata$measurement))


OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut,stoneid)
OPut<-cbind(OPut,price)

OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/39321.csv",row.names = F)
