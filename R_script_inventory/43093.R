library(reshape)
importdata<-`43093` #导入变量名转换
importdata<-rename(importdata, c(Shape="shape",Color="color",Cut="cut", Polish="polish",Clarity="clarity", Cts="carat", Sym="symmetry", Fluor="fluorescence",Lab="report", Report.No="reportno", Finish.No.="stoneid", Disc="back", Rapa.Rate="rapprice"))

importdata$back<--importdata$back
Diameter<-c(unlist(paste(importdata$Diameter.min., importdata$Diameter.max.,sep=" - ")))
measurement<-c(unlist(paste(Diameter, importdata$Width, importdata$Depth, sep="*")))
rapnetid<-rep(43093, length(measurement))
green<-rep(NA, length(measurement))
milky<-rep(NA, length(measurement))

##############Shade#################
colsh<-rep(NA, length(measurement))
temp1<-importdata$Shade%in%"NB"
colsh[temp1]<-"无咖"
green[temp1]<-"无绿"
temp2<-importdata$Shade%in%"LB"
colsh[temp2]<-"带咖"
green[temp2]<-"无绿"
milky[temp2]<-"无奶"

milk0<-importdata$Milky%in%"NO"
milky[milk0]<-"无奶"
milk1<-importdata$Milky%in%c("MED","SLIGHT")
milky[milk1]<-"带奶"
colsh[milk1]<-"无咖"
green[milk1]<-"无绿"

milky[which(!is.na(green)&!is.na(colsh)&is.na(milky))]<-NA
colsh[which(!is.na(green)&!is.na(colsh)&is.na(milky))]<-NA
green[which(!is.na(green)&!is.na(colsh)&is.na(milky))]<-NA
milky[which(is.na(green)|is.na(colsh)&!is.na(milky))]<-NA


OPut<-cbind(measurement,rapnetid)
OPut<-cbind(OPut, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/43093.csv",row.names = F)

