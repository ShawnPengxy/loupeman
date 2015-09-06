library(reshape)
importdata<-`53277` #导入变量名转换
#importdata<-rename(importdata, c(Tinge="Tinge",L.W.Diam="measurement",Shape="shape",Cts="carat", Color="color",Clar="clarity",Cut="cut", Polish="polish", Symm="symmetry", Fl="fluorescence",Lab="report", Cert.No="reportno", Hopno="stoneid", Disc.="back", Rap.="rapprice"))
importdata<-rename(importdata, c(Tinge="Tinge",Measurement="measurement",Shape="shape",WT="carat", Color="color",Clarity="clarity",Cut="cut", Polish="polish", Symm="symmetry", FLS="fluorescence",Lab="report", Cert.No.="reportno", StoneNo="stoneid", Disc..="back", Rap..="rapprice"))
#importdata$price<-as.numeric(importdata$carat)*as.numeric(importdata$price)


if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

options(digits=10)
rapnetid<-as.numeric(rep("53277", length(importdata$measurement)))
price<-rep(NA, length(importdata$measurement))

####################Tinge  B0 and G0 unknown##############
yanse<-importdata$Tinge
green<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))

#price<-rep(NA, length(importdata$measurement))


milky<-rep("无奶", length(importdata$measurement))
milk1<-yanse%in%c("B1","B2","B3","FB")
colsh[milk1]<-"带咖"
green[milk1]<-"无绿"
milk11<-yanse%in%c("B0")
colsh[milk11]<-"无咖"
green[milk11]<-"无绿"

milk2<-yanse%in%c("G1","G2","G3")
green[milk2]<-"带绿"
colsh[milk2]<-"无咖"
milk22<-yanse%in%c("G0")
green[milk22]<-"无绿"
colsh[milk22]<-"无咖"

milk3<-yanse%in%c("N","N ")
colsh[milk3]<-"无咖"
green[milk3]<-"无绿"

  #############添加彩钻###############
 # index1<-importdata$color%in%c("",NA)
#  importdata$color[index1]<-importdata$Fancy.Color[index1]



OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)

OOPut<-cbind(OPut, importdata)



Myvars<-c("Tinge","shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
index_Fin<-Myvars%in%c("Tinge")
Fin<-Fin[!index_Fin]
write.csv(Fin,file="./R_input/53277.csv",row.names = F)
