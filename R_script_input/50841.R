library(reshape)
importdata<-`50841` #导入变量名转换
importdata<-rename(importdata, c(Measurement="measurement",Cts.="carat", Color="color",Clarity="clarity",Cut="cut", Pol.="polish", Sym.="symmetry", FL="fluorescence",Cert="report", CertNo="reportno", Rap..="back", Rap="rapprice",Amount="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

rapnetid<-as.numeric(rep("50841", length(importdata$measurement)))
##########################Col..Shade###########
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
shape<-rep(NA, length(importdata$measurement))
stoneid<-importdata$Ref.No

#############分开stoneid和shape项###############
s1<-regexpr("[0-9]",stoneid)
shape[which(s1==1)]<-"圆形"
ttemp<-s1%in%c("-1","1")
shape[!ttemp]<-substring(stoneid[!ttemp],1,s1[!ttemp]-1)
stoneid[!ttemp]<-substring(stoneid[!ttemp],s1[!ttemp],nchar(stoneid[!ttemp]))

temp1<-importdata$Col..Shade%in%c("BR","BRN","LBR","YBR")
colsh[temp1]<-"带咖"
green[temp1]<-"无绿"
temp2<-importdata$Col..Shade%in%""
colsh[temp2]<-"无咖"
green[temp2]<-"无绿"

temp3<-importdata$Lus%in%c("ML-01","ML-1","ML-2","ML-3")
milky[temp3]<-"带奶"
temp4<-importdata$Lus%in%c("EX","VG")
milky[temp4]<-"无奶"


OPut<-cbind(shape,rapnetid)
OPut<-cbind(OPut, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, stoneid)

OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/50841.csv",row.names = F)
