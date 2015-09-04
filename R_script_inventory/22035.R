library(reshape)
importdata<-`22035` #导入变量名转换
importdata<-rename(importdata,c(SHAPE="shape", CTS="carat",COLOR="color",CLARITY="clarity",CUT="cut",POL="polish",SYM="symmetry",FLUOR="fluorescence",MEASUREMENT="measurement",LAB="report",CERT.NO="reportno",STK.ID="stoneid", DISC="back",RAPPRICE="rapprice",PRICE="price"))
#importdata<-rename(importdata,c(Shape="shape", Cts="carat",Col="color",Clarity="clarity",Cut="cut",Pol="polish",Sym="symmetry",Fluor="fluorescence",Measurements="measurement",Lab="report",Certificate.No="reportno",Stock.Id="stoneid", N.Dis="back",Rap="rapprice",Per.Cts="price"))
#importdata<-rename(importdata,c(Shape="shape", Carat="carat",COL="color",Clarity="clarity",CUT="cut",POL="polish",SYM="symmetry",FL="fluorescence",MEASUREMENT="measurement",LAB="report",CERT_NO="reportno",Stock.NO="stoneid", Rap.="back",RAP_RTE="rapprice",PR..CT="price"))

rapnetid<-rep("22035", length(importdata$measurement))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

colsh<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
if(F){
index_m1<-importdata$Milky%in%c("M0","NV")
milky[index_m1]<-"无奶"
index_m2<-importdata$Milky%in%c("M1","N2")
milky[index_m2]<-"带奶"
#############处理彩钻颜色########
index_c1<-importdata$color%in%"FANCY"
importdata$color[index_c1]<-importdata$Key.to.Sym[index_c1] 


#颜色处理
rapnetid<-as.numeric(rep(22035, length(importdata$measurement)))
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))

temp1<-importdata$Shade%in%c("BROWN", "D BROWN")
colsh[temp1]<-"带咖"
milky[temp1]<-"无奶"
green[temp1]<-"无绿"
temp2<-importdata$Shade%in%"MILKY"
colsh[temp2]<-"无咖"
milky[temp2]<-"带奶"
green[temp2]<-"无绿"
temp3<-importdata$Shade%in%"NO BGM"
colsh[temp3]<-"无咖"
milky[temp3]<-"无奶"
green[temp3]<-"无绿"
}

  yanse<-as.vector(importdata$TINCH)
  colshh<-c("BROWN", "DARK BROWN")
  temp1<-yanse%in%colshh
  colsh[temp1]<-"带咖"
  milky[temp1]<-"无奶"
  green[temp1]<-"无绿"
milkyy<-"MILKY"
temp2<-yanse%in%milkyy
milky[temp2]<-"带奶"
colsh[temp2]<-"无咖"
green[temp2]<-"无绿"
greenn<-c("GREEN", "LIGHT GREEN")
temp3<-yanse%in%greenn
milky[temp3]<-"无奶"
colsh[temp3]<-"无咖"
green[temp3]<-"带绿"
temp4<-yanse%in%"N/A"
milky[temp4]<-"无奶"
colsh[temp4]<-"无咖"
green[temp4]<-"无绿"



OPut<-cbind(colsh, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, rapnetid)
OOPut<-cbind(OPut, importdata)

Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/22035.csv",row.names = F)


