library(reshape)
importdata<-`78089` #���������ת��
importdata<-rename(importdata, c(Measurments="measurement",Shape="shape",Carats="carat", Color="color",Clarity="clarity",Cut="cut", Polish="polish", Symmetry="symmetry", Flourosence="fluorescence",Certificate="report", Report.NO="reportno", Stock.No="stoneid", Dis..="back", Rap.Rate="rapprice"))

rapnetid<-rep(78089, length(importdata$measurement))
######################Comment######################
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
temp1<-importdata$Comments%in%"It's Brown, No Green, No Zimba, No Milky"
colsh[temp1]<-"����"
milky[temp1]<-"����"
green[temp1]<-"����"
temp2<-importdata$Comments%in%"No Brown, No Green, No Zimba, It's Milky"
milky[temp2]<-"����"
colsh[temp2]<-"�޿�"
green[temp2]<-"����"
temp3<-importdata$Comments%in%"No Brown, No Green, No Zimba, No Milky"
colsh[temp3]<-"�޿�"
milky[temp3]<-"����"
green[temp3]<-"����"


OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/78049.csv",row.names = F)