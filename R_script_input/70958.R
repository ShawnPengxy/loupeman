library(reshape)
importdata<-`70958` #导入变量名转换
importdata<-rename(importdata, c(Comment.1="Comment.1",Shape="shape",Weight="carat", Color="color",Clarity="clarity",Cut="cut", Polish="polish", Symm="symmetry", Fls="fluorescence",Lab="report", Report.No="reportno", Packet.No="stoneid", Disc..="back", Rap.Price="rapprice",Total.Amount="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

measurement<-c(unlist(paste(importdata$Length,importdata$Width, importdata$Depth, sep="*")))
rapnetid<-rep(70958, length(measurement))
milky<-rep(NA, length(measurement))
colsh<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))

index1<-importdata$Comment.1%in%c("BROWN","BROWN H&A","H&A,BROWN")
colsh[index1]<-"带咖"
milky[index1]<-"无奶"
green[index1]<-"无绿"
index2<-importdata$Comment.1%in%"MILKY"
colsh[index2]<-"无咖"
milky[index2]<-"带奶"
green[index2]<-"无绿"
index2<-importdata$Comment.1%in%c("","H&A","H & A"," H&A")
colsh[index2]<-"无咖"
milky[index2]<-"无奶"
green[index2]<-"无绿"


OPut<-cbind(measurement,rapnetid)
OPut<-cbind(OPut, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)


Myvars<-c("Comment.1","shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
index_Fin<-Myvars%in%c("Comment.1")
Fin<-Fin[!index_Fin]
write.csv(Fin,file="./R_input/70958.csv",row.names = F)
