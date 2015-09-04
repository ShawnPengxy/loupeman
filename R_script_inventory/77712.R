library(reshape)
importdata<-`77712` #���������ת��
importdata<-rename(importdata,c(Measurements="measurement",Shape="shape",Cts="carat", Col="color", Clarity="clarity", Cut="cut", Pol="polish",Sym="symmetry",Fluor="fluorescence",Lab="report",Certificate.No="reportno",Stock.Id="stoneid", Dis="back",Rap="rapprice",Per.Cts="price"))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))

milky<-rep(NA, length(importdata$measurement))


temp1<-importdata$Shade%in%c("BROWN", "D BROWN")
colsh[temp1]<-"����"
milky[temp1]<-"����"
green[temp1]<-"����"

temp2<-importdata$Shade%in%"MILKY"
colsh[temp2]<-"�޿�"
milky[temp2]<-"����"
green[temp2]<-"����"

temp0<-importdata$Shade%in%"NO BGM"
colsh[temp0]<-"�޿�"
green[temp0]<-"����"
milky[temp0]<-"����"



rapnetid<-rep("77712", length(importdata$measurement))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/77712.csv",row.names = F)