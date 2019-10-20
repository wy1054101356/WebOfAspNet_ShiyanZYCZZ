<html>
<head>
<title>标签模式变量</title>
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
.title{font-weight:bold;height:25px;font-size:13px;color:#cc0000}

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
<div class="title">预设变量及方法：</div>
<b>Site_Id</b>：数值型变量，当前的站点ID。<br>
<%if(Request.QueryString["type"]=="member"){%>
<b>UserName</b>：字符型变量，当前的登录用户名。<br>
<b>UID</b>：数值型变量，当前的登录用户名ID。<br>
<b>MemberTypeId</b>：数值型变量，当前的登录用户所在的会员类别ID。<br>
<b>DepartmentId</b>：数值型变量，当前的登录用户所属的部门ID，如未设置部门，此值为0。<br>
<%}%>
<b>Get_Data(string field,string sql)</b>：返回一个String类型的值，必须填写两个字符型参数，第一个参数为字段名(如标题字段：title)，第二个参数为自己构造的sql语句，此函数主要用来获取关联表中某个字段的值，下面为此方法的演示代码：
<br><textarea id="Use_Beizhu" style="width:650px;height:100px;font-size:13px;">
代码演示：
&lt;% 
string thetitle=Get_Data("title","select title from article where id=15"); 
%&gt;
作用说明：从article表中读取id等于15的title字段的值,然后赋值给thetitle变量
</textarea>

<br><b>Get_Data(string sql)</b>：返回一个DataTable类型数据集，自定义表内容页的URL的调用方法：&lt;%=Detail_Url(DataRow变量)%&gt;，下面为此方法的演示代码：
<br><textarea id="Use_Beizhu" style="width:90%;height:130px;font-size:13px;">
代码演示：
&lt;% 
DataTable dt=Get_Data("select top 10 * from article where site_id=<%=Request.Cookies["SiteId"].Value%>"); 
DataRow dr;
for(int i=0;i<dt.Rows.Count;i++)
 {
  dr=dt.Rows[i]; //说明：给dr赋值
%&gt;
<%if(Request.QueryString["type"]=="js"){%>document.write('<%}%><a href="&lt;%=Detail_Url(dr,"article")%>">&lt;%=dr["title"].ToString()%></a><br><%if(Request.QueryString["type"]=="js"){%>');<%}%>
&lt;%
 }
%&gt;
语法说明：
 dr：定义一个DataRow变量，可理解数据表中的一行。
 Detail_Url(dr)：自定义表内容页地址的调用方法。
 dr["title"].ToString()：数据表中title字段值的调用方法。
 以上遵行asp.net语法，可在现有基础上自行扩展。
</textarea>

<%if(Request.QueryString["type"]=="member" || Request.QueryString["type"]=="sublanmu"){%>
<br><b>Get_Data(string query_sql,string count_sql,int pagesize)</b>：这个方法包含三个参数，和上一个方法的区别是这个可以支持分页显示，第1个参数为sql查询命令，第2个参数为sql统计命令，第3个参数为每页显示数，下面为此方法的演示代码：
<br><textarea id="Use_Beizhu" style="width:90%;height:130px;font-size:13px;">
代码演示：
&lt;% 
DataTable dt=Get_Data("select * from article where site_id=<%=Request.Cookies["SiteId"].Value%>","select count(id) as co from article where site_id=<%=Request.Cookies["SiteId"].Value%>",5); 
DataRow dr;
for(int i=0;i<dt.Rows.Count;i++)
 {
  dr=dt.Rows[i]; //说明：给dr赋值
%&gt;
<a href="&lt;%=Detail_Url(dr,"article")%>">&lt;%=dr["title"].ToString()%></a><br>
&lt;%
 }
%&gt;
语法说明：
 dr：定义一个DataRow变量，可理解数据表中的一行。
 Detail_Url(dr)：自定义表内容页地址的调用方法。
 dr["title"].ToString()：数据表中title字段值的调用方法。
 以上遵行asp.net语法，可在现有基础上自行扩展。
</textarea>
<%}%>
</td></tr>
</table>
<div style="text-align:left;padding:10px 0 0 10px">说明：变量及方法调用严格注意大小写；</div>
</form>
</center>
</body>
</html>  