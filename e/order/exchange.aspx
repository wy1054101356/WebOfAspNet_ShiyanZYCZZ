<% @ Page language="c#" Inherits="PageAdmin.exchange" src="~/e/order/exchange.cs"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>积分兑换</title>
<meta name="Author" content="PageAdmin CMS" />
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<script src="/e/js/function.js" type="text/javascript"></script>
<script src="/e/js/order.js" type="text/javascript"></script>
<link href="order.css" type="text/css" rel="stylesheet" />
</head>
<body oncontextmenu="window.event.returnValue=false" class="exchangebody">
<div class="exchange"><asp:PlaceHolder id="p1" runat="server">
<form method="post" runat="server">
<table border="0" cellpadding="0" cellspacing="0" width="100%" align=center>
 <tr>
   <td align="left" style="height:30px;font-size:14px"><strong>您选择了兑换<span style="color:#FF6600"><%=TheTitle%></span>，请确认以下信息：</strong></td>
 </tr>
 <tr>
   <td align="left">
<ul class="infor">
<li>商品名称：<%=TheTitle%></li>
<li>商品库存：<%=Reserves%></li>
<li>兑换数量：<input type="text" name="num" id="num" maxlength="5" value="1" style="width:55px;height:20px;border:1px solid #cccccc;" onkeyup="c_num(this.value)"></li>
<li>所需积分：<span id="points"><%=Point%></span>积分 (我的积分余额：<%=MyPoint%>)</li>
<li>联系姓名：<input type="text" name="truename" id="truename" maxlength="30"  style="width:200px;height:20px;border:1px solid #cccccc;"></li>
<li>联系电话：<input type="text" name="tel" id="tel" maxlength="30"  style="width:200px;height:20px;border:1px solid #cccccc;"></li>
<li>电子邮箱：<input type="text" name="email" id="email" maxlength="30"  style="width:200px;height:20px;border:1px solid #cccccc;"></li>
<li>收货地址：<input type="text" name="address"  id="address" maxlength="100"  style="width:350px;height:20px;border:1px solid #cccccc;"></li>
<li>邮政编码：<input type="text" name="postcode" id="postcode" maxlength="6" onkeyup="if(isNaN(value))execCommand('undo');"  style="width:200px;height:20px;border:1px solid #cccccc;"></li>
</ul>
  </td>

 </tr>
   <td align="center" style="padding-top:5px">
  <input type="hidden" id="act" name="act" value=""/>
  <input type="button" id="bt" value=" 确定兑换 " onclick="Check_Inptut()" class="bt"/>&nbsp;&nbsp;
  <input type="button" value=" 关闭窗口 " class="bt" onclick="wclose()">
</td>
 </tr>
 <tr>
   <td align="left" style="padding-top:15px;">提示：请详细填写姓名、收货地址、电话、邮政编码等资料，不然可能导致物品送货失败。</td>
 </tr>
</table>
<asp:Label id="Lb_Point" runat="server" Visible="false" />
<asp:Label id="Lb_MyPoint" runat="server" Visible="false" />
<asp:Label id="Lb_Reserves" runat="server" Visible="false" />
<asp:Label id="Lb_UserName" runat="server" Visible="false" />
<asp:Label id="Lb_Title" runat="server" Visible="false" />
</form>
</asp:PlaceHolder>
<asp:PlaceHolder id="p2" runat="server" visible="false">
<br><br>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
 <tr>
   <td align="center">
<img src="/e/images/public/suc.gif" border=0><br><br>
您好，兑换成功，如需修改联系资料，可进入会员中心”我的兑换“处进行修改！
<br><input type="button" class="bt" onclick="wclose()" value="关闭窗口">
</td>
 </tr>
</table>
</asp:PlaceHolder>
</div>
<script type="text/javascript">
 <%=ServerInfo%>
 var bt=document.getElementById("bt")
 function c_num(value)
  {
    bt.disabled=false;
    var points=document.getElementById("points");
    if(isNaN(value) || Trim(value)=="" || Trim(value)=="0")
     {
      document.getElementById("num").value="1";
     }
   else
     {
       points.innerHTML=parseInt(value)*<%=Point%>;
     }
  }

var SinglePoint=<%=Point%>;
function Check_Inptut() //检查联系信息
  {  
    if(SinglePoint==0)
     {
       alert("对不起，此产品还未设置兑换积分!");
       return;
     }
    var num=document.getElementById("num").value;
    if(isNaN(num))
     {
      num=1;
      document.getElementById("num").value="1";
     }
    if(<%=Reserves%><parseInt(num))
      {
        alert("您好，兑换数量不能大于商品库存!");
        document.getElementById("num").focus();
        return;
      }

    if(<%=MyPoint%><parseInt(num)*<%=Point%>)
      {
         alert("您好，您的可用积分不足!");
         document.getElementById("num").focus();
         return;
      }

   var fb_value=Trim(document.getElementById("truename").value);
   if(fb_value.length<2)
    {
      alert("请输入您的姓名!");
      document.getElementById("truename").focus();
      return;
    }

   fb_value=Trim(document.getElementById("tel").value);
   if(fb_value.length<6)
    {
      alert("请输入您的电话!");
      document.getElementById("tel").focus();
      return;
    }

  fb_value=Trim(document.getElementById("email").value);
   if(fb_value=="")
    {
     alert("请输入您的电子邮箱地址!");
     document.getElementById("email").focus();
     return;
    }
   else if (fb_value.charAt(0)=="." || fb_value.charAt(0)=="@" || fb_value.indexOf('@', 0) == -1 || fb_value.indexOf('.', 0) == -1 || fb_value.lastIndexOf("@")==fb_value.length-1 || fb_value.lastIndexOf(".")==fb_value.length-1)
     {
        alert("邮箱地址格式错误，请重新输入!");
        document.getElementById("email").focus();
        return;
     }

   fb_value=Trim(document.getElementById("address").value);
   if(fb_value.length<8)
    {
      alert("请输入您的详细地址!");
      document.getElementById("address").focus();
      return;
    }

   fb_value=Trim(document.getElementById("postcode").value);
   if(!IsNum(fb_value))
   {
    alert("邮编号码填写错误!");
    document.getElementById("postcode").focus();
    return;
   }

  if(fb_value.length!=6)
  {
   alert("邮编只能由6位数字组成!");
   document.getElementById("postcode").focus();
   return;
  }

  if(confirm("是否确定兑换?"))
   {
    document.getElementById("act").value="save";
    document.forms[0].submit();
   }
  }
function wclose()
 {
   parent.CloseDialog();
 }
</script>
</body>
</html>

