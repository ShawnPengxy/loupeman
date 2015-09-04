setwd("D:/")
library(reshape)
importdata<-`88933` #导入变量名转换
importdata<-rename(importdata, c(Measurment="measurement",Shape="shape",Wt="carat",Clarity="clarity",Colour="color",Cut="cut",Polish="polish", Symmetry="symmetry", Fluorecsence="fluorescence", Certificate="report",CertificateNo="reportno", PacketNo="stoneid",Back="back",RapPrice="rapprice",Price="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

rapnetid<-rep(88933, length(importdata$measurement))
############################cmnt###########################
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
#back<-rep(NA, length(importdata$measurement))
#rapprice<-rep(NA, length(importdata$measurement))
if(F){
  importdata$FancyColorOvertone[which(importdata$FancyColorOvertone=="0")]<-""
  color<-paste(importdata$FancyColorIntensity,importdata$FancyColorOvertone,importdata$FancyColor,sep=" ")
  
}

temp1<-importdata$Shade%in%c("DB","LB")
colsh[temp1]<-"带咖"
green[temp1]<-"无绿"
temp2<-importdata$Shade%in%"GREEN"
colsh[temp2]<-"无咖"
green[temp2]<-"带绿"
temp3<-importdata$Shade%in%"White"
colsh[temp3]<-"无咖"
green[temp3]<-"带绿"
temp3<-importdata$Shade%in%"White"

temp4<-importdata$Milky%in%"Non"
milky[temp4]<-"无奶"
temp5<-importdata$Milky%in%c("Faint","Medium","Very Faint")
milky[temp5]<-"带奶"


OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
#OPut<-cbind(OPut, back)
#OPut<-cbind(OPut, rapprice)
#OPut<-cbind(OPut, color)


OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/88933.csv",row.names = F)
