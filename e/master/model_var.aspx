<html>
<head>
<title>模型变量</title>
</head>
<style type="text/css">
body{word-wrap:break-word;margin-top:0;margin-left:0;margin-right:0;margin-bottom:0;font-size:12px}
table{word-wrap:break-word;word-break:break-all}
p{padding:0 0 0 0;margin:0 0 0 0;}
td,div{font-size:9pt;color:#000000;font-family:宋体,Arial;}
a:link{color:#000000;
	text-decoration: none;
}
a:visited {color:#000000;
	text-decoration: underline;
}
a:hover {color:#000000;
	 text-decoration: none;
}
.table_style2{
border-width: 1px;
	border-left-style: solid;
	border-right-style: solid;
	border-bottom-style: solid;
	border-top-style: solid;
	border-color:#808080;
        background-color:#D1EAFE;
}
.title{font-weight:bold;height:25px;font-size:13px;color:#990000}

</style>
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table border=0 cellpadding=0 cellspacing=0 width=95% align=center>
 <tr><td height=10></td></tr>
</table>
<form runat="server" >
<table border=0 cellpadding=5 cellspacing=0 width=98% align=center class=table_style2>
 <tr>
  <td style="line-height:20px;">
<div id="nav" style="display:none">
<div class="title">导航模型预设变量或方法：</div>
<b>conn</b>：预定义的OleDbConnection对象，conn.Open()和conn.Close()已经在页面开始和结束处定义，用户不需要再定义。
<br><b>Site_Id</b>：数值型变量，信息所属的站点id，每个表都有一个site_id字段来区分所属站。
<br><b>Language</b>：字符型变量，信息所属的站点语种，如中文就是"zh-cn",英文是"en"。
<br><b>Nav_Id</b>：字符型变量，可以用来作html的id唯一标示。
<br><b>Sort_Id</b>：数值型变量，导航表(pa_nav)中调用信息的分类id，Sort_Id为0表示调用所有分类数据。
<br><b>Sql_Sort</b>：字符型变量，通过Sort_Id转换来的信息筛选条件，可以再模型中重新定义，如：Sql_Sort="sort_id=5";
<br><b>Sql_Condition</b>：字符型变量，表示信息筛选条件，可以在模型中重新定义，如：Sql_Condition="and clicks>5";
<br><b>Sql_Order</b>：字符型变量，表示信息排序方式，可以在模型中重新定义，如：Sql_Order="order by id";
<br><b>Sort_Name(int sort_id)</b>：返回信息的分类名称,sort_id：分类id。
<br><b>Sort_Url(int site_id,string table,int sort_id)</b>：返回信息分类的子栏目调用链接,site_id：站点id，table：表名称，sort_id：分类id。
<br><b>Lanmu_Url(int site_id,int id,string lanmu_dir,string lanmu_file,string zdy_url)</b>;返回栏目的url地址，对应参数分别表示pa_lanmu表中对应字段值。
<br><b>Sublanmu_Url(int site_id,int lanmu_id,int id,string parent_dir,string lanmu_dir,string sublanmu_dir,string zdy_url)</b>;返回子栏目的url地址，对应参数分别表示pa_sublanmu表中对应字段值。
<br><b>TitlePic_Size</b>：字符型变量，标题图片的长和宽样式，html的调用方式为：style="&lt;%=TitlePic_Size%&gt;"
<br><b>Title_Num</b>：数值型变量，标题显示的字符数;
<br><b>Target</b>：字符型变量，可能值为：_self、_target，html的调用方式为： target="&lt;%=Target%&gt;"
<br><b>Get_Reply(string table,int id)</b>：预设方法，返回对应的信息回复(DataTable类型),id为信息id字段，数值型参数；<b>返回的DataTable包括字段</b> reply：回复内容；username：回复用户账号；truename：回复人姓名；department：回复人所在部门；thedate：回复时间     
</div>

<div id="module" style="display:none">
<div class="title">模块模型预设变量或方法：</div>
<b>conn</b>：预定义的OleDbConnection对象，conn.Open()和conn.Close()已经在页面开始和结束处定义，用户不需要再定义。
<br><b>Site_Id</b>：数值型变量，信息所属的站点id，每个表都有一个site_id字段来区分所属站。
<br><b>Language</b>：字符型变量，信息所属的站点语种，如中文就是"zh-cn",英文是"en"。
<br><b>Module_Id</b>：字符型变量，可以用来作html的id唯一标示。
<br><b>Sort_Id</b>：数值型变量，模块表(pa_module)中调用信息的分类id，Sort_Id为0表示调用所有分类数据。
<br><b>Sql_Sort</b>：字符型变量，通过Sort_Id转换来的信息筛选条件，可以再模型中重新定义，如：Sql_Sort="sort_id=5";
<br><b>Sql_Condition</b>：字符型变量，表示信息筛选条件，可以在模型中重新定义，如：Sql_Condition="and clicks>5";
<br><b>Sql_Order</b>：字符型变量，表示信息排序方式，可以在模型中重新定义，如：Sql_Order="order by id";
<br><b>Sort_Name(int sort_id)</b>：返回信息的分类名称,sort_id：分类id。
<br><b>Sort_Url(int site_id,string table,int sort_id)</b>：返回信息分类的子栏目调用链接,site_id：站点id，table：表名称，sort_id：分类id。
<br><b>Lanmu_Url(int site_id,int id,string lanmu_dir,string lanmu_file,string zdy_url)</b>;返回栏目的url地址，对应参数分别表示pa_lanmu表中对应字段值。
<br><b>Sublanmu_Url(int site_id,int lanmu_id,int id,string parent_dir,string lanmu_dir,string sublanmu_dir,string zdy_url)</b>;返回子栏目的url地址，对应参数分别表示pa_sublanmu表中对应字段值。
<br><b>TitlePic_Size</b>：字符型变量，标题图片的长和宽样式，html的调用方式为：style="&lt;%=TitlePic_Size%&gt;"
<br><b>Title_Num</b>：数值型变量，标题显示的字符数;
<br><b>Target</b>：字符型变量，可能值为：_self、_target，html的调用方式为： target="&lt;%=Target%&gt;"
<br><b>Get_Reply(string table,int id)</b>：预设方法，返回对应的信息回复(DataTable类型),id为信息id字段，数值型参数；<b>返回的DataTable包括字段</b> reply：回复内容；username：回复用户账号；truename：回复人姓名；department：回复人所在部门；thedate：回复时间     
</div>

<div id="sublanmu" style="display:none">
<div class="title">子栏目模型预设变量或方法</div>
<b>conn</b>：预定义的OleDbConnection对象，conn.Open()和conn.Close()已经在页面开始和结束处定义，用户不需要再定义。
<br><b>Site_Id</b>：数值型变量，信息所属的站点id，每个表都有一个site_id字段来区分所属站。
<br><b>Language</b>：字符型变量，信息所属的站点语种，如中文就是"zh-cn",英文是"en"。
<br><b>Sort_Id</b>：数值型变量，子栏目表(pa_sublanmu)调用信息的分类id，Sort_Id为0表示调用所有分类数据。
<br><b>Sql_Sort</b>：字符型变量，通过Sort_Id转换来的信息筛选条件，可以再模型中重新定义，如：Sql_Sort="sort_id=5";
<br><b>Sql_Condition</b>：字符型变量，表示信息筛选条件，可以在模型中重新定义，如：Sql_Condition="and clicks>5";
<br><b>Sql_Order</b>：字符型变量，表示信息排序方式，可以在模型中重新定义，如：Sql_Order="order by id";
<br><b>Sort_Name(int sort_id)</b>：返回信息的分类名称,sort_id：分类id。
<br><b>Sort_Url(int site_id,string table,int sort_id)</b>：返回信息分类的子栏目调用链接,site_id：站点id，table：表名称，sort_id：分类id。
<br><b>Lanmu_Url(int site_id,int id,string lanmu_dir,string lanmu_file,string zdy_url)</b>;返回栏目的url地址，对应参数分别表示pa_lanmu表中对应字段值。
<br><b>Sublanmu_Url(int site_id,int lanmu_id,int id,string parent_dir,string lanmu_dir,string sublanmu_dir,string zdy_url)</b>;返回子栏目的url地址，对应参数分别表示pa_sublanmu表中对应字段值。
<br><b>TitlePic_Size</b>：字符型变量，标题图片的长和宽样式，html的调用方式为：style="&lt;%=TitlePic_Size%&gt;"
<br><b>Title_Num</b>：数值型变量，标题显示的字符数;
<br><b>Target</b>：字符型变量，可能值为：_self、_target，html的调用方式为： target="&lt;%=Target%&gt;"
<br><b>Get_Reply(string table,int id)</b>：预设方法，返回对应的信息回复(DataTable类型),id为信息id字段，数值型参数；<b>返回的DataTable包括字段</b> reply：回复内容；username：回复用户账号；truename：回复人姓名；department：回复人所在部门；thedate：回复时间     
</div>

<div id="detail" style="display:none">
<div class="title">内容页模型预设变量或方法</div>
<b>conn</b>：预定义的OleDbConnection对象，conn.Open()和conn.Close()已经在页面开始和结束处定义，用户不需要再定义。
<br><b>Site_Id</b>：数值型变量，信息所属的站点id，每个表都有一个site_id字段来区分所属站。
<br><b>Language</b>：字符型变量，信息所属的站点语种，如中文就是"zh-cn",英文是"en"。
<br><b>Sort_Id</b>：数值型变量，子栏目表(pa_sublanmu)调用信息的分类id，Sort_Id为0表示调用所有分类数据。
<br><b>Sql_Sort</b>：字符型变量，上级子栏目中通过Sort_Id转换来的信息筛选条件，可以再模型中重新定义，如：Sql_Sort="sort_id=5";
<br><b>Sql_Condition</b>：字符型变量，上级子栏目的信息筛选条件，可以在模型中重新定义，如：Sql_Condition="and clicks>5";
<br><b>Sql_Order</b>：字符型变量，上级子栏目的信息排序方式，可以在模型中重新定义，如：Sql_Order="order by id";
<br><b>Sort_Name(int sort_id)</b>：返回信息的分类名称,sort_id：分类id。
<br><b>Sort_Url(int site_id,string table,int sort_id)</b>：返回信息分类的子栏目调用链接,site_id：站点id，table：表名称，sort_id：分类id。
<br><b>Lanmu_Url(int site_id,int id,string lanmu_dir,string lanmu_file,string zdy_url)</b>;返回栏目的url地址，对应参数分别表示pa_lanmu表中对应字段值。
<br><b>Sublanmu_Url(int site_id,int lanmu_id,int id,string parent_dir,string lanmu_dir,string sublanmu_dir,string zdy_url)</b>;返回子栏目的url地址，对应参数分别表示pa_sublanmu表中对应字段值。
<br><b>Detail_Id</b>：数值型变量，当前信息的id。
<br><b>Prev_and_Next()</b>：预设方法，使用_Previous和_Next时候必须先调用此方法(注：数据量较大时建议不要调用，速度较慢)
<br><b>_Previous</b>：字符型变量，获取上一篇信息，无上一篇则为空值。
<br><b>_Next</b>：字符型变量，获取下一篇信息，无下一篇则为空值。
<br><b>Related_Ids</b>：字符型变量，相关信息的id集合，id之间用“，”隔开，无相关信息则Related_Ids等于"0"。
<br><b>Get_Reply(string table,int id)</b>：预设方法，返回对应的信息回复(DataTable类型),id为信息id字段，数值型参数；<b>返回的DataTable包括字段</b> reply：回复内容；username：回复用户账号；truename：回复人姓名；department：回复人所在部门；thedate：回复时间     
</div>

<div id="search" style="display:none">
<div class="title">搜索模型预设变量或方法</div>
<b>conn</b>：预定义的OleDbConnection对象，conn.Open()和conn.Close()已经在页面开始和结束处定义，用户不需要再定义。
<br><b>Language</b>：字符型变量，信息所属的站点语种，如中文就是"zh-cn",英文是"en"。
<br><b>PageSize</b>：数值型变量，表示信息每页显示数，可以再模型中重新定义。
<br><b>Site_Id</b>：数值型变量，信息所属的站点id，每个表都有一个site_id字段来区分所属站。
<br><b>Sort_Id</b>：数值型变量，表示信息的分类id,系统自动通过url地址栏中sort值来获取，url中无sortid参数时则为0。
<br><b>Sql_Sort</b>：字符型变量，通过Sort_Id转换来的信息筛选条件，可以再模型中重新定义，如：Sql_Sort="sort_id=5";
<br><b>Sql_Condition</b>：字符型变量，表示信息筛选条件，可以在模型中重新定义，如：Sql_Condition="and clicks>5";
<br><b>Sql_Order</b>：字符型变量，表示信息排序方式，可以在模型中重新定义，如：Sql_Order="order by id";
<br><b>Sort_Name(int sort_id)</b>：返回信息的分类名称,sort_id：分类id。
<br><b>Sort_Url(int site_id,string table,int sort_id)</b>：返回信息分类的子栏目调用链接,site_id：站点id，table：表名称，sort_id：分类id。
<br><b>Lanmu_Url(int site_id,int id,string lanmu_dir,string lanmu_file,string zdy_url)</b>;返回栏目的url地址，对应参数分别表示pa_lanmu表中对应字段值。
<br><b>Sublanmu_Url(int site_id,int lanmu_id,int id,string parent_dir,string lanmu_dir,string sublanmu_dir,string zdy_url)</b>;返回子栏目的url地址，对应参数分别表示pa_sublanmu表中对应字段值。
<br><b>Get_Reply(string table,int id)</b>：预设方法，返回对应的信息回复(DataTable类型),id为信息id字段，数值型参数；<b>返回的DataTable包括字段</b> reply：回复内容；username：回复用户账号；truename：回复人姓名；department：回复人所在部门；thedate：回复时间     
</div>

<div id="ajax" style="display:none">
<div class="title">ajax模型预设变量或方法</div>
<b>conn</b>：预定义的OleDbConnection对象，conn.Open()和conn.Close()已经在页面开始和结束处定义，用户不需要再定义。
<br><b>Site_Id</b>：数值型变量，信息所属的站点id，每个表都有一个site_id字段来区分所属站。
<br><b>Sort_Id</b>：数值型变量，导航表(pa_nav)中调用信息的分类id，Sort_Id为0表示调用所有分类数据。
<br><b>Sql_Sort</b>：字符型变量，通过Sort_Id转换来的信息筛选条件，可以再模型中重新定义，如：Sql_Sort="sort_id=5";
<br><b>Sql_Condition</b>：字符型变量，表示信息筛选条件，可以在模型中重新定义，如：Sql_Condition="and clicks>5";
<br><b>Sql_Order</b>：字符型变量，表示信息排序方式，可以在模型中重新定义，如：Sql_Order="order by id";
<br><b>Sort_Name(int sort_id)</b>：返回信息的分类名称,sort_id：分类id。
<br><b>Sort_Url(int site_id,string table,int sort_id)</b>：返回信息分类的子栏目调用链接,site_id：站点id，table：表名称，sort_id：分类id。
<br><b>Lanmu_Url(int site_id,int id,string lanmu_dir,string lanmu_file,string zdy_url)</b>;返回栏目的url地址，对应参数分别表示pa_lanmu表中对应字段值。
<br><b>Sublanmu_Url(int site_id,int lanmu_id,int id,string parent_dir,string lanmu_dir,string sublanmu_dir,string zdy_url)</b>;返回子栏目的url地址，对应参数分别表示pa_sublanmu表中对应字段值。
<br><b>Get_Reply(string table,int id)</b>：预设方法，返回对应的信息回复(DataTable类型),id为信息id字段，数值型参数；<b>返回的DataTable包括字段</b> reply：回复内容；username：回复用户账号；truename：回复人姓名；department：回复人所在部门；thedate：回复时间     
</div>

<div id="custom" style="display:none">
<div class="title">自定义模型预设变量或方法</div>
<b>conn</b>：预定义的OleDbConnection对象，conn.Open()和conn.Close()已经在页面开始和结束处定义，用户不需要再定义。
<br><b>Site_Id</b>：数值型变量，信息所属的站点id，每个表都有一个site_id字段来区分所属站。
<br><b>Sort_Id</b>：数值型变量，导航表(pa_nav)中调用信息的分类id，Sort_Id为0表示调用所有分类数据。
<br><b>Sql_Sort</b>：字符型变量，通过Sort_Id转换来的信息筛选条件，可以再模型中重新定义，如：Sql_Sort="sort_id=5";
<br><b>Sql_Condition</b>：字符型变量，表示信息筛选条件，可以在模型中重新定义，如：Sql_Condition="and clicks>5";
<br><b>Sql_Order</b>：字符型变量，表示信息排序方式，可以在模型中重新定义，如：Sql_Order="order by id";
<br><b>Sort_Name(int sort_id)</b>：返回信息的分类名称,sort_id：分类id。
<br><b>Sort_Url(int site_id,string table,int sort_id)</b>：返回信息分类的子栏目调用链接,site_id：站点id，table：表名称，sort_id：分类id。
<br><b>Lanmu_Url(int site_id,int id,string lanmu_dir,string lanmu_file,string zdy_url)</b>;返回栏目的url地址，对应参数分别表示pa_lanmu表中对应字段值。
<br><b>Sublanmu_Url(int site_id,int lanmu_id,int id,string parent_dir,string lanmu_dir,string sublanmu_dir,string zdy_url)</b>;返回子栏目的url地址，对应参数分别表示pa_sublanmu表中对应字段值。
<br><b>Get_Reply(string table,int id)</b>：预设方法，返回对应的信息回复(DataTable类型),id为信息id字段，数值型参数；<b>返回的DataTable包括字段</b> reply：回复内容；username：回复用户账号；truename：回复人姓名；department：回复人所在部门；thedate：回复时间     
</div>
</td></tr>
</table>
<div style="text-align:left;padding:10px 0 0 10px">说明：变量及方法调用严格注意大小写；</div>
</form>
</center>
<script type="text/javascript">
document.getElementById("<%=Request.QueryString["type"]%>").style.display="";
</script>
</body>
</html>  