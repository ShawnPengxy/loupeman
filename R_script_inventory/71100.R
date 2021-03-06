library(reshape)
importdata<-`71100` #导入变量名转换
importdata<-rename(importdata, c(Shape="shape",Carat="carat", Col="color",Clarit="clarity",Cut="cut", Pol="polish", Sym="symmetry", Flo="fluorescence",Cert="report", Report.No="reportno", Stone.ID="stoneid", Disc.="back", RapRat="rapprice"))



measurement<-c(unlist(paste(importdata$Measurement.,importdata$X, importdata$X.1, sep="*")))
rapnetid<-rep(71100, length(measurement))

price<-rep(NA, length(measurement))############没有注明现价###############
milky<-rep(NA, length(measurement))
colsh<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))

########提取Comment中的三色，先找出带色，再用无色的替换
ziduan<-importdata$Shade
last_number<-length(measurement)
colsh<-rep(NA, length(measurement))
milky<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))

zongse<-regexpr("BROWN", ziduan)
lvse<-regexpr("GREEN", ziduan)
naise<-regexpr("MILKY", ziduan)
for(i in 1:last_number) {if(zongse[i]>0) colsh[i]<-"带咖";if(lvse[i]>0) green[i]<-"带绿";if(naise[i]>0) milky[i]<-"带奶"}

zongse2<-regexpr("NO BROWN , NO GREEN , NO MILKY", ziduan)
lvse2<-regexpr("NO BROWN , NO GREEN , NO MILKY", ziduan)
naise2<-regexpr("NO BROWN , NO GREEN , NO MILKY", ziduan)
for(i in 1:last_number) {if(zongse2[i]>0) colsh[i]<-"无咖";if(lvse2[i]>0) green[i]<-"无绿";if(naise2[i]>0) milky[i]<-"无奶"}

OPut<-cbind(measurement,rapnetid)
OPut<-cbind(OPut, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)

OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/71100.csv",row.names = F)
