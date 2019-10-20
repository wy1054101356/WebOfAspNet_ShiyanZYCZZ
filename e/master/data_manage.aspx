<% @ Page Language="C#" Inherits="PageAdmin.data_manage"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="basic_datamanage" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<form runat="server">
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td align="left"  height=10></td></tr>
 <tr><td align="left"  class=table_style1><b>数据库管理</b></td></tr>
 <tr><td align="left"  height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95%>
 <tr>
<td align="left"  valign=top>
<div id="tabdiv">
<ul>
<li id="tab" name="tab" onclick="showtab(0)" style="font-weight:bold">数据备份</li>
<li id="tab" name="tab" onclick="showtab(1)">运行sql</li>
</ul>
</div>
<div name="tabcontent" id="tabcontent">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
<br>
<table border=0 cellpadding=0 cellspacing=0 width=95% align=center>
<tr>
 <td align="left" height="25px" width="100px">正在使用的数据库</td>
<td><asp:TextBox id="Tb_dbPath"  maxlength="50" size="40" Enabled="false" runat="server"/></td>
</tr>
<tr>
  <td align="left"   height="25px" width="100px">数据库类型</td>
  <td><asp:TextBox id="Tb_dbtype"  maxlength="50"  size="40" Enabled="false" runat="server"/></td>
</tr>
<tr>
 <td align="left" height="25px" width="100px">备份保存路径</td>
<td><asp:TextBox id="Backup_Path" Text="/e/backup/" maxlength="50" size="40" Enabled="false" runat="server"/></td>
</tr>
<tr>
<td colspan="2" height=40 align=left>
<asp:Button class="bt" text="备份数据"  Id="Bt_Submit" onclick="Data_Backup" runat="server" />
<asp:Button class="bt" text="清理sql日志"  Id="Bt_Clear" onclick="Clear_Log" runat="server" />
</td>
</tr>

<tr>
  <td  colspan=2 height=25><b>备份文件</b></td>
</tr>
<tr>
  <td colspan=2>
<table border=0 cellpadding=0 cellspacing=0 width=100% align=center class=tablestyle id="tb_list">
 <tr>
  <td height="20px" class=white width=15% align=center>文件类型</td>
  <td height="20px" class=white width=35% align=center>备份保存路径</td>
  <td class=white align=center width=15%>文件大小</td>
  <td class=white align=center width=20%>备份时间</td>
  <td class=white align=center width=15%>操作</td>
 </tr>
<asp:Repeater id="P1" runat="server" OnItemDataBound="Data_Bound">
<ItemTemplate>
   <tr class="listitem">
    <td align=center  class=tdstyle><%#Get_BackType(DataBinder.Eval(Container.DataItem,"db_type").ToString())%></td>
    <td align=center  class=tdstyle><%#DataBinder.Eval(Container.DataItem,"db_path")%></td>
    <td align=center  class=tdstyle><%#DataBinder.Eval(Container.DataItem,"db_size")%></td>
    <td align=center  class=tdstyle><%#DataBinder.Eval(Container.DataItem,"thedate")%></td>
    <td align=center  class=tdstyle><asp:LinkButton id="Cancel" Text="删除" runat="server" CommandName='<%#DataBinder.Eval(Container.DataItem,"db_path")%>'  OnCommand="Data_Cancel" /></td>
  </tr>
</ItemTemplate>
</asp:Repeater>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
<br><asp:Label id="lbl_error"  runat="server"/>
</div>
<div name="tabcontent" id="tabcontent" style="display:none">
<table border=0 cellpadding=10 cellspacing=0 width=100% align=center >
 <tr>
<td align="left"  valign=top class=table_style2>
<table border=0 cellpadding=0 cellspacing=5 width=95% align=center>
<tr>
  <td width=100px><b>变量1值</b></td>
  <td><asp:TextBox id="Tb_var_1" Textmode="multiline" columns="75" rows="3"  runat="server"/></td>
 </tr>
<tr>
  <td width=100px><b>变量2值</b></td>
  <td><asp:TextBox id="Tb_var_2" Textmode="multiline" columns="75" rows="3"  runat="server"/></td>
 </tr>
<tr>
  <td width=100px><b>变量3值</b></td>
  <td><asp:TextBox id="Tb_var_3" Textmode="multiline" columns="75" rows="3"  runat="server"/></td>
 </tr>
<tr>
  <td><b>运行sql语句</b></td>
  <td align="left" title=""><asp:TextBox id="Tb_sql" Textmode="multiline" columns="75" rows="10"  runat="server"/>
</td>
 </tr>
<tr>
  <td align="center" colspan="2"><asp:Button id="B_Submit" class=button   text="运行"  onclick="Run_Sql" runat="server" />
</td>
 </tr>
</table>
注:为保证数据安全，运行前建议先备份数据库。
<br>多条sql语句之间用分号隔开，sql语句中可以插入{VAR1}，{VAR2}，{VAR3}来表示变量1、变量2、变量3，运行后会自动替换为对应内容。
</td>
</tr>
</table>
<br><asp:Label id="lbl_error_1"  runat="server" />
</div>
<br>
</td>
</tr>
</table>
</form>
</center>
</body>
<script language="javascript">
MouseoverColor("tb_list");
if(GetCookie("tab")!="")
 {
  showtab(GetCookie("tab"));
 }   
</script>
</html>  



