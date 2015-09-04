library(reshape)
importdata<-`70554` #导入变量名转换
importdata<-rename(importdata, c(Measurement="measurement",Shape="shape",Size="carat", Color="color",Clarity="clarity",Cut="cut", Pol="polish", Sym="symmetry", Flr="fluorescence",Lab="report", Cert.No="reportno", Stock.Id="stoneid", Back="back", Rap="rapprice"))


rapnetid<-rep(70554, length(importdata$measurement))

milky<-rep(NA, length(importdata$measurement))
milky1<-importdata$Milky%in%c("M01","M02","M03")
milky[milky1]<-"带奶"
milky2<-importdata$Milky%in%"NN"
milky[milky2]<-"无奶"


############Tinge#####################################

colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
temp1<-importdata$Tinge%in%c("BR","LB","VLB","FB")
colsh[temp1]<-"带咖"
green[temp1]<-"无绿"
temp2<-importdata$Tinge%in%c("GR","LG")
green[temp2]<-"带绿"
colsh[temp2]<-"无咖"
temp3<-importdata$Tinge%in%"NN"
colsh[temp3]<-"无咖"
green[temp3]<-"无绿"

milky[which(!is.na(colsh)&!is.na(green)&is.na(milky))]<-"无奶"
milky[which(is.na(colsh)&is.na(green)&!is.na(milky))]<-NA


OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/70554.csv",row.names = F)
