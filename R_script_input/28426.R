library(reshape)
importdata<-`28426` #导入变量名转换
importdata<-rename(importdata, c(Shape="shape",Color="color",Cut.="cut", Pol="polish",Clarity="clarity", Weight="carat", Sym="symmetry", Fluor..="fluorescence",Lab="report", Cert="reportno", Lot.ID="stoneid", X..="back", List="rapprice"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back
importdata$shape[which(importdata$shape=="BR")]<-"圆形"
importdata$shape[which(importdata$shape=="RAD")]<-"雷迪恩形"

measurement<-c(unlist(paste(importdata$Ms1, importdata$Ms2, importdata$Ms3, sep="*")))

rapnetid<-rep(28426, length(measurement))
###############Member.Comment##########
colsh<-rep(NA, length(measurement))
milky<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))
price<-rep(NA, length(measurement))

matchh<-function(varr,textt,lth,tinge){
  S_position<-regexpr(varr,textt)
  temp<-S_position%in%"-1"
  tinge[!temp]<-lth
  return(tinge)
}
comm<-importdata$Member.Comment
colsh<-matchh("Brown",comm,"带咖",colsh)
temp1<-colsh%in%"带咖"
green[temp1]<-"无绿"
milky[temp1]<-"无奶"
green<-matchh("Green",comm,"带绿",green)
temp2<-green%in%"带绿"
colsh[temp2]<-"无咖"
milky[temp2]<-"无奶"
milky<-matchh("Milky",comm,"带奶",milky)
temp3<-milky%in%"带奶"
colsh[temp3]<-"无咖"
green[temp3]<-"无绿"
colsh<-matchh("NO BGM",comm,"无咖",colsh)
green<-matchh("NO BGM",comm,"无绿",green)
milky<-matchh("NO BGM",comm,"无奶",milky)


OPut<-cbind(measurement, rapnetid)
OPut<-cbind(OPut, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)

OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/28426.csv",row.names = F)
