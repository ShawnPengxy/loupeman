library(reshape)
importdata<-`90062a` #���������ת��
importdata<-rename(importdata, c(Shape="shape",Carat="carat", Col="color",Clarity="clarity",Cut="cut", Pol="polish", Sym.="symmetry", Flo="fluorescence",Cert="report", Report.No="reportno", Stone.ID="stoneid", RapRate="rapprice"))

measurement<-c(unlist(paste(importdata$Mesurement, importdata$X,importdata$X.1, sep="*")))
back<--importdata$Disc..
rapnetid<-rep(90062, length(measurement))
milky<-rep(NA, length(measurement))
milk1<-importdata$Milky%in%c("FAINT MILKY","MEDIUM MILKY","STRONG MILKY")
milky[milk1]<-"����"
green[milk1]<-"����"
colsh[milk1]<-"�޿�"

milky[!milk1]<-"����"
##################Shd############
colsh<-rep(NA, length(measurement))
temp1<-importdata$Shd%in%c("brown", "light brown","STG BROWN")
colsh[temp1]<-"����"
green[temp1]<-"����"
green<-rep(NA, length(measurement))
temp2<-importdata$Shd%in%c("FNT GREEN", "MED GREEN")
green[temp2]<-"����"
colsh[temp2]<-"�޿�"

milky[which(!is.na(colsh)&!is.na(green)&is.na(milky))]<-"����"
milky[which(is.na(colsh)&is.na(green)&!is.na(milky))]<-NA


OPut<-cbind(measurement,rapnetid)
OPut<-cbind(OPut, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, back)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/90062a.csv",row.names = F)