setwd("D:/")                                                                    #设定工作目录为D盘
a = list.files("R_input")                                                       #list.files命令将input文件夹下所有文件名输入a
dir = paste("./R_input/",a,sep="")                                      #用paste命令构建路径变量dir
n = length(dir)
merge.data = read.csv(file = dir[1],header=T,sep=",",stringsAsFactors=FALSE)
for (i in 2:n){
  new.data = read.csv(file = dir[i], header=T, sep=",",stringsAsFactors=FALSE)
  merge.data = rbind(merge.data,new.data)
}
write.csv(merge.data,file = "./merge.csv",row.names=F)  