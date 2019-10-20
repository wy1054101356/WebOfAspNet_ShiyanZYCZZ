<%@ Reference Page="return_url.aspx" %>
<%@ Page language="c#" Inherits="tenpay.index" CodeFile="index.aspx.cs" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>财付通即时到账接口</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
body{word-break:break-all;font-size:13px;line-height:14px;margin:0 0 0 0;text-align:center;}
</style>
</head>
<body>
<div style="padding:20px;text-align:left">
<img src=/e/images/public/loading.gif border=0 align=absmiddle hspace=5>处理中...
<TABLE cellSpacing=0 cellPadding=4 border=0 width="100%" style="display:none">
<form method="post" action="" name="form1">
  <tr><td align="left">
入款金额：<input type="text" name="pay_fee" id="pay_fee" value="<%=Request.QueryString["amount"]%>" MaxLength="10" class="tb" onkeyup="if(isNaN(value))execCommand('undo')">元
<input type="submit" value="确定" class="button" id="BtnTenpay">
</tr>
  <td>
</form>
</table>
</div>
<script type="text/javascript">
function C_Tb()
 {
   var M=document.getElementById("pay_fee").value;
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
   document.getElementById("BtnTenpay").click();
 }
window.onload=C_Tb;
</script>
</body>
</html>
