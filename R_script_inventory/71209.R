library(reshape)
importdata<-`71209` #导入变量名转换
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
milky<-matchh("MILKY",comment,"带奶",milky)
milky<-matchh("milky",comment,"带奶",milky)
milky<-matchh("NO MILKY",comment,"无奶",milky)
milky<-matchh("no milky",comment,"无奶",milky)
colsh<-matchh("BROWN",comment, "带咖", colsh)
colsh<-matchh("brown",comment, "带咖", colsh)
colsh<-matchh("NO BROWN",comment,"无咖", colsh)
colsh<-matchh("no brown",comment,"无咖", colsh)
green<-matchh("GREEN",comment, "带绿", green)
green<-matchh("green",comment, "带绿", green)
green<-matchh("NO GREEN",comment,"无绿",green)
green<-matchh("no green",comment,"无绿",green)

colsh[which(!is.na(milky)&is.na(colsh))]<-"无咖"
green[which(!is.na(milky)&is.na(green))]<-"无绿"
milky[which(is.na(milky)&!is.na(colsh))]<-"无奶"
green[which(!is.na(colsh)&is.na(green))]<-"无绿"
colsh[which(is.na(colsh)&!is.na(green))]<-"无咖"
milky[which(is.na(milky)&!is.na(green))]<-"无奶"



OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/71209.csv",row.names = F)
