library(reshape)
importdata<-`22225_90990_81888` #���������ת��
importdata<-rename(importdata,c(Measurement="measurement",Shape="shape",Size="carat", Color="color", Clarity="clarity", Cut="cut", Pol="polish",Sym="symmetry",Flr="fluorescence",Lab="report",Cert.No="reportno",Stock.Id="stoneid", Back="back",Rap="rapprice"))

colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))

milky<-rep(NA, length(importdata$measurement))
temp3<-importdata$Milky%in%c("M01","M02","M03")
milky[temp3]<-"����"
colsh[temp3]<-"�޿�"
green[temp3]<-"����"

temp4<-importdata$Milky%in%"NN"
milky[temp4]<-"����"

temp1<-importdata$Shade%in%c("BR","LB")
colsh[temp1]<-"����"
green[temp1]<-"����"

temp2<-importdata$Shade%in%"NN"
green[temp2]<-"����"
colsh[temp2]<-"�޿�"

milky[which(!is.na(green)&!is.na(colsh)&is.na(milky))]<-"����"


rapnetid<-rep("22225.90990.81888", length(importdata$measurement))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/22225_90990_81888.csv",row.names = F)