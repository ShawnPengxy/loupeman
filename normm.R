shapefun<-function(sshape){###################ÿ�ζ�Ҫ���shape��#########################
  sshape<-sub("\\b[Oo](\\w*[Ll]|[Mm]?[Bb])\\b|\\b[Oo][Vv]\\w*","��",sshape)
  sshape<-sub("\\b[Rr](\\w*[Dd]|[Mm]?[Bb][Cc]?)\\b|\\bRO\\w*|\\b[Bb][Rr]\\w*","Բ��",sshape)
  sshape<-sub("\\b[Cc](\\w*[Nn]|[Mm]?[Bb])\\b|\\bCU\\w*|\\b[Cc][Uu]?[Ss]?[Hh]\\w*","����",sshape)
  sshape<-sub("\\b[Pp]\\w*[Ss]\\b|\\bPR\\w*|\\b[Pp][Cc]\\b|\\b[Pp][Nn]\\b","������",sshape)
  sshape<-sub("\\b[Mm](\\w*[Ee]|[Mm]?[Bb])\\b|\\bMA\\w*|\\b[Cc][Mm]\\b|\\b[Mm][Qq]\\b|^[Mm]$","������",sshape)
  sshape<-sub("\\b[Hh](\\w*[Tt]|[Mm]?[Bb])\\b|\\bHA\\w*|\\b[Hh][Ee]\\b","����",sshape)
  sshape<-sub("\\b[Ee](\\w*[Dd]|[Mm]?[Bb])\\b|\\bEM\\w*|\\b(S|SQ)?EM?\\b|^[Ee]$","��ĸ��",sshape)
  sshape<-sub("\\b[Pp]\\w*[Rr]\\b|\\bPE\\w*|\\b[Pp][Ee]\\b","����",sshape)
  sshape<-sub("\\b[Rr]\\w*[Tt]\\b|\\bRA\\w*|\\b[Rr][Nn]\\w*","�׵϶�",sshape)
  #  sshape<-sub("\\b[Tt]\\w*[Rr]\\b|\\bT[Rr]\\w*|\\bMTB\\b|\\bMTR\\b","������",sshape)
  #  sshape<-sub("\\b[Ss][Qq]\\w*","����",sshape)
  #  sshape<-sub("\\b[Aa][Ss]\\w*","�϶�",sshape)
  
  return(sshape)
}
matchh<-function(varr,textt,lth){
  S_position<-regexpr(varr,textt)
  temp<-S_position%in%"-1"
  #SS_position<-S_position[!temp]
  #E_position<-S_position[!temp]+lth
  textt[!temp]<-substring(textt[!temp],S_position[!temp],S_position[!temp]+lth)
  return(textt)
}

setwd("D:/")                                                                    #�趨����Ŀ¼ΪD��
importdata<-read.csv("merge.csv",stringsAsFactors=FALSE)
###�ȴ����̿����е�NAֵ########
temp_1<-importdata$milky%in%c("M0","NONE")
importdata$milky[temp_1]<-"����"
temp_2<-importdata$milky%in%c("M1","M2","M3")
importdata$milky[temp_2]<-"����"
temp_3<-importdata$milky%in%c("VSL","")
importdata$milky[temp_3]<-NA
temp_4<-importdata$milky%in%NA
importdata$milky[temp_4]<-"����"
temp_5<-importdata$colsh%in%NA
importdata$colsh[temp_5]<-"����"
temp_6<-importdata$green%in%NA
importdata$green[temp_6]<-"����"

##############����cut�հ�ֵ#############
temp_cuut<-importdata$cut%in%NA
importdata$cut[temp_cuut]<-""
#############����report NAֵ################
temp_ree<-importdata$report%in%NA
importdata$report[temp_ree]<-""
####################����fluorescence###########
temp_fluu<-importdata$fluorescence%in%c(NA,"")
importdata$fluorescence[temp_fluu]<-"None"
###################����reportno�հ�ֵ################
temp_repno<-importdata$reportno%in%NA
importdata$reportno[temp_repno]<-""
###################����price�հ�ֵ################
temp_repno<-importdata$price%in%NA
importdata$price[temp_repno]<-""
############rapprice��back�Ȳ�����ΪNA########
importdata$rapprice[is.na(importdata$rapprice)]<-""
importdata$back[is.na(importdata$back)]<-""


