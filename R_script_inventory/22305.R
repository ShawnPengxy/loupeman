library(reshape)
importdata<-`22305` #���������ת��
importdata<-rename(importdata,c(SHAPE="shape", CARAT="carat",COLOR="color",CLARITY="clarity",CUT="cut",POLISH="polish",SYMMETRY="symmetry",FLUORESENCE="fluorescence",MEASUREMENT="measurement",CERT.TYPE="report",CERTIFICATENO="reportno",STOCKID="stoneid", ONLINE.DISC="back",RAPPRICE="rapprice"))

#��ɫ����
rapnetid<-rep(22305, length(importdata$measurement))
yanse<-as.vector(importdata$TINGE)

colsh<-rep(NA, length(importdata$measurement))
colshh<-c("BROWN", "DARK BROWN")
temp1<-yanse%in%colshh
colsh[temp1]<-"����"
milky[temp1]<-"����"
green[temp1]<-"����"


milky<-rep(NA, length(importdata$measurement))
milkyy<-"MILKY"
temp2<-yanse%in%milkyy
milky[temp2]<-"����"
colsh[temp2]<-"�޿�"
green[temp2]<-"����"


green<-rep(NA, length(importdata$measurement))
greenn<-c("GREEN", "LIGHT GREEN")
temp3<-yanse%in%greenn

milky[temp3]<-"����"
colsh[temp3]<-"�޿�"
green[temp3]<-"����"



OPut<-cbind(colsh, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, rapnetid)
OOPut<-cbind(OPut, importdata)

Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/22305.csv",row.names = F)

