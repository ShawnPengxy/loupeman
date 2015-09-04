#missing OVAL
library(reshape)
importdata<-`12458` #导入变量名转换
importdata<-rename(importdata, c(Shape="shape",Color="color",Cut="cut", Polish="polish",Clarity="clarity", Cts="carat", Symm="symmetry", Fls="fluorescence",Lab="report", Certi.No="reportno", Ref.No.="stoneid", Disc...="back", Rap.Price="rapprice"))
measurement<-c(unlist(paste(importdata$Length, importdata$Width, importdata$Depth, sep="*")))
rapnetid<-rep(12458, length(measurement))


colsh<-rep(NA, length(measurement))
milky<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))

#形状处理
shape<-as.character(importdata$shape)
dianxing<-shape%in%"CUSHION"
shape[dianxing]<-"垫形"

zumulv<-shape%in%"EMERALD"
shape[zumulv]<-"祖母绿"

xinxing<-shape%in%"HEART"
shape[xinxing]<-"心形"

ganlan<-shape%in%"MARQUISE"
shape[ganlan]<-"橄榄形"

tuoyuan<-shape%in%"OVAL"
shape[tuoyuan]<-"椭圆形"

lixing<-shape%in%"PEAR"
shape[lixing]<-"梨形"

gongzhufang<-shape%in%"PRINCESS"
shape[gongzhufang]<-"公主方"

yuanxing<-shape%in%"ROUND"
shape[yuanxing]<-"圆形"

#back值添加负号
back<--as.numeric(importdata$back)


quchu<-names(importdata)%in%c("shape","back")
newdata<-importdata[!quchu]
OPut<-cbind(measurement, rapnetid)
OPut<-cbind(OPut, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, back)
OPut<-cbind(OPut, shape)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/12458.csv",row.names = F)
