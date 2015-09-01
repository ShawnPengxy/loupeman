setwd("D:/")                                                                    #设定工作目录为D盘
a<-list.files("R_script_input") 
dir<- paste("D:/R_script_input/",a,sep="")  
lapply (dir,source)