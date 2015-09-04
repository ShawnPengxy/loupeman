library(reshape)
importdata<-`75583` #���������ת��
importdata<-rename(importdata, c(Shape="shape",Size="carat", Col="color",Cla="clarity",Cut="cut", Pol="polish", Sym="symmetry", Flu="fluorescence",Lab="report", CertificateNo="reportno", StockId="stoneid", List.Disc..="back", RAP...Ct="rapprice",List...Cts="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

measurement<-c(unlist(paste(importdata$L, importdata$W,importdata$D, sep="*")))
rapnetid<-as.numeric(rep("75583", length(measurement)))
colsh<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))
milky<-rep(NA, length(measurement))

milk1<-importdata$Milky%in%"YES"
milky[milk1]<-"����"

milk2<-importdata$Milky%in%c("NO","NO ","NO ")
milky[milk2]<-"����"

temp1<-importdata$Hue%in%c("LB","LB(T)")
colsh[temp1]<-"����"
green[temp1]<-"����"

temp2<-importdata$Hue%in%c("WH","WH(T)")
colsh[temp2]<-"�޿�"
green[temp2]<-"����"

OPut<-cbind(measurement,rapnetid)
OPut<-cbind(OPut, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/75583.csv",row.names = F)