<% @ Page Language="C#" Inherits="PageAdmin.tenpay_set"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="basic_onlinepay" /> 
<style type="text/css">
.current
</style>
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>在线支付接口设置</b></td></tr>
 <tr><td height=10 ></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<form runat="server" >
<div id="tabdiv">
<ul>
<li id="tab" name="tab"  onclick="location.href='alipay_set.aspx'">支付宝</li>
<li id="tab" name="tab" style="font-weight:bold">财付通</li>
<li id="tab" name="tab" onclick="location.href='chinabank_set.aspx'">网银在线</li>
</ul>
</div>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
   <table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
    <tr>
    <td height=25  width="100px">是否启用</td>
    <td height=25 ><asp:Label id="onlinepay_type" Text="tenpay" runat="server" visible="false"/><asp:CheckBox id="onlinepay_open" runat="server" /></td>
   </tr>
    <tr>
    <td height=25  width="100px">接口名称</td>
    <td height=25 ><asp:TextBox id="onlinepay_name" runat="server" size="20"/>
    <asp:RequiredFieldValidator  ControlToValidate="onlinepay_name" display="Static" type="integer"  runat="server">请输入接口名称</asp:RequiredFieldValidator>
   </td>
   </tr>

  <tr>
    <td height=25  width="100px">商户号</td>
    <td height=25 ><asp:TextBox id="onlinepay_mid" runat="server"  size="20" />
     <asp:RequiredFieldValidator  ControlToValidate="onlinepay_mid" display="Static" type="integer"  runat="server">请输入商户编号</asp:RequiredFieldValidator>
   </td>
   </tr>
  <tr>
    <td height=25  width="100px">支付密钥</td>
    <td height=25 ><asp:TextBox  id="onlinepay_key" runat="server"  size="40" />
     <asp:RequiredFieldValidator  ControlToValidate="onlinepay_key" display="Static" type="integer"  runat="server">请输入支付密钥</asp:RequiredFieldValidator>
   </td>
   </tr>

  <tr>
    <td height=25  width="100px">域名</td>
    <td height=25 ><asp:TextBox  id="onlinepay_url" runat="server"  size="40" />
     <asp:RequiredFieldValidator  ControlToValidate="onlinepay_url" display="Static" type="integer"  runat="server">请输入财付通账户设置的域名</asp:RequiredFieldValidator>
   </td>
   </tr>

  <tr>
    <td height=25 colspan="2" align=center><asp:Button   runat="server"  Class="button" Text="修改" onclick="Data_Update" /></td>
   </tr>
  <tr>
    <td height=25 colspan="2" align="left">注：商户号和密钥可向财付通公司申请。<br>域名不需要填写http://，格式如：www.pageadmin.net </td>
   </tr>
   </table>

  </td>
  <tr>
 </table>

</form>
</td>
</tr>
</table>
</center>
</body>
</html>  



