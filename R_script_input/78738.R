library(reshape)
importdata<-`78738` #导入变量名转换
importdata<-rename(importdata, c(Shade="Shade",Diam.="measurement",Shape="shape",Carats="carat", Color="color",Clarity="clarity",Cut="cut", Polish="polish", Sym="symmetry", FL="fluorescence",Cert.="report", Cert.No.="reportno", StockID="stoneid", R.Dn="back", Rap.="rapprice",Rate="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

rapnetid<-rep(78738, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
temp1<-importdata$Shade%in%c(" LIGHT BROWN","DARK BROWN","LIGHT BROWN","MED BROWN","MIXING")
colsh[temp1]<-"带咖"
milky[temp1]<-"无奶"
green[temp1]<-"无绿"
temp2<-importdata$Shade%in%c("MILKY1","MILKY 1","MILKY2","M1","M2","MILKY")
colsh[temp2]<-"无咖"
milky[temp2]<-"带奶"
green[temp2]<-"无绿"
temp3<-importdata$Shade%in%"LIGHT GREEN"
colsh[temp3]<-"无咖"
milky[temp3]<-"无奶"
green[temp3]<-"带绿"
temp4<-importdata$Shade%in%""
colsh[temp4]<-"无咖"
milky[temp4]<-"无奶"
green[temp4]<-"无绿"
temp5<-importdata$Shade%in%"LIGHT BROWN,MILKY1"
colsh[temp5]<-"带咖"
milky[temp5]<-"带奶"
green[temp5]<-"无绿"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("Shade","shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
index_Fin<-Myvars%in%c("Shade")
Fin<-Fin[!index_Fin]
write.csv(Fin,file="./R_input/78738.csv",row.names = F)
