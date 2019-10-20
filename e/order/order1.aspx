<% @ Page language="c#"  Inherits="PageAdmin.order1" src="~/e/order/order1.cs"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>购物车</title>
<meta name="Author" content="PageAdmin CMS" />
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<script src="/e/js/dialog.js" type="text/javascript"></script>
<script src="/e/js/order.js" type="text/javascript"></script>
<script src="/e/js/function.js" type="text/javascript"></script>
<link href="order.css" type="text/css" rel="stylesheet" />
</head>
<body class="orderbody">
<center>
<form method="post" name="order">
<br>
  <table border=0 cellpadding=0 cellspacing=0 class="order">
      <tr class="header">
         <td width=40% align="center">产品/product</td>
         <td width=20% align="center">价格/price</td>
         <td width=20% align="center">数量/amount</td>
         <td width=20% align="center">total</td>
        </tr>
<asp:Repeater id="List" runat="server"> 
   <ItemTemplate>  
       <tr class="item">
         <td height=25 align=center>
         <img src="<%#Get_Field(DataBinder.Eval(Container.DataItem,"thetable").ToString(),"titlepic",DataBinder.Eval(Container.DataItem,"detail_id").ToString())%>" border=0 class="pdpic">
         <%#DataBinder.Eval(Container.DataItem,"title")%>
          <%#DataBinder.Eval(Container.DataItem,"color").ToString()==""?"":"<br>颜色："+DataBinder.Eval(Container.DataItem,"color").ToString()%>
          <%#DataBinder.Eval(Container.DataItem,"size").ToString()==""?"":"<br>尺寸："+DataBinder.Eval(Container.DataItem,"size").ToString()%>
          <%#DataBinder.Eval(Container.DataItem,"type").ToString()==""?"":"<br>类型："+DataBinder.Eval(Container.DataItem,"type").ToString()%>
         </td>
         <td><%#DataBinder.Eval(Container.DataItem,"member_price")%></td>
         <td align="center"><%#DataBinder.Eval(Container.DataItem,"num")%></td>
         <td align="center"><strong><%#DataBinder.Eval(Container.DataItem,"tj")%></strong></td>
       </tr>
   </ItemTemplate> 
</asp:Repeater>
     </table>

<div align="right" style="padding:10px 5px 5px 0">
<!--赠送积分总计：<%=Tongji_Point%>&nbsp;&nbsp;&nbsp;&nbsp;-->总计/All Total：<strong style="color:#ff0000"><%=Tongji%></strong>&nbsp;&nbsp;&nbsp;&nbsp
</div>
<table border=0 cellpadding=0 cellspacing="0" align="center" class="order">
 <tr class="send_header"><td align="left">&nbsp;&nbsp;<strong>配送方式/Delivery Mode：</strong></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing="1" align="center" class="order">
 <asp:Repeater id="S_List" Runat="server">
   <ItemTemplate>
   <tr>
    <td align="left" width="20%"><input name="sendway" id="sendway"  type="radio" value="<%#DataBinder.Eval(Container.DataItem,"id")%>"><%#DataBinder.Eval(Container.DataItem,"sendway")%></td>
    <td align="left" width="20%">配送费用/Cost：<strong style="color:#ff0000"><%#DataBinder.Eval(Container.DataItem,"spending")%></strong></td>
    <td align="left" style="padding:0 5px 0 5px" width="60%">说明/Remarks：<%#ubb(DataBinder.Eval(Container.DataItem,"introduct").ToString())%></td>
   </tr>
   </ItemTemplate>
 </asp:Repeater>
</table>
<br>
<table border=0 cellpadding=0 cellspacing="0" align="center" class="order">
 <tr class="send_header"><td align="left">&nbsp;&nbsp;<strong>收货人信息/Contact Information：</strong></td></tr>
