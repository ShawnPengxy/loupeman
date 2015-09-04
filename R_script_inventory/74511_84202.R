library(reshape)
importdata<-`74511_84202` #导入变量名转换
importdata<-rename(importdata, c(MEASUREMENT="measurement",SHAPE="shape",CRTWT="carat", COL="color",CLR="clarity",CUT="cut", POL="polish", SYM="symmetry", FLOURESENCE="fluorescence",LAB="report", CERT_NO="reportno", Packet.No="stoneid", RAP_DIS="back", RAP_RTE="rapprice",RTE="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back


rapnetid<-rep(74511.84202, length(importdata$measurement))
##########################Member.Comment##################
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
comment<-importdata$Member.Comment
matchh<-function(varr,textt,lth,tinge){
  S_position<-regexpr(varr,textt)
  temp<-S_position%in%"-1"
  tinge[!temp]<-lth
  return(tinge)
}
milky<-matchh("Milky",comment,"带奶",milky)
milky<-matchh("No Milky",comment,"无奶",milky)
colsh<-matchh("Brown",comment, "带咖", colsh)
colsh<-matchh("No Brown",comment,"无咖", colsh)
green<-matchh("Green",comment, "带绿", green)
green<-matchh("No Green",comment,"无绿",green)



OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/74511_84202.csv",row.names = F)