###ȥ���������������########
temp_m<-importdata$carat%in%"weight"
importdata$carat[temp_m]<-NA


newdata<-na.omit(importdata)


#########����shapeֵ,ע���ֶ�ͬ��#########
sshape<-newdata$shape
Shhape<-sapply(sshape, shapefun)
Shhapee<-matchh("��",Shhape, 0)
Shhapee<-matchh("Բ��",Shhapee, 1)
Shhapee<-matchh("����",Shhapee, 1)
Shhapee<-matchh("������",Shhapee, 2)
Shhapee<-matchh("������",Shhapee, 2)
Shhapee<-matchh("����",Shhapee, 1)
Shhapee<-matchh("��ĸ��",Shhapee, 2)
Shhapee<-matchh("����",Shhapee, 1)
Shhapee<-matchh("�׵϶�",Shhapee, 2)
#Shhapee<-matchh("������",Shhapee, 2)
#Shhapee<-matchh("����",Shhapee, 1)
#Shhapee<-matchh("�϶�",Shhapee, 3)
temp<-Shhapee%in%c("Բ��","����","������","������","����","��ĸ��","����","��","�׵϶�")
Shhapee[!temp]<-NA
########�ֶλ�ԭ#######
temp_1<-Shhapee%in%"��"
Shhapee[temp_1]<-"��Բ��"
#temp_2<-Shhapee%in%"�϶�"
#Shhapee[temp_2]<-"�϶�����"
newdata$shape<-Shhapee
############clarity######################
cclarity<-newdata$clarity
cclarity<-sub(pattern = "\\b([Ff][Ll]).*", replacement = "FL", cclarity)
cclarity<-sub(pattern = "\\b([Ii][Ff]).*", replacement = "IF", cclarity)
cclarity<-sub(pattern = "\\b([Vv][Vv][Ss]\\s?1).*", replacement = "VVS1", cclarity)
cclarity<-sub(pattern = "\\b([Vv][Vv][Ss]\\s?2).*", replacement = "VVS2", cclarity)
cclarity<-sub(pattern = "\\b([Vv][Ss]\\s?1).*", replacement = "VS1", cclarity)
cclarity<-sub(pattern = "\\b([Vv][Ss]\\s?2).*", replacement = "VS2", cclarity)
cclarity<-sub(pattern = "\\b([Ss][Ii]\\s?1).*", replacement = "Si1", cclarity)
cclarity<-sub(pattern = "\\b([Ss][Ii]\\s?2).*", replacement = "Si2", cclarity)
#cclarity<-sub(pattern = "\\b([Ss][Ii]+).*", replacement = "SI2", cclarity)
cclarity<-sub(pattern = "\\b([Ii]\\s?1).*", replacement = "I1", cclarity)
cclarity<-sub(pattern = "\\b([Ii]\\s?2).*", replacement = "I2", cclarity)
cclarity<-sub(pattern = "\\b([Ii]\\s?3).*", replacement = "I3", cclarity)
#cclarity<-sub(pattern = "\\b([Ii]\\s?4).*", replacement = "I4", cclarity)
temp_cla<-cclarity%in%c("FL","IF","VVS1","VVS2","VS1", "VS2","Si1","Si2","I1","I2","I3")
cclarity[!temp_cla]<-NA
newdata$clarity<-cclarity
############cut######################
newdata$cut[which(newdata$shape!="Բ��")]<-""###########������û���й�
ccut<-newdata$cut
ccut<-sub(pattern = ".*[Ee][Xx].*", replacement = "EX", ccut)
ccut<-sub(pattern = ".*[Ff][Rr].*", replacement = "FR", ccut)
ccut<-sub(pattern = "\\b[Gg][Dd]?.*", replacement = "GD", ccut)
ccut<-sub(pattern = ".*[Vv][Gg].*", replacement = "VG", ccut)
ccut<-sub(pattern = "\\b[Pp].*", replacement = "Pr", ccut)
temp_cut<-ccut%in%c("EX","FR","GD","VG","Pr","")
ccut[!temp_cut]<-NA
newdata$cut<-ccut
###############ppolish###################
ppolish<-newdata$polish
ppolish<-sub(pattern = "\\b[Ee][Xx].*", replacement = "EX", ppolish)
ppolish<-sub(pattern = "\\b[Ff].*", replacement = "FR", ppolish)
ppolish<-sub(pattern = "\\b[Gg].*", replacement = "GD", ppolish)
ppolish<-sub(pattern = "\\b[Vv][Gg].*", replacement = "VG", ppolish)
ppolish<-sub(pattern = "\\b[Pp].*", replacement = "Pr", ppolish)
temp_pol<-ppolish%in%c("EX","FR","GD","VG","Pr")
ppolish[!temp_pol]<-NA
newdata$polish<-ppolish
###############symmetry###################
ssymmetry<-newdata$symmetry
ssymmetry<-sub(pattern = "\\b[Ee][Xx].*", replacement = "EX", ssymmetry)
ssymmetry<-sub(pattern = "\\b[Ff].*", replacement = "FR", ssymmetry)
ssymmetry<-sub(pattern = "\\b[Gg][Dd]?.*", replacement = "GD", ssymmetry)
ssymmetry<-sub(pattern = "\\b[Vv][Gg].*", replacement = "VG", ssymmetry)
ssymmetry<-sub(pattern = "\\b[Pp].*", replacement = "Pr", ssymmetry)
temp_symm<-ssymmetry%in%c("EX","FR","GD","VG","Pr")
ssymmetry[!temp_symm]<-NA
newdata$symmetry<-ssymmetry
###############fluorescence###################
ffluorescence<-newdata$fluorescence
ffluorescence<-sub(pattern = "\\b[Ff].*", replacement = "F", ffluorescence)
ffluorescence<-sub(pattern = "\\b[Mm].*", replacement = "M", ffluorescence)
ffluorescence<-sub(pattern = "\\b[Nn].*", replacement = "N", ffluorescence)
ffluorescence<-sub(pattern = "\\b[Ss].*", replacement = "S", ffluorescence)
ffluorescence<-sub(pattern = "\\b[Vv][Ss]([^Ll].*|\\s*\\b)", replacement = "VS", ffluorescence)
ffluorescence<-sub(pattern = "\\b[Vv][Ss][Ll].*", replacement = "VSL", ffluorescence)

