library(reshape)
importdata<-`68862` #导入变量名转换
importdata<-rename(importdata, c(Measurements="measurement",Sha="shape",Size="carat", Col.="color",Cla.="clarity",Cut="cut", Pol="polish", Sym="symmetry", Fls="fluorescence",Lab="report", Report.No.="reportno", Stock.ID="stoneid", Disc.="back", Rap..Price="rapprice"))


rapnetid<-rep(68862, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
###################Shade##############
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
temp1<-importdata$Shade%in%c("FBR","PNK","VLB","YEL","LYL")
colsh[temp1]<-"带咖"
green[temp1]<-"无绿"
milky[temp1]<-"无奶"
#temp2<-importdata$Shade%in%c("OWH","WHT")
#colsh[temp2]<-"无咖"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/68862.csv",row.names = F)
