<% @ Page Language="C#" Inherits="PageAdmin.model_set"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="zdytable_list"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b><%=Request.QueryString["name"]%>[<%=Model_Type%>]</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<iframe name="post_iframe" id="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form runat="server" target="post_iframe">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
   <table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
    <tr>
    <td height=20px><b>当前数据表：</b><%=TheTable%></td>
   </tr>
  </table>

 <table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
   <tr>
    <td width=100px >字段调用</td>
    <td width=150px align=left>
    <select Name="Fields" id="Fields" size="9" onclick="Get_FieldUse(this.options[this.selectedIndex].value)" style="width:200px">
    </select>
   </td>
    <td align=left>
<a href="javascript:show_textarea(2)" style="font-weight:bold" id="a">模型基本语法参考>></a>&nbsp;
<% if(Request.QueryString["type"]=="ajax" ){%>
<a href="javascript:show_textarea(3)" id="b">ajax调用>></a>&nbsp;
<%}%>
<% if(Request.QueryString["type"]=="custom"){%>
<a href="javascript:show_textarea(3)" id="b">自定义文件调用>></a>&nbsp;
<%}%>
<a href="javascript:show_var('<%=Request.QueryString["type"]%>')" id="b">其他预设变量或方法>></a>
<br>
<textarea id="Field_Use" style="width:590px;height:130px;display:none"></textarea>
<textarea id="ajax_user" style="width:590px;height:130px;display:none">
<% if(Request.QueryString["type"]=="ajax"){%><script src="/e/aspx/ajax_list.aspx?modelid=<%=Request.QueryString["id"]%>" type="text/javascript"></script>
<script type="text/javascript">
var ajaxparameter_<%=Request.QueryString["id"]%>="siteid=<%=SiteId%>&sortid=0&pagesize=20&sqlorder=id desc"
rajax_<%=Request.QueryString["id"]%>(1,true);//第1个参数为当前页次，第2个参数为是否异步加载;
//function ajax_<%=Request.QueryString["id"]%>_back(backcontent){}
</script>
变量说明：
ajaxparameter_<%=Request.QueryString["id"]%>：参数变量，用户可以自行增加参数，参数之间用“&”隔开。
参数说明：
siteid：站点id 
sortid：信息分类id,0表示显示所有分类。
pagesize：每页显示数，无此参数则默认20
sqlorder：信息排序方式
回调函数：
function ajax_<%=Request.QueryString["id"]%>_back(backcontent){}
其中参数backcontent为ajax返回的内容，如果页面存在此函数(默认注释掉，如需使用删除掉注释符即可)，则执行此函数，否则默认在页面中加载返回的内容。
<%}%>
<% if(Request.QueryString["type"]=="custom"){%>自定义文件路径：/e/zdymodel/<%=Request.QueryString["table"]%>/custom/<%=Request.QueryString["id"]%>.aspx?siteid=<%=SiteId%>&sortid=0&pagesize=20&sqlorder=id desc;

说明：可根据实际需要对以上路径进行调用、并可自行定义url参数等。
url参数说明：
siteid：站点id 
sortid：信息分类id,0表示显示所有分类。
pagesize：每页显示数,无次参数则默认20
sqlorder：信息排序方式
<%}%>
</textarea>
<textarea id="Use_Beizhu" style="width:590px;height:130px">
&lt;% 
DataTable dt=Get_Data();
DataRow dr;
for(int i=0;i<dt.Rows.Count;i++)
 {
  dr=dt.Rows[i]; //说明：给dr赋值
%&gt;
<a href="&lt;%=Detail_Url(dr)%>">&lt;%=dr["title"].ToString()%></a><br>
&lt;%
 }
%&gt;
语法说明：
 Get_Data(<% if(Request.QueryString["type"]=="custom"){%>"sql查询语句"<%}%>):为系统提供的方法，返回一个DataTable类型数据,可自定义参数(sql查询语句)
 dr：定义一个DataRow变量，可理解数据表中的一行。
 Detail_Url(dr)：内容页地址的调用方法。
 dr["title"].ToString()：数据表中title字段值的调用方法，其他字段调用可以通过点击左上角的字段来获取。
 以上遵行asp.net语法，可在现有基础上自行扩展。
