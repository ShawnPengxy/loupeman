library(reshape)
importdata<-`45110` #导入变量名转换
#importdata<-rename(importdata, c(Measurement="measurement",Shape="shape",Col="color",Cut="cut", Pol="polish",Cla="clarity", Cts="carat", Sym="symmetry", FL="fluorescence",Lab="report", Cert..No.="reportno", Pkt.No.="stoneid", Back..="back", Rap="rapprice",X..Carat="price"))
importdata<-rename(importdata, c(Measurement="measurement",Shape="shape",Color="color",Cut="cut", Polish="polish",Clarity="clarity", Weight="carat", Symmerty="symmetry", FL.Intent="fluorescence",Lab="report", Report_No="reportno", Packet_No="stoneid", Back..="back", Rap.Price="rapprice",Price.Per.Carat="price"))

if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

rapnetid<-as.numeric(rep("45110", length(importdata$measurement)))
milky<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))

temp1<-importdata$Luster%in%c("ML0.5","ML1", "ML2","ML2.5","ML3")
milky[temp1]<-"带奶"
temp2<-importdata$Luster%in%c("EX","GD", "VG")
milky[temp2]<-"无奶"
##############有时候供应商把咖绿项和color项写在一起了#########
if(F) {
colsh[which(regexpr("BR",importdata$color)>0)]<-"带咖"
green[which(regexpr("BR",importdata$color)>0)]<-"无绿"

colsh[which(regexpr("BR",importdata$color)<0)]<-"无咖"
green[which(regexpr("BR",importdata$color)<0)]<-"待查"##############供应商说待定###################
color<-sub("\\(BR[0-9]?\\)","",importdata$color)
}
color<-importdata$color
temp3<-importdata$Brown%in%c("Brown", "Brown 1", "Brown 2", "Brown 3")
colsh[temp3]<-"带咖"
colsh[!temp3]<-"无咖"
colsh<-rep("待查", length(importdata$measurement))


OPut<-cbind(colsh,rapnetid)
OPut<-cbind(OPut, milky)

OPut<-cbind(OPut, color)

OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/45110.csv",row.names = F)
