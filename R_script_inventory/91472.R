library(reshape)
importdata<-`91472` #导入变量名转换
importdata<-rename(importdata, c(Member.Comments="Member.Comments",Shape="shape",Carat="carat", Col="color",Clarity="clarity",Cut="cut", Pol="polish", Sym.="symmetry", Flo="fluorescence",Certi="report", Report.No="reportno",StoneID="stoneid", Disc..="back", RapRate="rapprice",Total="price"))
importdata$back<-as.numeric(importdata$back)
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back
measurement<-paste(importdata$Measurement, importdata$X, importdata$X.1, sep="*")

rapnetid<-rep(91472, length(importdata$shape))
milky<-rep(NA, length(importdata$shape))
colsh<-rep(NA, length(importdata$shape))
green<-rep(NA, length(importdata$shape))

index1<-importdata$Member.Comments%in%c("BROWN","BROWN TINCH","FAINT BROWN","LIGHT BROWN","MEDIUM BROWN"," SLIGHT MILKY","VERY LIGHT BROWN")
colsh[index1]<-"带咖"
milky[index1]<-"无奶"
green[index1]<-"无绿"
index2<-importdata$Member.Comments%in%"LIGHT BROWN MILKY"
colsh[index2]<-"带咖"
milky[index2]<-"带奶"
green[index2]<-"无绿"
index3<-importdata$Member.Comments%in%c("MILKY","LIGHT MILKY","SLIGHT MILKY","VERY SLIGHT MILKY")
colsh[index3]<-"无咖"
milky[index3]<-"带奶"
green[index3]<-"无绿"
index4<-importdata$Member.Comments%in%c("NO BGM","NO BGM  NO BLACK","NO BGM NO BLACK","NOBGM","")
colsh[index4]<-"无咖"
milky[index4]<-"无奶"
green[index4]<-"无绿"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, measurement)

OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/91472.csv",row.names = F)