</table>
<table border=0 cellpadding=3 cellspacing="0" align="center" class="order" width=100%>
        <tr>
         <td align="right" width=150px>联系人姓名/Contacts：</td>
         <td align="left"><input name="Name" id="Name" type="text" Maxlength="25" class="si" value="" style="width:150px"></td>
        </tr>
        <tr>
         <td align="right">联系电话/Tel：</td>
         <td align="left"><input id="Tel" name="Tel" type="text" Maxlength="30" class="si"  value="" style="width:150px"></td>
        </tr>
       <tr>
         <td align="right"> E-mail：</td>
         <td align="left"><input id="Email" name="Email" type="text" Maxlength="30" class="si" value="" style="width:150px"></td>
       </tr>

       <tr>
         <td align="right">详细地址/Address：</td>
         <td align="left"><input name="Address" id="Address" type="text" Maxlength="50" class="si" style="width:300px" value=""></td>
       </tr>

       <tr>
         <td align="right">邮编/Postcode：</td>
         <td align="left"><input name="PostCode" id="PostCode" type="text" Maxlength="6" style="width:150px" class="si" value=""></td>
       </tr>

       <tr style="display:none">
         <td align="right">QQ：</td>
         <td align="left"><input name="QQ" id="QQ" type="text" Maxlength="6" style="width:150px" class="si" value=""></td>
       </tr>

       <tr style="display:none">
         <td align="right">传真/Fax：</td>
         <td align="left"><input name="Fax" id="Fax" type="text" Maxlength="6" style="width:150px" class="si" value=""></td>
       </tr>

      <tr>
         <td align="right">其他说明/Remarks：</td>
         <td align="left"><textarea id="Beizhu" name="Beizhu" style="width:300px;height:50px;"></textarea></td>
       </tr>
   </table>
<div align=left style="width:98%">提示：请详细填写以上姓名、收货地址、电话、邮政编码等资料，不然可能导致送货失败。</div>
<div align="left" style="width:98%;padding:10px 0px">
<input type="button" value=" 上一步/Previous " class="bt" onclick="location.href='order.aspx?s=<%=SiteId%>&table=<%=Table%>'">&nbsp;&nbsp;<input type="button" value=" 提交订单/Submit Orders " class="bt"  onclick="checkall()">
</div>
<input type="hidden" name="post" value="add">
</form>
<br>
<br>
</center>
<script type="text/javascript">
 var sendway=document.getElementsByName("sendway");
 if(sendway.length>=1)
  {
   sendway[0].checked=true;
  }
function checkname()
 {
 var value=document.getElementById("Name").value;
  if(value.length<2)
  {
   alert("请正确填写联系人姓名！\r\nPlease fill in the contact!");
   document.getElementById("Name").focus();
   return false;
  }
  return true;
 }

function checktel()
 {
  var value=document.getElementById("Tel").value;
  if(value.length<8)
   {
    alert("请正确填写联系电话！\r\nPlease fill in the telephone!");
    document.getElementById("Tel").focus();
    return false;
   }

  return true;
 }

function checkcity()
 {
  return true;
  var value=document.getElementById("City").value;
  if(value.length<2)
  {
   alert("请填写您所在的城市！");
   document.getElementById("City").focus();
   return false;
  }

  return true;
 }

function checkemail()
 {
   var u_nme=document.getElementById("Email").value;
   if(u_nme.length==0)
     {
       alert("请填写E-Mail地址!\r\nPlease fill in E-Mail!");
      document.getElementById("Email").focus();
       return false;
     } 
   else
    {
      if (u_nme.charAt(0)=="." || u_nme.charAt(0)=="@" || u_nme.indexOf('@', 0) == -1 || u_nme.indexOf('.', 0) == -1 || u_nme.lastIndexOf("@")==u_nme.length-1 || u_nme.lastIndexOf(".")==u_nme.length-1)
        {
          alert("E-Mail格式错误!\r\nE-Mail format error!");
          document.getElementById("Email").focus();
          return false;
        }
      else
       {
          return true;
       }
   }

 }

function checkpostcode()
 {
  var value=document.getElementById("PostCode").value;
  if(!IsNum(value))
   {
    alert("请填写邮编号码!\r\nPlease fill in the postcode");
    document.getElementById("PostCode").focus();
    return false;
   }

  if(value.length!=6)
  {
   //alert("邮编只能由6位数字组成!");
   //document.getElementById("PostCode").focus();
   //return false;
  }

  return true;

 }

function checkaddress()
 {
  var value=document.getElementById("Address").value;
  if(value.length<5)
  {
    alert("请填写详细联系地址!\r\nPlease fill in the address!");
    document.getElementById("Address").focus();
    return false;
  }
  return true;
 }

function checkall()
 {
  var sendway=Get_Checked("sendway");
  if(sendway=="")
   {
    alert("请选择配送方式!\r\nPlease select the distribution method!");
    return false;
   }
  var Message=checkname() && checktel() && checkemail() && checkaddress() && checkpostcode();
  if(Message)
  {
    document.order.submit();
  }
  else
  {
   return false;
  }
 }
</script>
</body>
</html>

