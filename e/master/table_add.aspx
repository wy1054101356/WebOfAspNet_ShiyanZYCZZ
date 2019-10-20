<% @ Page Language="C#" Inherits="PageAdmin.table_add"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="zdytable_list" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload()" title="点击刷新"><b>数据表管理</b></a></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<form runat="server" >
<div id="tabdiv">
<ul>
<li id="tab" name="tab" onclick="location.href='table_list.aspx'">数据表管理</li>
<li id="tab" name="tab" style="font-weight:bold"><asp:Label id="Lb1" runat="server" text="增加新表"/></li>
</ul>
</div>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>

<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr>
  <td height=25><b>当前位置</b>：表增加/修改</td>
 </tr>
</table>
<table border=0 cellpadding=5 cellspacing=0 width=95% align=center>
<tr>
  <td style="width:130px">数据表名</td>
  <td><asp:TextBox id="Add_Table" maxlength=20 size=20  runat="server" title="表中存在大量数据时建议不要随意修改表"/><asp:TextBox  id="Old_Table" maxlength=50 size=30  runat="server" Visible="false"/> <%if(Request.QueryString["act"]=="edit"){%> 更换数据表名时务必先备份数据库<%}else{%>*(如:article,只能由字母、数字组成，首字符必须是英文字母)<%}%></td>
</tr>
<tr>
  <td>表名称(中文标识)</td><td><asp:TextBox  id="Add_Name" maxlength=50 size=30  runat="server" /> *(如:文章，仅用于识别)</td>
</tr>

<tr>
  <td>表用途</td><td>
<asp:DropDownList id="Add_Type" runat="server">
<asp:Listitem value="article">通用型</asp:Listitem>
<asp:Listitem value="product">产品型(支持订购功能)</asp:Listitem>
<asp:Listitem value="feedback">互动型(支持回复功能)</asp:Listitem>
</asp:DropDownList></td>
</tr>

<tr>
  <td>应用站点<br><a style="color:#666666" href="javascript:CheckBox_Inverse('SiteIds')">[反选]</a></td><td title="不选择则默认所有站点可使用">
        <asp:Repeater id="P_Site" runat="server">
         <ItemTemplate>
           <input type="checkbox" name="SiteIds" id="site_<%#DataBinder.Eval(Container.DataItem,"id")%>" value="<%#DataBinder.Eval(Container.DataItem,"id")%>" ><%#DataBinder.Eval(Container.DataItem,"sitename")%>&nbsp;
         </ItemTemplate>
        </asp:Repeater>
</td>
</tr>

<tr>
  <td>信息保存目录</td><td><asp:TextBox id="Add_Static_Dir" maxlength=50 size=30 runat="server" Text="{table}/{yyyy}" title="只有站点开启静态时此功能才有效" onblur="if(this.value==''){this.value='{table}/{yyyy}'}"/> 静态文件的目录格式，留空则默认{table}/{yyyy}，可选参数：{table}{yyyy}{mm}{dd}分别表示：表年月日</td>
</tr>

<tr>
  <td>数据默认排序</td><td><asp:TextBox id="Add_Default_Sort" maxlength=50 size=40 runat="server" Text="actdate desc" onblur="if(this.value==''){this.value='actdate desc'}"/> 默认按时间降序</td>
</tr>

<%if(Request.QueryString["act"]=="edit"){%>
<tr>
  <td>全站搜索导入字段</td><td><asp:TextBox id="Add_AllData_Fields" maxlength=150 size=40 runat="server" Text=""  title="必须严格按照：标题字段,简介字段,内容字段的顺序排列"/> <a href="javascript:GetAllDataFields()">[点此设置]</a></td>
</tr>
<%}%>

<tr>
  <td>后台管理</td><td><asp:DropDownList id="Add_DataManage" runat="server"><asp:Listitem value="1">开启</asp:Listitem><asp:Listitem value="0">关闭</asp:Listitem></asp:DropDownList></td>                              
</tr>

<tr>
  <td>栏目调用</td><td><asp:DropDownList id="Add_InLanmu" runat="server"><asp:Listitem value="1">开启</asp:Listitem><asp:Listitem value="0">关闭</asp:Listitem></asp:DropDownList> *(开启后可在栏目中调用)</td>
