library(reshape)
importdata<-`73176` #导入变量名转换
importdata<-rename(importdata, c(Shape="shape",Carat="carat", Co="color",Clar="clarity",Cut="cut", Pol="polish", Sym="symmetry", Flo="fluorescence",Cer="report", Report.No.="reportno", StoneID="stoneid",Disc..="back",RapRate="rapprice"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back


measurement<-c(unlist(paste(importdata$Measurement.,importdata$X.1,importdata$X.2, sep="*")))

rapnetid<-rep(73176, length(measurement))
milky<-rep(NA, length(measurement))
colsh<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))
price<-rep(NA, length(measurement))

temp1<-importdata$Member.Comment%in%"NO - BGM"
milky[temp1]<-"无奶"
colsh[temp1]<-"无咖"
green[temp1]<-"无绿"
temp2<-importdata$Member.Comment%in%c("Faint Brown ON CERTI","VERY LIGHT BROWN","VERY VERY LIGHT BROWN")
milky[temp2]<-"无奶"
colsh[temp2]<-"带咖"
green[temp2]<-"无绿"


OPut<-cbind(measurement,rapnetid)
OPut<-cbind(OPut, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/73176.csv",row.names = F)
