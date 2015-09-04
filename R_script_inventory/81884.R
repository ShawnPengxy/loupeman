library(reshape)
importdata<-`81884` #���������ת��
importdata<-rename(importdata, c(Measurements="measurement",Shp="shape",Crt="carat", Col="color",Cla="clarity",Cut="cut", Pol="polish", Sym="symmetry", Flour="fluorescence",Lab="report", Certificate.="reportno", Stk.Id="stoneid", Disc.="back", Rap="rapprice"))

rapnetid<-rep(81884, length(importdata$measurement))
###############comment��####################
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
temp1<-importdata$Comment%in%c("BROWN ","FAINT BROWN ","VERY LIGHT BROWN ", "LIGHT BROWN ")
colsh[temp1]<-"����"
milky[temp1]<-"����"
green[temp1]<-"����"
temp2<-importdata$Comment%in%c("NO BGM","NO BGM ")
milky[temp2]<-"����"
colsh[temp2]<-"�޿�"
green[temp2]<-"����"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/81884.csv",row.names = F)