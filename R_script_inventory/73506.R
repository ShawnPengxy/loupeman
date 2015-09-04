library(reshape)
importdata<-`73506` #导入变量名转换
importdata<-rename(importdata,c(Diam.="measurement",Shape="shape",Carats="carat", Color="color", Clarity="clarity", Cut="cut", Polish="polish",Sym="symmetry",FL="fluorescence",Cert.="report",Cert.No.="reportno",StockID="stoneid", R.Dn="back",Rap.="rapprice"))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))


temp1<-importdata$Shade%in%c("FAINT BROWN","BROWN","LIGHT BROWN", "VERY LIGHT BROWN")

colsh[temp1]<-"带咖"
green[temp1]<-"无绿"
milky[temp1]<-"无奶"

temp2<-importdata$Shade%in%""

colsh[temp2]<-"无咖"
green[temp2]<-"无绿"
milky[temp2]<-"无奶"

rapnetid<-rep("73506", length(importdata$measurement))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/73506.csv",row.names = F)