library(reshape)
importdata<-`71560` #���������ת��
importdata<-rename(importdata,c(Shape="shape",Weight="carat", Color="color", Clarity="clarity", Cut="cut", Pol="polish",Sym="symmetry",Fluor="fluorescence",Lab="report",Certificate.="reportno",Stock..="stoneid", Rap.Price="rapprice"))
A<-sub("%","",importdata$Disc)
back<-as.numeric(A)
measurement<-c(unlist(paste(importdata$Length, importdata$Width, importdata$Height, sep="*")))


colsh<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))
milky<-rep(NA, length(measurement))


temp1<-importdata$Shades%in%c("BRN","LBR","VLBR")

colsh[temp1]<-"����"
green[temp1]<-"����"
milky[temp1]<-"����"

temp2<-importdata$Shades%in%c("NO BGM","NO BGM ")
colsh[temp2]<-"�޿�"
green[temp2]<-"����"
milky[temp2]<-"����"

temp3<-importdata$Shades%in%"VLGRN"
colsh[temp3]<-"�޿�"
green[temp3]<-"����"
milky[temp3]<-"����"

temp4<-importdata$Shades%in%c("MLK","VLMLK")
colsh[temp4]<-"�޿�"
green[temp4]<-"����"    
milky[temp4]<-"����"

milky[which(!is.na(milky)&is.na(green)&is.na(colsh))]<-NA
colsh[which(is.na(milky)&!is.na(green)&!is.na(colsh))]<-NA
green[which(is.na(milky)&!is.na(green)&!is.na(colsh))]<-NA

rapnetid<-rep("71560", length(measurement))

OPut<-cbind(rapnetid, colsh)

OPut<-cbind(OPut, measurement)
OPut<-cbind(OPut, back)

OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/71560.csv",row.names = F)