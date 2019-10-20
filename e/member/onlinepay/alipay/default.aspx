<%@ Page Language="C#" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="_Default" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>支付宝即时到账接口</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
body{word-break:break-all;font-size:9pt;line-height:14px;margin:0 0 0 0;text-align:center;font-size:13px}
</style>
</head>
<body>
<div style="padding:20px;text-align:left">
<img src=/e/images/public/loading.gif border=0 align=absmiddle hspace=5>处理中...
<TABLE cellSpacing=0 cellPadding=4 border=0 width="100%" style="display:none">
<form id="form1" runat="server">
  <tr><td align="left">
<asp:TextBox ID="TxtSubject"  runat="server" Visible="false" text="支付宝即时充值" />
<asp:TextBox ID="TxtBody" runat="server" TextMode="MultiLine" Visible="false" text="" />
入款金额：<asp:TextBox ID="TxtTotal_fee" runat="server"  MaxLength="10" cssclass="tb" onkeyup="if(isNaN(value))execCommand('undo')" />&nbsp;元
<asp:Button ID="BtnAlipay" runat="server" CssClass="button" Text=" 确 定 " OnClick="BtnAlipay_Click"/>
</tr>
<td>
</form>
</table>
</div>
<script type="text/javascript">
function C_Tb()
 {
   var M=document.getElementById("TxtTotal_fee").value;
   if(M=='')
    {
     alert('充值金额无效!');
     return;
    }
   else if(isNaN(M))
    {
     alert('充值金额不是有效的数字!');
     return;
    }
   else if(M<0.01)
    {
     alert('充值金额不能小于0.01!');
     return;
    }
    document.getElementById("BtnAlipay").click();
 }
window.onload=C_Tb;
</script>
</body>
</html>
