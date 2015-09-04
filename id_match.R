setwd("D:/")
companyID_match<-read.csv("./companyID_match.csv",header =T,stringsAsFactors=F)
allocatedID_match<-read.csv("./allocatedID_match.csv",header=T, stringsAsFactors=F)
companyID<-rep("",length(TTT1$shape))
allocatedID<-rep("",length(TTT1$shape))
for(i in 1:length(companyID_match$Rapnetid)){
  index1<-TTT1$rapnetid%in%companyID_match$Rapnetid[i]
  if(length(which(index1==T))!=0) companyID[index1]<-rep(companyID_match$账号[i],length(which(index1==T)))
}
companyID<-as.vector(companyID)

for(j in 1:length(allocatedID_match$供应商账号)){
  index2<-companyID%in%as.numeric(allocatedID_match$供应商账号[j])
  if(length(which(index2==T))!=0) allocatedID[index2]<-rep(allocatedID_match$供应商ID[j],length(which(index2==T)))
}
allocatedID<-as.vector(allocatedID)

TTT2<-cbind(TTT1,allocatedID)

write.csv(TTT2,file="Final_Sheet_for_ready_updates.csv",row.names=F,fileEncoding = "UTF-8")
write.csv(TTT2,file="Final_Sheet_for_20150901.csv",row.names=F)