temp_fluo<-ffluorescence%in%c("F","M","N","S","VS","VSL")
ffluorescence[!temp_fluo]<-NA
newdata$fluorescence<-ffluorescence
###############report###################
rreport<-newdata$report
rreport<-sub(pattern = ".*GIA.*", replacement = "GIA", rreport)
rreport<-sub(pattern = ".*HRD.*", replacement = "HRD", rreport)
rreport<-sub(pattern = ".*IGI.*", replacement = "IGI", rreport)
rreport<-sub(pattern = ".*NGTC.*", replacement = "NGTC", rreport)
rreport<-sub(pattern = ".*AGS.*", replacement = "AGS", rreport)
rreport<-sub(pattern = ".*CGL.*", replacement = "CGL", rreport)

temp_rep<-rreport%in%c("GIA","HRD","IGI","NGTC","EGL","AGS","CGL","CCGTC","ɢ��")
rreport[!temp_rep]<-"ɢ��"
newdata$report<-rreport

##################ɾ��stoneid�е������֡��ա��͡���"##############
newdata$stoneid<-sub(pattern = ".*[����].*", replacement = NA, newdata$stoneid)
######################ɾ��milky�е�L1��L2��############
newdata$milky[newdata$milky%in%c("L1","L2")]<-"����"
######################ɾ��carat��С��0.3���쳣ֵ#################
newdata$carat[which(newdata$carat<0.3)]<-NA
##################ɾ��ɢ��#########################
newdata$report[which(newdata$report=="ɢ��")]<-NA
################ȥ���۸��ж��ŷָ�################
newdata$rapprice<-gsub(",","",newdata$rapprice)
newdata$price<-gsub(",","",newdata$price)
######################ɾ��price��С��10���쳣ֵ#################
newdata$price[which(newdata$price<10)]<-NA


