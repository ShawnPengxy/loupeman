library(reshape)
importdata<-`81517` #导入变量名转换
#importdata<-rename(importdata, c(BMG.COMMNET="BMG.COMMNET",DIAMETER="measurement",SH="shape",CT.="carat", COL="color",CLT="clarity",CUT="cut", PO="polish", SYM="symmetry", FLO="fluorescence",Lab="report", CERTIFICTE="reportno", M.ID="stoneid",FINAL="back",NEW.RAP="rapprice"))
importdata<-rename(importdata, c(DIAMETER="measurement",SH="shape",CT.="carat", COL="color",CLT="clarity",CUT="cut", PO="polish", SYM="symmetry", FLO="fluorescence",Lab="report", CERTIFICTE="reportno", M.ID="stoneid",R.P="back",NEW.RAP="rapprice"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back
rapnetid<-rep(81517, length(importdata$measurement))

###########################################BMG.COMMNET#################
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
price<-rep(NA, length(importdata$measurement))

if(F){
temp1<-importdata$BMG.COMMNET%in%c("BROWN","BROWN ","FAINT BROWN","VERY LIGHT BROWN","very ligth brown")
colsh[temp1]<-"带咖"
milky[temp1]<-"无奶"
green[temp1]<-"无绿"
temp2<-importdata$BMG.COMMNET%in%c("VERY LIGHT MILKY","VERY VERY LIGHT MILKY")
colsh[temp2]<-"无咖"
milky[temp2]<-"带奶"
green[temp2]<-"无绿"
temp3<-importdata$BMG.COMMNET%in%c("GREEN","VERY LIGHT GREEN")
colsh[temp3]<-"无咖"
milky[temp3]<-"无奶"
green[temp3]<-"带绿"
temp4<-importdata$BMG.COMMNET%in%"NO BROWN,NO GREEN,NO MILKY"
colsh[temp4]<-"无咖"
milky[temp4]<-"无奶"
green[temp4]<-"无绿"
}

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)

OOPut<-cbind(OPut, importdata)

if(F){
  Myvars<-c("BMG.COMMNET","shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
  Fin<-OOPut[Myvars]
  index_Fin<-Myvars%in%c("BMG.COMMNET")
  Fin<-Fin[!index_Fin]
}

Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/81517.csv",row.names = F)
