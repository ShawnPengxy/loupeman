library(reshape)
importdata<-`81517` #���������ת��
importdata<-rename(importdata, c(DIAMETER="measurement",SHAPE="shape",CT.="carat", COL="color",CLT="clarity",CUT="cut", PO="polish", SYM="symmetry", FLO="fluorescence",LAB="report", CERTIFICATE="reportno", SR="stoneid",DIS.="back",RAP="rapprice",P.CT="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back
rapnetid<-rep(81517, length(importdata$measurement))

###########################################BMG.COMMNET#################
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))

temp1<-importdata$BMG.COMMNET%in%c("BROWN","BROWN ","FAINT BROWN","VERY LIGHT BROWN","very ligth brown")
colsh[temp1]<-"����"
milky[temp1]<-"����"
green[temp1]<-"����"
temp2<-importdata$BMG.COMMNET%in%c("VERY LIGHT MILKY","VERY VERY LIGHT MILKY")
colsh[temp2]<-"�޿�"
milky[temp2]<-"����"
green[temp2]<-"����"
temp3<-importdata$BMG.COMMNET%in%c("GREEN","VERY LIGHT GREEN")
colsh[temp3]<-"�޿�"
milky[temp3]<-"����"
green[temp3]<-"����"
temp4<-importdata$BMG.COMMNET%in%"NO BROWN,NO GREEN,NO MILKY"
colsh[temp4]<-"�޿�"
milky[temp4]<-"����"
green[temp4]<-"����"


OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)

OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/81517.csv",row.names = F)