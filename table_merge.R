setwd("D:/")                                                                    #�趨����Ŀ¼ΪD��
a = list.files("R_input")                                                       #list.files���input�ļ����������ļ�������a
dir = paste("./R_input/",a,sep="")                                      #��paste�����·������dir
n = length(dir)
merge.data = read.csv(file = dir[1],header=T,sep=",",stringsAsFactors=FALSE)
for (i in 2:n){
  new.data = read.csv(file = dir[i], header=T, sep=",",stringsAsFactors=FALSE)
  merge.data = rbind(merge.data,new.data)
}
write.csv(merge.data,file = "./merge.csv",row.names=F)  