</tr>

<tr>
  <td>表单验证码</td><td><asp:DropDownList id="Add_TgYzm" runat="server"><asp:Listitem value="1">开启</asp:Listitem><asp:Listitem value="0">关闭</asp:Listitem></asp:DropDownList> </td>
</tr>

<tr>
  <td>删除会员同步删除信息</td><td><asp:DropDownList id="D_User_Delete_Same" runat="server"><asp:Listitem value="0">否</asp:Listitem><asp:Listitem value="1">是</asp:Listitem></asp:DropDownList></td>
</tr>

<tr>
  <td>序号</td><td><asp:TextBox id="Add_xuhao" maxlength="5" size="2" Text="1" runat="server"/></td>
</tr>

<tr>
  <td colspan=2 height=45 align=center>
<asp:Label id="Lb_Copytable" text="" runat="server" Visible="false"/>
<asp:button  CssClass="button" id="BT1" Text="增加" runat="server" OnClick="Data_Add" onclientclick="return ck()"/>
<asp:button  CssClass="button" id="BT2" Text="修改" runat="server" OnClick="Data_Update"  Visible="false" onclientclick="return ck()"/>
<asp:button  CssClass="button" id="BT3"  Text="确定" runat="server" OnClick="Data_Copy"  Visible="false"/>
<input type="button" class=button  value="返回"  onclick="location.href='table_list.aspx'">
</td>
 </tr>
</table>
</td>
</tr>
</table>
</form>
<br>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
var SiteIds="<%=SiteIds%>";
var ASiteIds=SiteIds.split(',');
if(ASiteIds=="" || ASiteIds=="0")
 {
  for(i=0;i<document.forms[0].SiteIds.length;i++)
     {
      
      try{
           document.forms[0].SiteIds[i].checked=true;
         }
       catch(ex)
         {
         }
    }
 }
else
 {
   for(i=0;i<ASiteIds.length;i++)
    {
      try{
         document.getElementById("site_"+ASiteIds[i]).checked=true;
         }
       catch(ex)
         {
         }
    }
 }
var xuhao="<%=Request.QueryString["xuhao"]%>";
if(xuhao!="")
{
document.getElementById("Add_xuhao").value=xuhao;
}

var Add_Static_Dir=document.getElementById("Add_Static_Dir");
var Add_Default_Sort=document.getElementById("Add_Default_Sort");

if(Add_Static_Dir.value==""){Add_Static_Dir.value="{table}/{yyyy}{mm}{dd}";}
if(Add_Default_Sort.value==""){Add_Default_Sort.value="actdate desc";}

var ErrInfo="<%=ErrInfo%>";
if(ErrInfo!="")
{
 alert(ErrInfo);
}

function ck()
 {
   var keys=new Array("index","order","by","select","top","asc","desc","count","sum","link","update","insert","to","values","where");
   var Add_Table=document.getElementById("Add_Table");
   var Add_Name=document.getElementById("Add_Name");
   if(Trim(Add_Table.value)=="")
     {
      alert("请填写数据表名!");
      Add_Table.focus();
      return false;
     }
   Add_Table.value=Trim(Add_Table.value);
   if(!IsStr(Add_Table.value))
     {
      alert("数据表名不能带特殊符号!");
      Add_Table.focus();
      return false;
     }
   if(IsDigit(Add_Table.value.substr(0,1)))
     {
      alert("数据表名第一个字母必须是英文字符!");
      Add_Table.focus();
      return false;
     }
   if(Add_Table.value.length<2)
     {
      alert("数据表名至少2个字符!");
      Add_Table.focus();
      return false;
     }
   if(IsContains(Add_Table.value,keys))
     {
      alert("请更换一个数据表名，"+Add_Table.value+"为sql保留关键词!");
      Add_Table.focus();
      return false;
     }
   if(Trim(Add_Name.value)=="")
     {
      alert("请填写表名称-中文标识!");
      Add_Name.focus();
      return false;
     }

   return true;
 }
function GetAllDataFields()
 {
   IDialog("设置全站搜索导入字段","alldata_setfields.aspx?table=<%=EditTable%>",450,200);
 }
</script>
</body>
</html>  
