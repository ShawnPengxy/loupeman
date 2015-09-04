setwd("D:\\")
file_name<-list.files("inventory_3rd_week")
dir<-paste("D:\\inventory_3rd_week\\",file_name,sep="")
file_name_number<-as.numeric(sub(pattern = "\\.csv\\b", replacement = "", file_name))#去掉.csv后缀,数据转换成数值型
merge.data=read.csv(dir[1],header=T,sep=",",stringsAsFactors=FALSE)
date<-rep(file_name_number[1],length(merge.data[,1]))
merge.data.whole=cbind(merge.data,date)

n<-length(dir)
for(i in 2:n){
  new.data=read.csv(dir[i],header=T,sep=",",stringsAsFactors=FALSE)
  date<-rep(file_name_number[i],length(new.data[,1]))
  new.data.i=cbind(new.data,date)
  merge.data.whole<-rbind(merge.data.whole,new.data.i)#总的数据
}
merge.data.whole<-na.omit(merge.data.whole)
#write.csv(merge.data.whole,file = "D:\\week_datamerge.csv",row.names=F)
rm(date,  new.data,  new.data.i,  merge.data)
gc()

###################生成重量区间#####################
weight_interval<-rep(NA,length(merge.data.whole[,1]))
weight_interval[which(merge.data.whole$carat<0.3)]<-paste("\u2264","0.29",sep="")
weight_interval[which(merge.data.whole$carat<=0.34&merge.data.whole$carat>=0.30)]<-"0.30-0.34"
weight_interval[which(merge.data.whole$carat<=0.39&merge.data.whole$carat>=0.35)]<-"0.35-0.39"
weight_interval[which(merge.data.whole$carat<=0.44&merge.data.whole$carat>=0.40)]<-"0.40-0.44"
weight_interval[which(merge.data.whole$carat<=0.49&merge.data.whole$carat>=0.45)]<-"0.45-0.49"
weight_interval[which(merge.data.whole$carat<=0.54&merge.data.whole$carat>=0.50)]<-"0.50-0.54"
weight_interval[which(merge.data.whole$carat<=0.59&merge.data.whole$carat>=0.55)]<-"0.55-0.59"
weight_interval[which(merge.data.whole$carat<=0.64&merge.data.whole$carat>=0.60)]<-"0.60-0.64"
weight_interval[which(merge.data.whole$carat<=0.69&merge.data.whole$carat>=0.65)]<-"0.65-0.69"
weight_interval[which(merge.data.whole$carat<=0.74&merge.data.whole$carat>=0.70)]<-"0.70-0.74"
weight_interval[which(merge.data.whole$carat<=0.79&merge.data.whole$carat>=0.75)]<-"0.75-0.79"
weight_interval[which(merge.data.whole$carat<=0.84&merge.data.whole$carat>=0.80)]<-"0.80-0.84"
weight_interval[which(merge.data.whole$carat<=0.89&merge.data.whole$carat>=0.85)]<-"0.85-0.89"
weight_interval[which(merge.data.whole$carat<=0.94&merge.data.whole$carat>=0.90)]<-"0.90-0.94"
weight_interval[which(merge.data.whole$carat<=0.99&merge.data.whole$carat>=0.95)]<-"0.95-0.99"
weight_interval[which(merge.data.whole$carat<=1.09&merge.data.whole$carat>=1.00)]<-"1.00-1.09"
weight_interval[which(merge.data.whole$carat<=1.49&merge.data.whole$carat>=1.10)]<-"1.10-1.49"
weight_interval[which(merge.data.whole$carat>1.49)]<-paste("\u2265","1.50",sep="")
add_interval_merge_data_whole<-cbind(merge.data.whole[,1:2],weight_interval)
add_interval_merge_data_whole<-cbind(add_interval_merge_data_whole,merge.data.whole[,3:19])

first_day<-add_interval_merge_data_whole[which(add_interval_merge_data_whole$date==file_name_number[1]),]#第一天数据
last_day<-add_interval_merge_data_whole[which(add_interval_merge_data_whole$date==file_name_number[n]),]#最后一天数据
RNNNN<-add_interval_merge_data_whole[which(add_interval_merge_data_whole$shape=="圆形"&add_interval_merge_data_whole$fluorescence=="N"&add_interval_merge_data_whole$milky=="无奶"&add_interval_merge_data_whole$colsh=="无咖"&add_interval_merge_data_whole$green=="无绿"),]

rm(add_interval_merge_data_whole, merge.data.whole, weight_interval)
gc()

########按日期降序得到库存唯一表,分为证书是否为空值############
RNNNN<-RNNNN[order(-RNNNN$date),]
RNNNN_kong<-RNNNN[which(RNNNN$reportno==""),]
RNNNN_normal<-RNNNN[which(RNNNN$reportno!=""),]

index_duplicated<-duplicated(RNNNN_normal$reportno)
RNNNN_normal_only<-RNNNN_normal[!index_duplicated,]#非空证书唯一

