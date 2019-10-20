<% @ Page Language="C#" Inherits="PageAdmin.template_edit"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" />
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>模板编辑</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=10 cellspacing=0 width=95% >
 <tr>
<td valign=top>
<iframe name="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form runat="server" target="post_iframe">
<table border=0 cellpadding=5 cellspacing=0  width=100% align=center  class=table_style2>
<tr>
  <td valign=top  align="left">
<table border=0 cellpadding=0 cellspacing=2 width=100% align=center> 
      <tr>
          <td>
             <asp:TextBox id="Content" TextMode="MultiLine"  style="width:95%;height:400px" ScrollBars="Vertical" runat="server"  />
          </td>
      </tr> 
      <tr>
          <td height=25 colspan=2 align=center>
<span id="post_area">
<asp:Button Text=" 提 交 " id="Bt_Submit" runat="server" cssclass="button" onclick="PageAdmin_Data_Update" />
<input type="button" class=button  value="返回"  onclick="location.href='set_1.aspx'">
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>
</td>
      <tr>       
    </table>
 </td>
 <tr>
</table>
<br>
<div align="left">说明：修改前建议先备份一份。</div>
</form>

</td>
</tr>
</table>
</center>
<script type="text/javascript">
document.getElementById("Bt_Submit").onclick=startpost;;
</script>
</body>
</html>