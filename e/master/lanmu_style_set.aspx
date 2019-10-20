<% @ Page Language="C#" Inherits="PageAdmin.lanmu_style_set"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<table  border=0 cellpadding=0 cellspacing=0 width=95% align="center">
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b><%=TypeName%>样式<%=Request.QueryString["act"]=="add"?"复制":"设置"%></b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% align="center">
 <tr>
<td valign=top>
<iframe name="post_iframe" id="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form runat="server" target="post_iframe">
<table border=0 cellpadding=5 cellspacing=0 width="100%" align=center  class=table_style2>
<tr>
  <td valign=top>
<table border=0 cellpadding="7" cellspacing="0" width="95%" align=center>
<tr>
  <td  height=25 width="100px">样式标识</td>
  <td align="left"><asp:TextBox id="Name" runat="server" size="40" maxlength=40/>
</tr>
<tr>
  <td  height=25 width="100px">Css样式名</td>
  <td align="left"><asp:TextBox id="ClassName" runat="server" size="40" maxlength=40/> 如：ClassName，多个样式用半角逗号隔开，表示引用相关css文件中的样式。
</tr>
</table>
<table border=0 cellpadding="2" cellspacing="5" width="95%" align=center style="display:<%=Thetype=="nav"?"":"none"%>">

<tr>
  <td  height=25 width="100px">容器样式</td>
  <td align="left"><asp:TextBox id="Nav_box_style" runat="server" TextMode="MultiLine" Columns="70" Rows="4" />
</tr>

<tr>
  <td  height=25 width="100px">标题容器样式</td>
  <td align="left"><asp:TextBox id="Nav_titlebox_style" runat="server" TextMode="MultiLine" Columns="70" Rows="4" />

</tr>

<tr>
  <td  height=25 width="100px">标题样式</td>
  <td align="left"><asp:TextBox id="Nav_title_style" runat="server" TextMode="MultiLine" Columns="70" Rows="4" />
</tr>

<tr>
  <td  height=25 width="100px">more样式</td>
  <td align="left"><asp:TextBox id="Nav_more_style" runat="server" TextMode="MultiLine" Columns="70" Rows="4" />
</tr>

<tr>
  <td  height=25 width="100px">内容区样式</td>
  <td align="left"><asp:TextBox id="Nav_content_style" runat="server" TextMode="MultiLine" Columns="70" Rows="4" />
</tr>

<table border=0 cellpadding="2" cellspacing="5" width="95%" align=center style="display:<%=Thetype=="module"?"":"none"%>">
<tr>
  <td  height=25 width="100px">外层容器样式</td>
  <td align="left"><asp:TextBox id="T_box_style" runat="server" TextMode="MultiLine" Columns="70" Rows="4" />
</tr>

<tr>
  <td  height=25 width="100px">内层容器样式</td>
  <td align="left"><asp:TextBox id="T_box_1_style" runat="server" TextMode="MultiLine" Columns="70" Rows="4" />
</tr>

<tr>
  <td  height=25 width="100px">标题容器样式</td>
  <td align="left"><asp:TextBox id="T_titlebox_style" runat="server" TextMode="MultiLine" Columns="70" Rows="4" />
</tr>

<tr>
  <td  height=25 width="100px">标题样式</td>
  <td align="left"><asp:TextBox id="T_title_style" runat="server" TextMode="MultiLine" Columns="70" Rows="4" />
</tr>

<tr>
  <td  height=25 width="100px">more样式</td>
  <td align="left"><asp:TextBox id="T_more_style" runat="server" TextMode="MultiLine" Columns="70" Rows="4" />
</tr>

<tr>
  <td  height=25 width="100px">内容区样式</td>
  <td align="left"><asp:TextBox id="T_content_style" runat="server" TextMode="MultiLine" Columns="70" Rows="4" />
</tr>
</table>
<table border=0 cellpadding="2" cellspacing="5" width="95%" align=center>
<tr>
  <td  height=25 width="100px">序号</td>
  <td align="left"><asp:TextBox id="Xuhao" runat="server" size="5" maxlength=20/>
</tr>
</table>
<br>
注：以上自定义样式区采用标准的CSS语法，最大字符数为200，如需要代码和样式分离，建议只填写Css样式名即可(即加载css文件中的样式)。
</td>
</tr>
</table>

<table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
<tr>
<td height=25 align=center >
<span id="post_area">
<asp:Button  Cssclass=button  text="提交"  runat="server" onclick="Data_Update" Id="Bt_Submit"/>
<%if(Request.QueryString["act"]=="add"){%>
<input type="button" class=button  value="返回"  onclick="location.href='lanmu_style_list.aspx?type=<%=Request.QueryString["type"]%>'">
<%}else{%>
<input type="button" class=button  value="关闭"  onclick="closewin()">
<%}%>
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span> 
</td>
 </tr>
</table>
</form>
<br>
<script language="javascript"> 
document.getElementById("Bt_Submit").onclick=style_post;
var closewinrefresh=0;
function style_post()
 {
   closewinrefresh=1;
   startpost();
 }
function closewin()
 {
   if(closewinrefresh==1)
   {
    parent.location.reload();
    parent.CloseDialog();
   }
   else
   {
    parent.CloseDialog();
   }
 }
</script>
</body>
</html>