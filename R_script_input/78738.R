library(reshape)
importdata<-`78738` #���������ת��
importdata<-rename(importdata, c(Diam.="measurement",Shape="shape",Carats="carat", Color="color",Clarity="clarity",Cut="cut", Polish="polish", Sym="symmetry", FL="fluorescence",Cert.="report", Cert.No.="reportno", StockID="stoneid", R.Dn="back", Rap.="rapprice",Rate="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

rapnetid<-rep(78738, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
temp1<-importdata$Shade%in%c(" LIGHT BROWN","DARK BROWN","LIGHT BROWN","MED BROWN")
colsh[temp1]<-"����"
milky[temp1]<-"����"
green[temp1]<-"����"
temp2<-importdata$Shade%in%c("MILKY1","MILKY 1","MILKY2","M1","M2","MILKY")
colsh[temp2]<-"�޿�"
milky[temp2]<-"����"
green[temp2]<-"����"
temp3<-importdata$Shade%in%"LIGHT GREEN"
colsh[temp3]<-"�޿�"
milky[temp3]<-"����"
green[temp3]<-"����"
temp4<-importdata$Shade%in%""
colsh[temp4]<-"�޿�"
milky[temp4]<-"����"
green[temp4]<-"����"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/78738.csv",row.names = F)