<%@ Page Language="C#"  Inherits="chinabank_pay" src="Default.ascx.cs"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>网银在线支付接口</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
body{word-break:break-all;font-size:13px;line-height:14px;margin:0 0 0 0;text-align:left;}
</style>
</head>
<body>
<div style="padding:15px">
<img src=/e/images/public/loading.gif border=0 align=absmiddle hspace=5>处理中...
<table cellSpacing=0 cellPadding=4 border=0 align="left" style="display:none">
<form method="post" name=formbill action="/e/member/onlinepay/chinabank/Send.aspx">
    <tr>
      <td height=20 align="left"><input name="remark2" type="hidden" id="remark2" value="在线支付" >
<input name="v_oid" type="hidden" maxlength="64" value="">
<input name="v_rcvname" type="hidden" value="<%=TrueName%>">
<input name="v_rcvaddr" type="hidden" id="v_rcvaddr"  value="">
<input name="v_rcvtel" type="hidden" id="v_rcvtel"  value="0760-22517081">
<input name="v_rcvpost" type="hidden" id="v_rcvpost"  value="528427">
<input type="hidden" name="v_rcvemail" value="<%=Email%>">
<input type="hidden" name="v_rcvmobile" value="">
<input name="remark1" type="hidden" id="remark1" value="<%=UserName%>,<%=SiteId%>,<%=Server.UrlEncode(R_Url)%>">
<input name="v_ordername" type="hidden" id="v_ordername" value="<%=TrueName%>">
<input name="v_orderaddr" type="hidden" id="v_orderaddr"  value="">
<input name="v_ordertel" type="hidden" id="v_ordertel"  value="0760-22517081">
<input name="v_orderpost" type="hidden" id="v_orderpost"  value="528427">
<input name="v_orderemail" type="hidden" id="v_orderemail" value="<%=Email%>">
<input name="v_ordermobile" type="hidden" id="v_ordermobile" value="">
<input name="siteid" type="hidden" id="siteid" value="<%=SiteId%>">
入款金额：<input name="v_amount" id="v_amount" type=text value="<%=Request.QueryString["amount"]%>" maxlength="6" size="5" onkeyup="if(isNaN(value))execCommand('undo')">&nbsp;元
<input type="submit" name="Submit" value=" 确 定 " class="button" id="BtnChinabank">
   </TD>
   </TR>
</form>
</table>
</div>

<script type="text/javascript">
function C_Tb()
 {
   var M=document.getElementById("v_amount").value;
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
   document.getElementById("BtnChinabank").click();
 }
window.onload=C_Tb;
</script>
</BODY></HTML>