###########color ��X-Y��������X��Ŀǰ��#########

ccolor<-newdata$color
ccolorr<-sub("^D\\W*$","D11111",ccolor)
ccolorr<-sub("^E\\W*$","E11111",ccolorr)
ccolorr<-sub("^F\\W*$|^F\\.\\w*","F11111",ccolorr)#####more###
ccolorr<-sub("^-?G\\W*$","G11111",ccolorr)
ccolorr<-sub("^H\\W*$","H11111",ccolorr)
ccolorr<-sub("^I\\W*$","I11111",ccolorr)
ccolorr<-sub("^J\\W*$","J11111",ccolorr)
ccolorr<-sub("^K\\W*$|^K\\s-\\s\\W*|^K[,.]\\w*","K11111",ccolorr)
ccolorr<-sub("^L\\W*$|^L\\s(-\\s)?\\W*|^L[,.]\\w*|^L\\(\\w*","L11111",ccolorr)
ccolorr<-sub("^M\\W*$|^M\\s(-\\s)?\\W*|^M[,.]\\w*|^M\\(\\w*","M11111",ccolorr)
ccolorr<-sub("^N\\W*$|^N\\s(-\\s)?\\W*|^N[,.]\\w*","N11111",ccolorr)

ccolorr<-sub("^O-?P\\W*$","O-P1111",ccolorr)########  "O-P"  #########
ccolorr<-sub("^O\\W*$|^O\\s(-\\s)?\\W*","O11111",ccolorr)
ccolorr<-sub("^P\\W*$","P11111",ccolorr)
ccolorr<-sub("^Q-?R\\W*$","Q-R1111",ccolorr)########  "Q-R"  #########
ccolorr<-sub("^Q\\W*$|^Q\\s(-\\s)?\\W*","Q11111",ccolorr)
ccolorr<-sub("^S-?T\\W*$","S-T1111",ccolorr)########  "S-T"  #########
ccolorr<-sub("^S\\W*$|^S\\s(-\\s)?\\W*","S11111",ccolorr)
ccolorr<-sub("^U-?V\\W*$","U-V1111",ccolorr)########  "U-V"  #########
ccolorr<-sub("^U\\W*$|^U\\s(-\\s)?\\W*","U11111",ccolorr)
ccolorr<-sub("^W-?X\\W*$|^W-?X\\s\\w+","W-X1111",ccolorr)########  W-X  #########
ccolorr<-sub("^[Ww]\\W*$|^W\\s(-\\s)?\\W*","W11111",ccolorr)
ccolorr<-sub("^X-?Y\\W*$","X-Y1111",ccolorr)########  X-Y  #########
ccolorr<-sub("^X\\W*$","X11111",ccolorr)
ccolorr<-sub("^Y-?Z\\W*$","Y-Z1111",ccolorr)########  Y-Z  #########
ccolorr<-sub("^Y\\W*$|^Y\\s(-\\s)?\\W*","Y11111",ccolorr)
matchh_COL<-function(varr,textt,lth){
  S_position<-regexpr(varr,textt)
  temp<-S_position%in%"-1"
  textt[!temp]<-substring(textt[!temp],S_position[!temp],S_position[!temp]+lth)
  return(textt)
}

coolor<-matchh_COL("D11111",ccolorr, 0)
coolor<-matchh_COL("E11111",coolor, 0)
coolor<-matchh_COL("F11111",coolor, 0)
coolor<-matchh_COL("G11111",coolor, 0)
coolor<-matchh_COL("H11111",coolor, 0)
coolor<-matchh_COL("I11111",coolor, 0)
coolor<-matchh_COL("J11111",coolor, 0)
coolor<-matchh_COL("K11111",coolor, 0)
coolor<-matchh_COL("L11111",coolor, 0)
coolor<-matchh_COL("M11111",coolor, 0)
coolor<-matchh_COL("N11111",coolor, 0)
coolor<-matchh_COL("O11111",coolor, 0)
coolor<-matchh_COL("P11111",coolor, 0)
coolor<-matchh_COL("Q11111",coolor, 0)
coolor<-matchh_COL("S11111",coolor, 0)
coolor<-matchh_COL("U11111",coolor, 0)
coolor<-matchh_COL("W11111",coolor, 0)
coolor<-matchh_COL("X11111",coolor, 0)
coolor<-matchh_COL("Y11111",coolor, 0)

