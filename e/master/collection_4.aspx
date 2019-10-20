<% @ Page Language="C#" Inherits="PageAdmin.collection_4"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="bs_collection" />
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>采集配置</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top>

<form runat="server">
<table border=0 cellpadding=5 cellspacing=0  width=100% align=center  class=table_style2>
<tr>
  <td valign=top  align="left">
  <table border=0 cellpadding=5  width=95% align=center>
    <tr>
     <td  align="left"><b>当前采集：</b><%=Request.QueryString["name"]%></td>
    </tr>
    <tr>
     <td  align="left" height="5"></td>
    </tr>
  </table>
<table border=0 cellpadding=2 cellspacing=0 width=95% align=center> 
      <tr>
          <td>
             <asp:TextBox id="Content" TextMode="MultiLine"  columns="100" rows="40" ScrollBars="Vertical" runat="server"  />
          </td>
      </tr> 
      <tr>
          <td   height=25 colspan=2 align=center>
<asp:Button Text="生成配置文件" runat="server" cssclass="bt" onclick="Data_Update" />
<input type="button" class=bt  value="返回"  onclick="location.href='collection_1.aspx'">

</td>
      <tr>       
    </table>
 </td>
 <tr>
</table>
<br>
<div align="left">注：第一次使用、修改采集字段、删除采集字段都需要重新生成配置文件(其他情况不需要重新生成)</div>
</form>

</td>
</tr>
</table>
</center>
</body>
</html>  

