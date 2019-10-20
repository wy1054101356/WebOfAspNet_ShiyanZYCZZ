<% @ Page Language="C#" Inherits="PageAdmin.site_add"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server"  Type="site_add" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95%>
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload()" title="点击刷新"><b><%=PostType=="edit"?"站点修改":"新增站点"%></b></a></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<form runat="server" >
<div id="tabdiv" style="display:<%=PostType=="edit"?"none":""%>">
<ul>
<li id="tab" name="tab" onclick="location.href='site_list.aspx'">站点管理</li>
<li id="tab" name="tab" style="font-weight:bold"><asp:Label id="Lb1" runat="server" text="增加站点"/></li>
</ul>
</div>
<table border=0 cellpadding=10 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
<table border=0 cellpadding=5 cellspacing=0 width=95% align=center>
<tr>
  <td width=100px>站点名称</td><td><asp:TextBox id="Add_Site" maxlength=50 size=30  runat="server" /> *</td>
</tr>

<tr>
  <td>站点目录</td><td>
<asp:TextBox  id="Add_Directory" maxlength=30 size=30  runat="server" /> *留空则默认根目录
<asp:Label id="Lb_Directory" runat="server" Visible="false"/>
</td>
</tr>

<tr>
  <td>站点语种</td><td><asp:DropDownlist id="Add_Language" runat="server"/></td>
</tr>

<tr>
  <td>生成静态</td><td><asp:DropDownlist id="Add_Html" runat="server">
<asp:ListItem value="0">否</asp:ListItem>
<asp:ListItem value="1">是</asp:ListItem>
</asp:DropDownlist></td>
</tr>

<tr>
  <td>绑定子域名</td><td><asp:TextBox  id="Add_Domain"  maxlength=50 size=30  runat="server" /></asp:DropDownList> *(需要独立iis站点绑定，否则请留空)</td>
</tr>

<tr>
  <td>数据共享</td><td><select name="share_sites" id="share_sites" size="3" multiple title="按住Ctrl可多选或取消选中状态"><%=SiteList%></select> *选择后则可以在模块，导航和子栏目中调用选中站点的数据。</td>
</tr>

<tr>
  <td>序号</td><td><asp:TextBox id="Add_xuhao" maxlength="5" size="2" Text="1" runat="server"/></td>
</tr>

<tr>
  <td  colspan=2 height=45 align=center>
<asp:button  CssClass="button" id="BT1" Text="增加" runat="server" OnClick="Data_Add" />
<asp:button  CssClass="button" id="BT2" Text="修改" runat="server" OnClick="Data_Update"  Visible="false"/>
<input type="button" class=button  value="返回"  onclick="location.href='site_list.aspx'" style="display:<%=PostType=="edit"?"none":""%>">
<input type="button" class=button  value="关闭"  onclick="parent.CloseDialog()" style="display:<%=PostType=="edit"?"":"none"%>">
</td>
 </tr>
</table>
</td>
</tr>
</table>
<br><asp:Label id="LblErr" runat="server" />
</form>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
Set_Selected("<%=ShareSites%>","share_sites") //根据值设置select表单
</script>
</body>
</html>