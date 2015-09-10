library(reshape)
importdata<-`77949` #导入变量名转换
#importdata<-rename(importdata,c(BGM="BGM",Measurements="measurement",Shape="shape",Weight="carat", Color="color", Clarity="clarity", Cut="cut", Pol="polish",Sym="symmetry",Flour.="fluorescence",LAB="report",Certifcate="reportno",STONEID="stoneid", Disc..="back",Rap="rapprice"))
importdata<-rename(importdata,c(L...W...H="measurement",Shape="shape",Cts="carat", Col="color", Clrt="clarity", Cut="cut", Pol="polish",Sym="symmetry",Flr="fluorescence",Cert="report",Cert.="reportno",Ref.="stoneid", Disc="back",RAP="rapprice"))

importdata$shape[which(importdata$shape=="RBC")]<-"圆形"
importdata$back<-as.numeric(gsub("\\*","",importdata$back))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

rapnetid<-rep("77949", length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))

milky<-rep(NA, length(importdata$measurement))
price<-rep(NA, length(importdata$measurement))


temp1<-importdata$BGM%in%c("BR","BR ","LB","MB","MT")
colsh[temp1]<-"带咖"
milky[temp1]<-"无奶"
green[temp1]<-"无绿"

temp2<-importdata$BGM%in%"MIL"
colsh[temp2]<-"无咖"
milky[temp2]<-"带奶"
green[temp2]<-"无绿"

temp0<-importdata$BGM%in%c("","-")
colsh[temp0]<-"无咖"
green[temp0]<-"无绿"
milky[temp0]<-"无奶"

temp3<-importdata$BGM%in%"GR"
colsh[temp3]<-"无咖"
milky[temp3]<-"无奶"
green[temp3]<-"带绿"


OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/77949.csv",row.names = F)