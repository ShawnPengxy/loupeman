# 库存数据更新


##1. 引言


   找珠宝网网站每日库存数据更新的数据清洗工作主要是由R和EXCEL共同完成，下面介绍将逐一说明具体流程。


##2. 库存表格预处理


把收集好的供应商每日最新库存表逐一用EXCEl软件打开，删除表头和表尾，保证表格第一行是各列属性字段；然后检查并处理表格可能出现的异常情况（比如说，信息缺失和信息错误）；最后，把表格另存为以供应商RapnetID命名的csv格式，并放在**CSV_revised_sheets**文件夹下，用[data_import.R]("https://github.com/ShawnPengxy/loupeman/blob/master/data_import.R")把所有表格导入R软件中。
   
