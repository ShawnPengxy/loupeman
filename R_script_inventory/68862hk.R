library(reshape)
importdata<-`68862hk` #���������ת��
importdata<-rename(importdata, c(Shade="Shade",Measurements="measurement",Sha="shape",Size="carat", Col.="color",Cla.="clarity",Cut="cut", Pol="polish", Sym="symmetry", Fls="fluorescence",Lab="report", Report.No.="reportno", Stock.ID="stoneid", Disc.="back", Rap..Price="rapprice"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back


rapnetid<-rep("68862hk", length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
price<-rep(NA, length(importdata$measurement))

temp1<-importdata$Shade%in%c("FBR","PNK","VLB","YEL","LYL","LGY","ORB")
colsh[temp1]<-"����"
green[temp1]<-"����"
milky[temp1]<-"����"
temp2<-importdata$Shade%in%c("OWH","WHT","")
colsh[temp2]<-"�޿�"
green[temp2]<-"����"
milky[temp2]<-"����"      
temp3<-importdata$Shade%in%"GRN"
colsh[temp3]<-"�޿�"
green[temp3]<-"����"
milky[temp3]<-"����"


OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/68862hk.csv",row.names = F)