coolor<-matchh_COL("O-P1111",coolor, 2)
coolor<-matchh_COL("Q-R1111",coolor, 2)
coolor<-matchh_COL("S-T1111",coolor, 2)
coolor<-matchh_COL("U-V1111",coolor, 2)
coolor<-matchh_COL("W-X1111",coolor, 2)
coolor<-matchh_COL("X-Y1111",coolor, 2)
coolor<-matchh_COL("Y-Z1111",coolor, 2)
temp_color<-coolor%in%c("D","E","F","G","H","I","J","K","L","M","N","O","P","Q","S","U","W","X","Y","O-P","Q-R","S-T","U-V","W-X","X-Y","Y-Z")

  

############����������ɫ####################
Fancy_data<-newdata[!temp_color,]
A<-coolor[!temp_color]
B<-trimws(gsub("(UN)?EVEN|-?NOT APPLICABLE|NATURAL|\\[\\*\\]|,","",A,ignore.case=T))
strength<-toupper(sub(pattern = ".*(None|Faint|Very light|Light|Fancy|Fancy Dark|Fancy Intense|Fancy Vivid|Fancy Deep).*", replacement = "\\1", B,ignore.case=T))
qq<-regexpr(".*(None|Faint|Very light|Light|Fancy|Fancy Dark|Fancy Intense|Fancy Vivid|Fancy Deep).*", strength,ignore.case=T)
strength[which(qq<0)]<-NA
C<-trimws(gsub("None|Faint|Very light|Light|Fancy|Fancy Dark|Fancy Intense|Fancy Vivid|Fancy Deep","",B,ignore.case=T))
hue<-toupper(sub(pattern = "(\\w+ish(\\s\\w+ish)?).*", replacement = "\\1",C, ignore.case=T))
qq1<-regexpr("(\\w+ish(\\s\\w+ish)?).*", hue,ignore.case=T)
hue[which(qq1<0)]<-""
color<-trimws(gsub("(\\w+ish(\\s\\w+ish)?).","",C,ignore.case=T))
Fancy_data$color<-toupper(color)
Fancy_data<-cbind(Fancy_data,strength,hue)
Fancycolor_data<-subset(Fancy_data,is.na(strength)==F,select=shape:hue)
##################����������ɫ######################
coolor[!temp_color]<-NA
temp_minusN<-coolor%in%c("O","P","Q","S","U","W","X","Y","O-P","Q-R","S-T","U-V","W-X","X-Y","Y-Z")
coolor[temp_minusN]<-"<N"
newdata$color<-coolor
newdata<-newdata[temp_color,]






##########�����������#############
Fancycolor_data<-na.omit(Fancycolor_data)

Fancycolor_data<-subset(Fancycolor_data,Fancycolor_data$price!=""&!is.na(Fancycolor_data$shape),select = shape:hue)

write.csv(Fancycolor_data,file = "Fancycolor_Sheet_for_20150814_update.csv",row.names=F,fileEncoding="UTF-8") 
write.csv(Fancycolor_data,file = "Fancycolor_Sheet_for_20150814.csv",row.names=F) 


######################ɾ��rapprice��С��10���쳣ֵ#################
newdata$rapprice[which(newdata$rapprice<10)]<-NA
###################ɾ��back���ڵ���0��ֵ##################
newdata$back[which(newdata$back>=0)]<-NA

##########�����������###########

TTT<-newdata[-19]#################ɾ��price��Ŀ#############
TTT<-na.omit(TTT)
TTT<-subset(TTT,TTT$rapprice!=""&TTT$back!="",select = shape:rapprice)
#userid<-rep(687,length(TTT$shape))
#location<-rep("����",length(TTT$shape))

#TTT_1<-cbind(location,TTT)
#TTT<-cbind(userid,TTT_1)
write.csv(TTT,file = "Final_Sheet_for_20150814_update.csv",row.names=F,fileEncoding="UTF-8") 
write.csv(TTT,file = "Final_Sheet_for_20150814.csv",row.names=F) 




