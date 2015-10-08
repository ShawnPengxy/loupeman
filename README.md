# 库存数据更新


##1. 引言


   找珠宝网网站每日库存数据更新的数据清洗工作主要是由R和EXCEL共同完成，下面介绍将逐一说明具体流程。


##2. 库存数据预处理


把收集好的供应商每日最新库存表逐一用EXCEl软件打开，删除表头和表尾，保证表格第一行是各列属性字段；然后检查并处理表格可能出现的异常情况（比如说，信息缺失和信息错误）；最后，把所有表格另存为以供应商Rapnet ID命名的csv格式，并放在**CSV_revised_sheets**文件夹下，用[data_import.R](https://github.com/ShawnPengxy/loupeman/blob/master/data_import.R "data_import.R")把所有表格导入R软件中。


##3. 库存数据转换
首先，对公司业务拓展遇到的每一家供应商，都需要为其单独写一个R脚本(以该公司的Rapnet ID来标记脚本)来提取其库存表格数据（按照公司自身的数据需求，从供应商表格中刷选出有价值的各列数据），然后统一放在[__R_script_inventory__](https://github.com/ShawnPengxy/loupeman/tree/master/R_script_inventory)文件夹中。然后挑选出合作的供应商对应的数据提取脚本，放入[**R_script_input**](https://github.com/ShawnPengxy/loupeman/tree/master/R_script_input)文件夹中，并用[data_doing.R](https://github.com/ShawnPengxy/loupeman/blob/master/data_doing.R)运行该文件夹下所有脚本, 输出结果保存在**R_input**文件夹中。


再则，把**R_input**文件夹中所有[表格合并](https://github.com/ShawnPengxy/loupeman/blob/master/table_merge.R "table_merge.R")成一张总表.再利用[normm.R](https://github.com/ShawnPengxy/loupeman/blob/master/normm.R)把总表中的数据转换成[公司网站](http://www.zhaozhubao.com/ "找珠宝网")显示的数据格式。


最后，结合公司业务需求，删除无效数据后，把清洗好的数据划分成分白钻数据和彩钻数据分别保存。


##4. 库存数据修饰
由于采购商对白钻价格的敏感程度高，所以需要在白钻数据上传至公司网站前对价格进行[核查](https://github.com/ShawnPengxy/loupeman/blob/master/check_rapprice.R "check_rapprice.R")，删除白钻数据中与国际标准参考价格不匹配的数据。


对于白钻数据和彩钻数据，为每个供应商添加公司自己的[分配编号](https://github.com/ShawnPengxy/loupeman/blob/master/id_match.R "id_match.R")，从R软件中输出数据并上传至[公司网站](http://www.zhaozhubao.com/_my/crystal_diamonds/create  "找珠宝网库存数据上传")。


##5.白钻每周销量分析的数据处理
选取一周的白钻销量数据，利用对[重复值筛选方法](https://github.com/ShawnPengxy/loupeman/blob/master/week_report.R "week_report.R"), 得到白钻每周的库存唯一数据、销量数据、畅销数据和新增数据，再利用EXCEL等其他办公软件制作周分析报告。

   
