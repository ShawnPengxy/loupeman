library(reshape)
importdata<-`71100` #���������ת��
importdata<-rename(importdata, c(Shape="shape",Carat="carat", Col="color",Clarit="clarity",Cut="cut", Pol="polish", Sym="symmetry", Flo="fluorescence",Cert="report", Report.No="reportno", Stone.ID="stoneid", Disc.="back", RapRat="rapprice"))

if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back


measurement<-c(unlist(paste(importdata$Measurement,importdata$X.2, importdata$X.3, sep="*")))
rapnetid<-rep(71100, length(measurement))

price<-rep(NA, length(measurement))############û��ע���ּ�###############
milky<-rep(NA, length(measurement))
colsh<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))

########��ȡComment�е���ɫ�����ҳ���ɫ��������ɫ���滻
ziduan<-importdata$Shade
last_number<-length(measurement)
colsh<-rep(NA, length(measurement))
milky<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))

zongse<-regexpr("BROWN", ziduan)
lvse<-regexpr("GREEN", ziduan)
naise<-regexpr("MILKY", ziduan)
for(i in 1:last_number) {if(zongse[i]>0) colsh[i]<-"����";if(lvse[i]>0) green[i]<-"����";if(naise[i]>0) milky[i]<-"����"}

zongse2<-regexpr("NO BROWN , NO GREEN , NO MILKY", ziduan)
lvse2<-regexpr("NO BROWN , NO GREEN , NO MILKY", ziduan)
naise2<-regexpr("NO BROWN , NO GREEN , NO MILKY", ziduan)
for(i in 1:last_number) {if(zongse2[i]>0) colsh[i]<-"�޿�";if(lvse2[i]>0) green[i]<-"����";if(naise2[i]>0) milky[i]<-"����"}

OPut<-cbind(measurement,rapnetid)
OPut<-cbind(OPut, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)

OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/71100.csv",row.names = F)