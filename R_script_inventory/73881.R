library(reshape)
importdata<-`73881` #���������ת��
importdata<-rename(importdata, c(Shape="shape",Carat="carat", Col="color",Clarit="clarity",Cut="cut", Pol="polish", Sym="symmetry", Flo="fluorescence",Cert="report", Report.No="reportno", Stone.ID="stoneid", Disc.="back", RapRat="rapprice"))
measurement<-c(unlist(paste(importdata$Measurement, importdata$X, importdata$X.1, sep="*")))
rapnetid<-rep(73881, length(measurement))

########��ȡComment�е���ɫ�����ҳ���ɫ��������ɫ���滻
ziduan<-importdata$Shd
last_number<-length(measurement)
colsh<-rep(NA, length(measurement))
milky<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))

zongse<-regexpr("BROWN", ziduan)
lvse<-regexpr("GREEN", ziduan)
naise<-regexpr("MILKY", ziduan)
for(i in 1:last_number) {if(zongse[i]>0) colsh[i]<-"����";if(lvse[i]>0) green[i]<-"����";if(naise[i]>0) milky[i]<-"����"}


zongse2<-regexpr("NO BROWN", ziduan)
lvse2<-regexpr("NO GREEN", ziduan)
naise2<-regexpr("NO MILKY", ziduan)
for(i in 1:last_number) {if(zongse2[i]>0) colsh[i]<-"�޿�";if(lvse2[i]>0) green[i]<-"����";if(naise2[i]>0) milky[i]<-"����"}



OPut<-cbind(rapnetid, colsh)

OPut<-cbind(OPut, measurement)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/73881.csv",row.names = F)