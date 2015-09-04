library(reshape)
importdata<-`80546` #导入变量名转换
#importdata<-rename(importdata, c(Measurement="measurement",Shape="shape",Cts="carat", Col="color",Prty="clarity",Cut="cut", Pol="polish", Symm="symmetry", Flour="fluorescence", Lab="report", Report.No="reportno", Stock..="stoneid", Disc="back", Rap="rapprice",Rate.Ct="price"))
importdata<-rename(importdata, c(Measurement="measurement",SHP="shape",CRT="carat", COL="color",PRTY="clarity",CUT="cut", PO="polish", SY="symmetry", FLO="fluorescence", Lab="report", Report.No="reportno", PKT.NO="stoneid", bck="back", rap="rapprice"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

rapnetid<-rep(80546, length(importdata$measurement))
############################cmnt###########################
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
price<-rep(NA, length(importdata$measurement))###没给price###########

if(F){
temp1<-importdata$cmnt%in%c("br","BR","FAINT BROWN","faint-brown ","LIGHT BROWN","y br","ybr","f-br")
colsh[temp1]<-"带咖"
milky[temp1]<-"无奶"
green[temp1]<-"无绿"
temp2<-importdata$cmnt%in%"MILKY"
milky[temp2]<-"带奶"
colsh[temp2]<-"无咖"
green[temp2]<-"无绿"
temp3<-importdata$cmnt%in%"light green"
green[temp3]<-"带绿"
milky[temp3]<-"无奶"
colsh[temp3]<-"无咖"
temp4<-importdata$cmnt%in%""
green[temp4]<-"无绿"
milky[temp4]<-"无奶"
colsh[temp4]<-"无咖"
}

temp1<-importdata$Comments%in%c("br","BR","f-br","LIGHT BROWN","y br","ybr")
colsh[temp1]<-"带咖"
milky[temp1]<-"无奶"
green[temp1]<-"无绿"
temp4<-importdata$Comments%in%""
green[temp4]<-"无绿"
milky[temp4]<-"无奶"
colsh[temp4]<-"无咖"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)


OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/80546.csv",row.names = F)
