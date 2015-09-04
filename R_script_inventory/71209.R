library(reshape)
importdata<-`71209` #���������ת��
importdata<-rename(importdata, c(Measurements="measurement",Shape="shape",Weight="carat", Color="color",Clarity="clarity",Cut.Grade="cut", Polish="polish", Symmetry="symmetry", Fluorescence.Intensity="fluorescence",Lab="report", Certificate..="reportno", Stock..="stoneid", Rapnet.Discount.="back", Rap.Price="rapprice"))


rapnetid<-rep(71209, length(importdata$measurement))
######################Cert.comment##########
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
comment<-importdata$Cert.comment
matchh<-function(varr,textt,lth,tinge){
  S_position<-regexpr(varr,textt)
  temp<-S_position%in%"-1"
  tinge[!temp]<-lth
  return(tinge)
}
milky<-matchh("MILKY",comment,"����",milky)
milky<-matchh("milky",comment,"����",milky)
milky<-matchh("NO MILKY",comment,"����",milky)
milky<-matchh("no milky",comment,"����",milky)
colsh<-matchh("BROWN",comment, "����", colsh)
colsh<-matchh("brown",comment, "����", colsh)
colsh<-matchh("NO BROWN",comment,"�޿�", colsh)
colsh<-matchh("no brown",comment,"�޿�", colsh)
green<-matchh("GREEN",comment, "����", green)
green<-matchh("green",comment, "����", green)
green<-matchh("NO GREEN",comment,"����",green)
green<-matchh("no green",comment,"����",green)

colsh[which(!is.na(milky)&is.na(colsh))]<-"�޿�"
green[which(!is.na(milky)&is.na(green))]<-"����"
milky[which(is.na(milky)&!is.na(colsh))]<-"����"
green[which(!is.na(colsh)&is.na(green))]<-"����"
colsh[which(is.na(colsh)&!is.na(green))]<-"�޿�"
milky[which(is.na(milky)&!is.na(green))]<-"����"



OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/71209.csv",row.names = F)