library(reshape)
importdata<-`74753` #导入变量名转换
#importdata<-rename(importdata, c(MSRSMNT="measurement",Shape="shape",Weight="carat", Color="color",Clarity="clarity",Cut.Grade="cut", Polish="polish", Symmetry="symmetry", Fluorescence.Intensity="fluorescence",Lab="report", Certificate..="reportno", Stock..="stoneid", RAP.="back", Rap.Price="rapprice",price.cts="price"))
importdata<-rename(importdata, c(尺寸="measurement",形状="shape",重量="carat", 颜色="color",净度="clarity",切工="cut", 抛光="polish", 对称="symmetry", 荧光="fluorescence",证书="report", 证书编码="reportno", 编码="stoneid", 折扣="back", 国际价格="rapprice",总价="price"))

importdata$back<-as.numeric(gsub("%","",importdata$back))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back<--importdata$back

rapnetid<-rep(74753, length(importdata$shape))
colsh<-rep(NA, length(importdata$shape))
green<-rep(NA, length(importdata$shape))
milky<-rep(NA, length(importdata$shape))

if(F){
  
  milk1<-importdata$MILKY%in%"N"
  milky[milk1]<-"无奶"
  milk2<-importdata$MILKY%in%c("M1","M2","M3","M4")
  milky[milk2]<-"带奶"
  
  temp1<-importdata$TINGE%in%c("N","N ")
  green[temp1]<-"无绿"
  colsh[temp1]<-"无咖"
  temp2<-importdata$TINGE%in%c("B1", "BRN1", "BRN2", "BRN3", "BRN4","LB")
  green[temp2]<-"无绿"
  colsh[temp2]<-"带咖"
  temp3<-importdata$TINGE%in%c("DG", "G", "LG", "MG", "VLG")
  green[temp3]<-"带绿"
  colsh[temp3]<-"无咖"
}

importdata$shape[which(importdata$shape=="马眼")]<-"马眼形"
importdata$shape[which(importdata$shape=="祖母绿形")]<-"祖母绿"
importdata$shape[which(importdata$shape=="方形")]<-"公主方"
importdata$shape[which(importdata$shape=="水滴")]<-"梨形"

milk1<-importdata$奶色%in%"N"
milky[milk1]<-"无奶"
milk2<-importdata$奶色%in%c("M1","M2","M3","M4")
milky[milk2]<-"带奶"

temp1<-importdata$绿咖%in%c("N","N ")
green[temp1]<-"无绿"
colsh[temp1]<-"无咖"
temp2<-importdata$绿咖%in%c("B1", "BRN1", "BRN2", "BRN3", "BRN4","LB")
green[temp2]<-"无绿"
colsh[temp2]<-"带咖"
temp3<-importdata$绿咖%in%c("DG", "G", "LG", "MG", "VLG")
green[temp3]<-"带绿"
colsh[temp3]<-"无咖"


OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
#OPut<-cbind(OPut, back)

OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/74753.csv",row.names = F)