</textarea>
   </td>
   </tr>
   </table>

   <div name="tabcontent" id="tabcontent">
    <table border=0 cellpadding=0 cellspacing=5 width=95% align=center>
     <tr><td width="100px">内容区<span style="color:#ff0000">*</span></td>
     <td><TextArea name="model_content" style="width:98%;height:400px"><%=Model_Content%></TextArea></td>
     </tr>
    </table>
   </div>

<div align="center">
<span id="post_area">
<asp:Button cssclass="button" Text="保存" onclick="Data_Update" Id="Bt_Submit" Runat="server" />
<input type="button" class=button  value="关闭"  onclick="parent.CloseDialog()">
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>   
</div>
</td>
</tr>
</table>
<br>
<div align=left>
获取数据主要函数说明：<br>
 Get_Data(string sql)：返回一个DataTable类型数据集，sql参数留空则默认系统自动生成的sql；内容页的URL的调用方法：&lt;%=Detail_Url(DataRow变量)%&gt;
<br>
 Get_Data(string field,string sql)：返回一个String类型的值，必须填写两个字符型参数，第一个参数为字段名(如标题字段：title)，第二个参数为自己构造的sql语句，此函数主要用来获取关联表中某个字段的值。
<br>
</div>
</td>
</tr>
</table>
<br>
</form>
</center>
</body>
<script language="javascript">
var Model_Type="<%=Request.QueryString["type"]%>";    
var Fields="<%=Fields%>username|text|nvarchar,<%if(TableType=="product"){%>point|text|int,sendpoint|text|int,reserves|text|int,<%}%>clicks|text|intr,downloads|text|int,comments|text|int,ip|text|nvarchar,code|text|nvarchar,"
var Fields_Name="<%=Fields_Name%>用户名[预定义],<%if(TableType=="product"){%>产品兑换积分[预定义],产品购买赠送积分[预定义],产品库存[预定义],<%}%>点击数[预定义],下载数[预定义],评论数[预定义],发布ip[预定义],信息码[预定义],"
var AFields=Fields.split(',');
var AFields_Name=Fields_Name.split(',');
var obj=document.getElementById("Fields");
for(var i=0;i<AFields.length-1;i++)
 {
   if(AFields[i]!="")
    {
      obj.options.add(new Option(AFields_Name[i]+"("+AFields[i].split('|')[0]+")",AFields[i]));
    }
 }

