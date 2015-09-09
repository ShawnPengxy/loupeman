round_rapprice<- read.csv("./圆钻价格匹配表.csv", header=TRUE,stringsAsFactors=FALSE)
nonround_rapprice<-read.csv("./异形钻价格匹配表.csv",header=T,stringsAsFactors = F)
unchecked_data<-TTT[names(TTT)%in%c("shape","carat","color","clarity","rapprice","rapnetid")]


weight_interval<-rep(NA,length(TTT[,1]))
weight_interval[which(TTT$carat<=0.03&TTT$carat>=0.01)]<-"0.01-0.03"
weight_interval[which(TTT$carat<=0.07&TTT$carat>=0.04)]<-"0.04-0.07"
weight_interval[which(TTT$carat<=0.14&TTT$carat>=0.08)]<-"0.08-0.14"
weight_interval[which(TTT$carat<=0.17&TTT$carat>=0.15)]<-"0.15-0.17"
weight_interval[which(TTT$carat<=0.22&TTT$carat>=0.18)]<-"0.18-0.22"
weight_interval[which(TTT$carat<=0.29&TTT$carat>=0.23)]<-"0.23-0.29"
weight_interval[which(TTT$carat<=0.39&TTT$carat>=0.30)]<-"0.30-0.39"
weight_interval[which(TTT$carat<=0.49&TTT$carat>=0.40)]<-"0.40-0.49"
weight_interval[which(TTT$carat<=0.69&TTT$carat>=0.50)]<-"0.50-0.69"
weight_interval[which(TTT$carat<=0.89&TTT$carat>=0.70)]<-"0.70-0.89"
weight_interval[which(TTT$carat<=0.99&TTT$carat>=0.90)]<-"0.90-0.99"
weight_interval[which(TTT$carat<=1.49&TTT$carat>=1.00)]<-"1.00-1.49"
weight_interval[which(TTT$carat<=1.99&TTT$carat>=1.50)]<-"1.50-1.99"
weight_interval[which(TTT$carat<=2.99&TTT$carat>=2.00)]<-"2.00-2.99"
weight_interval[which(TTT$carat<=3.99&TTT$carat>=3.00)]<-"3.00-3.99"
weight_interval[which(TTT$carat<=4.99&TTT$carat>=4.00)]<-"4.00-4.99"
weight_interval[which(TTT$carat<=5.99&TTT$carat>=5.00)]<-"5.00-5.99"
weight_interval[which(TTT$carat<=10.99&TTT$carat>=10.00)]<-"10.00-10.99"
unchecked_combine<-paste(weight_interval,unchecked_data$color,unchecked_data$clarity,sep="")
unchecked_data<-cbind(unchecked_data,unchecked_combine)


round_unchecked_data<-unchecked_data[which(unchecked_data$shape=="圆形"),]
nonround_unchecked_data<-unchecked_data[which(unchecked_data$shape!="圆形"),]
error_round<-round_unchecked_data[1,]
error_nonround<-nonround_unchecked_data[1,]
n<-length(round_rapprice[,1])
for(i in 1:n){
  
  temp_round1<-round_unchecked_data$unchecked_combine%in%round_rapprice$组合[i]
  round_data<-round_unchecked_data[temp_round1,]
  temp_round2<-as.numeric(round_data$rapprice)%in%as.numeric(round_rapprice$国际报价[i])
  error_round2<-round_data[!temp_round2,]
  error_round<-rbind(error_round,error_round2)
  
  
  
  temp_nonround1<-nonround_unchecked_data$unchecked_combine%in%nonround_rapprice$组合[i]
  nonround_data<-nonround_unchecked_data[temp_nonround1,]
  temp_nonround2<-as.numeric(nonround_data$rapprice)%in%as.numeric(nonround_rapprice$国际报价[i])
  error_nonround2<-nonround_data[!temp_nonround2,]
  error_nonround<-rbind(error_nonround,error_nonround2)
  
}

error_round<-error_round[-1,]
error_nonround<-error_nonround[-1,]
                              

temp1<-rownames(TTT)%in%rownames(error_round)
TTT[temp1,]<-NA
temp2<-rownames(TTT)%in%rownames(error_nonround)
TTT[temp2,]<-NA
TTT1<-na.omit(TTT)

A<-length(error_round[,1])
B<-length(error_nonround[,1])
