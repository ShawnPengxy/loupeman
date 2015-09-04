library(reshape)
importdata<-`73506` #���������ת��
importdata<-rename(importdata,c(Diam.="measurement",Shape="shape",Carats="carat", Color="color", Clarity="clarity", Cut="cut", Polish="polish",Sym="symmetry",FL="fluorescence",Cert.="report",Cert.No.="reportno",StockID="stoneid", R.Dn="back",Rap.="rapprice"))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))


temp1<-importdata$Shade%in%c("FAINT BROWN","BROWN","LIGHT BROWN", "VERY LIGHT BROWN")

colsh[temp1]<-"����"
green[temp1]<-"����"
milky[temp1]<-"����"

temp2<-importdata$Shade%in%""

colsh[temp2]<-"�޿�"
green[temp2]<-"����"
milky[temp2]<-"����"

rapnetid<-rep("73506", length(importdata$measurement))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/73506.csv",row.names = F)