library(reshape)
importdata<-`28426` #���������ת��
importdata<-rename(importdata, c(Shape="shape",Color="color",Cut.="cut", Pol="polish",Clarity="clarity", Weight="carat", Sym="symmetry", Fluor..="fluorescence",Lab="report", Cert="reportno", Lot.ID="stoneid", X...Rapnet="back", List="rapprice"))

measurement<-c(unlist(paste(importdata$Ms1, importdata$Ms2, importdata$Ms3, sep="*")))

rapnetid<-rep(28426, length(measurement))
###############Member.Comment##########
colsh<-rep(NA, length(measurement))
milky<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))
matchh<-function(varr,textt,lth,tinge){
  S_position<-regexpr(varr,textt)
  temp<-S_position%in%"-1"
  tinge[!temp]<-lth
  return(tinge)
}
comm<-importdata$Member.Comment
colsh<-matchh("Brown",comm,"����",colsh)
temp1<-colsh%in%"����"
green[temp1]<-"����"
milky[temp1]<-"����"
green<-matchh("Green",comm,"����",green)
temp2<-green%in%"����"
colsh[temp2]<-"�޿�"
milky[temp2]<-"����"
milky<-matchh("Milky",comm,"����",milky)
temp3<-milky%in%"����"
colsh[temp3]<-"�޿�"
green[temp3]<-"����"
colsh<-matchh("NO BGM",comm,"�޿�",colsh)
green<-matchh("NO BGM",comm,"����",green)
milky<-matchh("NO BGM",comm,"����",milky)


OPut<-cbind(measurement, rapnetid)
OPut<-cbind(OPut, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/28426.csv",row.names = F)