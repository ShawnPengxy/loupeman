library(reshape)
importdata<-`67551` #���������ת��
importdata<-rename(importdata, c(Milky="Milky",SH="SH",MM="measurement",Shape="shape",Cts="carat", Col="color",Cla="clarity",Cut="cut", Pol="polish", Sym="symmetry", Fluo="fluorescence",Lab="report", CertNo="reportno", Ref.No="stoneid", Disc="back", RapPrice="rapprice"))
importdata$back<-as.numeric(gsub("%","",importdata$back))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back


rapnetid<-rep(67551, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
price<-rep(NA, length(importdata$measurement))

index1<-importdata$Milky%in%c("","-","M0")
milky[index1]<-"����"
index2<-importdata$Milky%in%c("M1","M2","M3")
milky[index2]<-"����"
index3<-importdata$SH%in%c("BROWN","FAINT BROWN","LIGHT BROWN","MIX","YL")
colsh[index3]<-"����"
green[index3]<-"����"
index4<-importdata$SH%in%c("GR")
colsh[index4]<-"�޿�"
green[index4]<-"����"
index5<-importdata$SH%in%c("NONE","WH","-","")
colsh[index5]<-"�޿�"
green[index5]<-"����"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)


OOPut<-cbind(OPut, importdata)



Myvars<-c("SH","Milky","shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
index_Fin<-Myvars%in%c("SH","Milky")
Fin<-Fin[!index_Fin]
write.csv(Fin,file="./R_input/67551.csv",row.names = F)