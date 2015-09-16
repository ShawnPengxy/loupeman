setwd("D:/")
library(reshape)
importdata<-`43460`
importdata<-rename(importdata,c(Milky="Milky",Brownish="Brownish",Measurement="measurement",Shape="shape",Weight="carat", Color="color", Clarity="clarity", Cut="cut", Pol="polish",Sym="symmetry",Flu="fluorescence",Lab="report",Cert.No="reportno",Item.No="stoneid", Dis...="back",RRate="rapprice",Price.ct="price"))
#importdata<-rename(importdata,c(Milky="Milky",ColInt="ColInt",Shape="shape",Size="carat", Color="color", Clarity="clarity", Cut="cut", Polish="polish",Sym="symmetry",Flour="fluorescence",cert="report",ReportNo="reportno",Ref="stoneid", Disc="back",RapRate="rapprice",Rate="price"))
#importdata<-rename(importdata,c(Shape="shape",Weight="carat", Color="color", Purity="clarity", Cut="cut", Polish="polish",Symn="symmetry",Fluor="fluorescence",Cert="report",ReportNo="reportno",RefNo="stoneid", Per="back",RRate="rapprice",Total="price"))

if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back
##########记得检查OPut<-cbind(OPut, measurement)

measurement<-c(unlist(paste(importdata$Mes1, importdata$Mes2, importdata$Mes3, sep="*")))
#measurement<-c(unlist(paste(importdata$M1, importdata$M2, importdata$M3, sep="*")))
#measurement<-c(unlist(paste(importdata$Length, importdata$Width, importdata$Depth, sep="*")))

colsh<-rep(NA, length(importdata$shape))
green<-rep(NA, length(importdata$shape))
milky<-rep(NA, length(importdata$shape))
rapnetid<-as.numeric(rep("43460", length(importdata$shape)))
#if(F){
temp1<-importdata$Milky%in%c("M-0","")
milky[temp1]<-"无奶"
temp2<-importdata$Milky%in%c("M-A","M-B")
milky[temp2]<-"带奶"

temp3<-importdata$ColInt%in%c("BR-A","BR-B")
colsh[temp3]<-"带咖"
green[temp3]<-"无绿"
temp4<-importdata$ColInt%in%c("GRN-A","GRN-B")
colsh[temp4]<-"无咖"
green[temp4]<-"带绿"
temp5<-importdata$ColInt%in%c("WHT","")
colsh[temp5]<-"无咖"
green[temp5]<-"无绿"
#}
if(F){
  
temp1<-importdata$Brownish%in%c("Genuine Brown","Light Brown","Medium Brown","Slightly Brown  -  Not Problematic")
colsh[temp1]<-"带咖"
temp2<-importdata$Brownish%in%c("No Brown","")
colsh[temp2]<-"无咖"
temp3<-importdata$Milky%in%c("Genuine Milky","Medium milky","Minor milky","Slightly milky or Hazy","Totally Milky")
milky[temp3]<-"带奶"
temp4<-importdata$Milky%in%c("No milky","No Milky","")
milky[temp4]<-"带奶"
green<-rep("无绿", length(importdata$shape))
}

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)

OPut<-cbind(OPut, measurement)


OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)

#if(F){
Myvars<-c("Milky","Brownish","shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
index_Fin<-Myvars%in%c("Milky","Brownish")
Fin<-Fin[!index_Fin]
#}

if(F){
  Myvars<-c("Milky","ColInt","shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
  Fin<-OOPut[Myvars]
  index_Fin<-Myvars%in%c("Milky","ColInt")
  Fin<-Fin[!index_Fin]
}

if(F){
  Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
  Fin<-OOPut[Myvars]
}

write.csv(Fin,file="./R_input/43460.csv",row.names = F)