function Get_FieldUse(Vars)
 {
   show_textarea(1);
   var Type="<%=Request.QueryString["type"]%>";
   var obj=document.getElementById("Field_Use");
   var AVars=Vars.split('|');
   var Field=AVars[0];
   var Field_Type=AVars[1];
   var Value_Type=AVars[2];
   obj.value="方法1：<"+"%=dr[\""+Field+"\"].ToString()%>"; 
   if(Field_Type=="text" || Field_Type=="textarea" || Field_Type=="editor")
    {
     if(Value_Type=="nvarchar" || Value_Type=="ntext" || Value_Type=="text")
      {
 
       obj.value+="\r\n方法2：<"+"%=Server.HtmlEncode(dr[\""+Field+"\"].ToString())%>";

       if(Field=="title" && Model_Type!="detail" && Model_Type!="search")
        {
         obj.value+="\r\n方法3：<"+"%=SubStr(dr[\""+Field+"\"].ToString(),Title_Num,true)%>";
        }
       else
        {
         obj.value+="\r\n方法3：<"+"%=SubStr(dr[\""+Field+"\"].ToString(),50,true)%>";
        }

        if(Value_Type=="ntext" || Value_Type=="text")
        {
          obj.value+="\r\n方法4：<"+"%=Add_KeyLink(dr[\""+Field+"\"].ToString(),<%=SiteId%>,false)%>";
        }
       obj.value+="\r\n\r\n说明：方法2对内容中的html或js脚本进行转码，防止会员发布的内容包含恶意代码\r\n方法3：截取前50个字符，最后一个参数表示是否对html或js进行转码，和方法2效果一样\r\n方法4：给字段内容增加关键词链接，第二个参数为站点ID，最后一个参数(true或false)表示是否全部替换，false表示只替换第一个关键词";
   
      }
     else if(Value_Type=="datetime")
      {
        obj.value+="\r\n方法2：<"+"%=((DateTime)dr[\""+Field+"\"]).ToString(\"yyyy-MM-dd\")%>";
        obj.value+="\r\n\r\n说明：方法2对日期格式进行定义;如：2007-08-04";
      }
    }


  switch(Field_Type)
    {
      case "file":
          obj.value+="\r\n\r\n方法2：如需要隐藏下载文件路径，可通过：/e/aspx/attachment.aspx?table=<%=Request.QueryString["table"]%>&field="+Field+"&id=<"+"%=dr[\"id\"].ToString()%> 这种方式来获取下载附件路径";
      break;

      case "images":
         obj.value="方法1：<"+"%=Get_File(\"<%=Request.QueryString["table"]%>\",\""+Field+"\",Id)%>\r\n方法2：<"+"%=dr[\""+Field+"\"]%> 可用来获取图片总数";
         obj.value+="\r\n\r\n方法1说明：获取一个类型为:DataTable的附件表集合(调用时Id需要修改为图片组所附属的信息id，数值型变量)，包含字段为:title(图片标题),url(图片附件),thumbnail(缩略图路径),introduction(简介)";
      break;

      case "files":

         obj.value="方法1：<"+"%=Get_File(\"<%=Request.QueryString["table"]%>\",\""+Field+"\",Id)%>\r\n方法2：<"+"%=dr[\""+Field+"\"]%> 可用来获取附件总数";
         obj.value+="\r\n\r\n方法1说明：1、获取一个类型为:DataTable的附件表集合(调用时Id需要修改为附件所附属的信息id，数值型变量)，包含字段为:title(标题名称),url(附件路径),point(下载积分),filesize(文件大小),downloads(下载次数),introduction(简介),permissions(下载权限,值为会员类型的id数组,为0时表示非会员可下载)";
         obj.value+="\r\n\r\n2、如需要隐藏附件实际路径或需要积分，可通过<a href=\"/e/aspx/attachment.aspx?id=ID\" target=\"_blank\">附件名</a>这种方式来下载附件;   注：这里ID为附件表的id值";
    break;

    }

 }

var C_Tab="<%=Request.QueryString["tab"]%>";
if(C_Tab!="")
 {
   showtab(C_Tab,0);
 }   

function show_textarea(num)
 {
  var A=document.getElementById("a");
  var B=document.getElementById("b");
  var obj1=document.getElementById("Field_Use");
  var obj2=document.getElementById("Use_Beizhu");
  var obj3=document.getElementById("ajax_user");

 switch(num)
   {
    case 1:
     A.style.fontWeight="normal";
     if(B!=null){B.style.fontWeight="normal";}
     obj1.style.display="";
     obj2.style.display="none";
     obj3.style.display="none";
     break;

    case 2:
     A.style.fontWeight="bold";
     if(B!=null){B.style.fontWeight="normal";}
     obj1.style.display="none";
     obj2.style.display="";
     obj3.style.display="none";
     break;

    case 3:
     A.style.fontWeight="normal";
     B.style.fontWeight="bold";
     obj1.style.display="none";
     obj2.style.display="none";
     obj3.style.display="";
     break;
   }
 }

function show_var(Type)
 {
   var height=400;
   if(Type=="ajax" || Type=="custom")
    {
     height=300;
    }
   IDialog('模型预设变量',"model_var.aspx?type="+Type,800,height,false,"modelvar");
 }
document.getElementById("Bt_Submit").onclick=startpost;
</script>
</html>