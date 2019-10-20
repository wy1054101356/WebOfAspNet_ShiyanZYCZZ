<% @ Page Language="C#" Inherits="PageAdmin.member_menu_set"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server"/>
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1 align="left"><b>会员菜单设置</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top  align="left">
<iframe name="post_iframe" id="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form runat="server" target="post_iframe">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top  align="left">
<table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
<tr>
  <td height=10></td>
 </tr>
</table>
<table border=0 cellpadding=5 cellspacing=0 width=95% align=center>
 <tr>
   <td height=25 align="left" width="100px">菜单名称</td>
    <td height=25px  align="left"><asp:TextBox id="Tb_Name" maxlength="50" size="30" runat="server"/></td>
 </tr>

 <tr>
   <td height=25 align="left" width="100px">菜单类型</td>
    <td height=25px  align="left">
    <asp:DropDownlist id="TheType" Runat="server" onchange="change_type()">
     <asp:ListItem value="0">自定义链接</asp:ListItem>
     <asp:ListItem value="1">自定义控件(生成ascx文件)</asp:ListItem>
    </asp:DropDownlist>
    </td>
 </tr>

<tr id="tr_url" style="display:none">
  <td height=25px  align="left">url地址</td>
  <td height=25px  align="left"><asp:TextBox id="Tb_Url" maxlength="80" size="60" runat="server" /></td>
</tr>

<tr id="tr_content" style="display:none">
  <td height=25px align="left">文件内容</td>
  <td height=25px align="left">
 <a href="javascript:show_var('member')" id="a_tagvar">&gt;&gt;预设变量及方法</a><br>
<asp:TextBox  id="Tb_Content" TextMode="MultiLine" runat="server" style="width:80%;height:300px"/>
</td>
</tr>


<tr>
 <td height=25px  align="left">应用会员类别</td>
  <td height=25px  align="left" >
<select id="Mtype_Ids"  name="Mtype_Ids"  size="5" multiple style="width:200px" title="按住Ctrl可多选或取消选中状态">
<%=MTypeList%>
</select>
</td>
</tr>

<tr>
  <td height=25px  align="left">应用部门</td>
  <td height=25px  align="left">
<select id="Department_Ids" name="Department_Ids" size="5" multiple style="width:200px" title="按住Ctrl可多选或取消选中状态">
<%=DepartmentList%>
</select>
 </td>
</tr>

<tr>
  <td height=25px  align="left">目标窗口</td>
  <td height=25px  align="left">
   <asp:DropDownlist id="Target" Runat="server">
     <asp:ListItem value="_self">本窗口</asp:ListItem>
     <asp:ListItem value="_blank">新窗口</asp:ListItem>
    </asp:DropDownlist></td>
</tr>

<tr>
  <td height=25px  align="left">是否显示</td>
  <td height=25px  align="left">
   <asp:DropDownlist id="DlShow" Runat="server">
     <asp:ListItem value="1">显示</asp:ListItem>
     <asp:ListItem value="0">隐藏</asp:ListItem>
    </asp:DropDownlist> <span style="color:#666">隐藏后将不在会员菜单中显示</span></td>
</tr>

<tr>
  <td>序号</td><td><asp:TextBox id="Tb_Xuhao" maxlength="5" size="2" Text="1" runat="server"/></td>
</tr>

</table>
</td>
</tr>
</table><br>
<div align=center>
<span id="post_area">
<asp:Button Text=" 提交 " Cssclass="button" runat="server" OnClick="Data_Update" id="Bt_Submit" />
<input type="button" class="button" onclick="location.href='member_menu.aspx'" value="返回">
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span> 
</div>
</form><br>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
 function change_type()
  {
   var thetype=document.getElementById("TheType").value;
   switch(thetype)
    {
      case "0":
       document.getElementById("tr_url").style.display="";
       document.getElementById("tr_content").style.display="none";
      break;

      case "1":
       document.getElementById("tr_url").style.display="none";
       document.getElementById("tr_content").style.display="";
      break;
    }
  }
change_type();
var Mtype_Ids=",<%=Mtype_Ids%>,";
var Department_Ids=",<%=Department_Ids%>,";
var obj_1=document.getElementById("Mtype_Ids");
var obj_2=document.getElementById("Department_Ids");
for(i=0;i<obj_1.options.length;i++)
   {
    if(Mtype_Ids.indexOf(","+obj_1.options[i].value+",")>=0)
     {
      obj_1.options[i].selected=true;
     }
   }
for(i=0;i<obj_2.options.length;i++)
   {
    if(Department_Ids.indexOf(","+obj_2.options[i].value+",")>=0)
     {
      obj_2.options[i].selected=true;
     }
   }
document.getElementById("Bt_Submit").onclick=startpost;
function show_var(Type)
 {
   IDialog('预设变量及方法',"tag_var.aspx?type="+Type,800,400,false,"tagvar");
 }
</script>
</body>
</html>