index_duplicated<-duplicated(RNNNN_kong$stoneid)
RNNNN_kong_only<-RNNNN_kong[!index_duplicated,]#空证书唯一

merge_RNNNN_only<-rbind(RNNNN_normal_only,RNNNN_kong_only)#库存唯一

rm(RNNNN, RNNNN_kong, RNNNN_normal, index_duplicated)
gc()

#########“ 标识重复个案” 匹配。保留标识为0的数据，同时再删除日期编码为最后一天的数据##############
mark0<-function(RNNNN_normal_only_noend_normal,compared_date,col_number){
  sale_normal<-table(RNNNN_normal_only_noend_normal[,col_number])
  sale_normal_name<-names(sale_normal[which(sale_normal==1)])
  sale_normal_index<-RNNNN_normal_only_noend_normal[,col_number]%in%sale_normal_name
  sale_normal_2<-RNNNN_normal_only_noend_normal[sale_normal_index,]
  sale_normal_3<-sale_normal_2[which(sale_normal_2$date!=compared_date),]
  return(sale_normal_3)
}
do_merge<-function(RNNNN_normal_only_noend,n,id){
  sale_date<-file_name_number[n]
  if(id==1){
  RNNNN_normal_only_noend_normal<-RNNNN_normal_only_noend[which(RNNNN_normal_only_noend$reportno!=""),]
  RNNNN_normal_sale<-mark0(RNNNN_normal_only_noend_normal,sale_date,15)
  } else{
  RNNNN_normal_only_noend_kong<-RNNNN_normal_only_noend[which(RNNNN_normal_only_noend$reportno==""),]
  RNNNN_normal_sale<-mark0(RNNNN_normal_only_noend_kong,sale_date,17)
  }
  return(RNNNN_normal_sale)
}
###############销售掉的唯一##########
RNNNN_normal_only_noend<-RNNNN_normal_only[which(RNNNN_normal_only$date!=file_name_number[n]),]
RNNNN_kong_only_noend<-RNNNN_kong_only[which(RNNNN_kong_only$date!=file_name_number[n]),]

RNNNN_normal_only_noend<-rbind(RNNNN_normal_only_noend,last_day)
sale_RNNNN_normal_only_noend<-do_merge(RNNNN_normal_only_noend,n,1)#0为空证书，1为非空证书

RNNNN_kong_only_noend<-rbind(RNNNN_kong_only_noend,last_day)
sale_RNNNN_kong_only_noend<-do_merge(RNNNN_kong_only_noend,n,0)

sale_RNNNN_only_noend<-rbind(sale_RNNNN_normal_only_noend,sale_RNNNN_kong_only_noend)

rm(RNNNN_normal_only_noend,RNNNN_kong_only_noend)
gc()

##################畅销数据##############
best_RNNNN_normal<-rbind(sale_RNNNN_normal_only_noend,first_day) 
best_RNNNN_kong<-rbind(sale_RNNNN_kong_only_noend,first_day)

bestseller_RNNNN_normal<-do_merge(best_RNNNN_normal,1,1)
bestseller_RNNNN_kong<-do_merge(best_RNNNN_kong,1,0)

bestseller_RNNNN<-rbind(bestseller_RNNNN_normal,bestseller_RNNNN_kong)
rm(best_RNNNN_normal,best_RNNNN_kong,bestseller_RNNNN_normal,bestseller_RNNNN_kong)
gc()

############新增数据#############
RNNNN_normal_only_nofirst<-RNNNN_normal_only[which(RNNNN_normal_only$date!=file_name_number[1]),]
RNNNN_kong_only_nofirst<-RNNNN_kong_only[which(RNNNN_kong_only$date!=file_name_number[1]),]

RNNNN_normal_only_nofirst<-rbind(RNNNN_normal_only_nofirst,first_day)
sale_RNNNN_normal_only_nofirst<-do_merge(RNNNN_normal_only_nofirst,1,1)

RNNNN_kong_only_nofirst<-rbind(RNNNN_kong_only_nofirst,first_day)
sale_RNNNN_kong_only_nofirst<-do_merge(RNNNN_kong_only_nofirst,1,0)

sale_RNNNN_only_nofirst<-rbind(sale_RNNNN_normal_only_nofirst,sale_RNNNN_kong_only_nofirst)

rm(RNNNN_normal_only_nofirst,RNNNN_kong_only_nofirst,sale_RNNNN_normal_only_nofirst,sale_RNNNN_kong_only_nofirst)
gc()

write.csv(merge_RNNNN_only,file="库存唯一.csv",row.names = F)
write.csv(sale_RNNNN_only_noend,file="销售掉的数据.csv",row.names=F)
write.csv(bestseller_RNNNN,file="畅销数据.csv",row.names=F)
write.csv(sale_RNNNN_only_nofirst,file="新增数据.csv",row.names = F)