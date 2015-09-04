library(reshape)
importdata<-`60745` #导入变量名转换
importdata<-rename(importdata, c(Measurment="measurement",Shape="shape",Wt="carat", Colour="color",Clarity="clarity",Cut="cut", Polish="polish", Symmetry="symmetry", Fluorecsence="fluorescence",cert="report", CertificateNo="reportno", PacketNo="stoneid", Back="back", RapPrice="rapprice",Price="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back
rapnetid<-rep(60745, length(importdata$measurement))

#########################Milky only Faint, Very Faint, Medium######################
yanse<-importdata$Milky
milky<-rep(NA, length(importdata$measurement))
milk1<-yanse%in%c("Non","White")
milky[milk1]<-"无奶"
milk2<-yanse%in%c("Faint","Medium","Very Faint")
milky[milk2]<-"带奶"
#########################Shade not complete######################
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
temp1<-importdata$Shade%in%c("LB","DB")
colsh[temp1]<-"带咖"
green[temp1]<-"无绿"
temp2<-importdata$Shade%in%"GREEN"
green[temp2]<-"带绿"
colsh[temp2]<-"无咖"
temp3<-importdata$Shade%in%c("NONE","White")
colsh[temp3]<-"无咖"
green[temp3]<-"无绿"
###########处理彩钻颜色#################################################

importdata$color<-gsub(".*-\\s*\\[\\*\\],","",importdata$color)

index_fc<-regexpr("FCIntensity:|FC:|FCOvertone:",importdata$color)
importdata$color[which(index_fc>0)]<-NA

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)

OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/60745.csv",row.names = F)
