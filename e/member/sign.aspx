<% @ Page language="c#" Inherits="PageAdmin.mem_sign"%><!DOCTYPE html>
<html>
<head>
<title>文件签收</title>
<meta name="Author" content="PageAdmin CMS" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<style type=text/css>
body,div,ul,li,table,p,form,legend,fieldset,input button,select,textarea,button{margin:0px;padding:0px;font-family:inherit;font-size:inherit;}
ul,li{list-style:none;}
input,select,textarea,button{font-size:100%;}
table{border-collapse:collapse;border-spacing:0;}
a{color:#333333;text-decoration:none;}
a:hover{color:#CC0000;text-decoration:none;}
body{word-wrap:break-word;text-align:center;font:12px/20px Verdana,Helvetica,Arial,sans-serif;color:#333333;padding-top:20px}
.page_style{width:95%;margin:0px auto 0px auto;text-align:center;background-color:#ffffff;overflow:hidden;}

#Ftable{border:1px solid #4388A9;text-align:center;}
#Ftable td{border:1px solid #4388A9;padding:3px 0 3px 10px}
.tdhead{background-color:#4388A9;color:#ffffff;text-align:center;font-weight:bold;border-color:#ffffff;}
.bt{width:55px;font-size:9pt;height:19px;cursor:pointer;background-image:url(/e/images/public/button.gif);background-position: center center;border-top: 0px outset #eeeeee;border-right: 0px outset #888888;border-bottom: 0px outset #888888;border-left: 0px outset #eeeeee;padding-top: 2px;background-repeat: repeat-x;}
.current{background-color:#efefef}
</style>
</head>
<body>
<div class="page_style">
<table border=0 cellpadding=0 cellspacing=0 width=95%  align="center">
 <tr> 
  <td align="left"><b>信息标题：</b><asp:Label id="lb_title" Runat="server"/></td>
 </tr>
 <tr>
  <td align="right">签收期限：<%=TheDate%> 至 <%=EndDate%></td>
 </tr>
</table>

<table border=1 cellpadding=0 cellspacing=0 width=95%  align="center" id="Ftable">
 <tr> 
 <td class="tdhead">会员账号</td>
 <td class="tdhead">姓名</td>
 <td class="tdhead">所在部门</td>
 <td class="tdhead">是否签收</td>
 <td class="tdhead">签名/回复</td>
 <td class="tdhead">签收时间</td>
 <td class="tdhead">签收ip</td>
 </tr>
<asp:Repeater id="P1" runat="server" OnItemDataBound="Data_Bound">         
 <ItemTemplate> 
 <tr<asp:Literal id="li_current" Runat="server"/>> 
 <td><asp:Label id="lb_username" Runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"username")%>'/></td>
 <td><%#DataBinder.Eval(Container.DataItem,"truename")%></td>
 <td><asp:Label id="lb_department" Runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"department_id")%>'/></td>
 <td><img src="/e/images/public/<asp:Literal id="lb_state" Runat="server"/>.gif"></td>
 <td><asp:Label id="lb_signature" Runat="server"/></td>
 <td><asp:Label id="lb_sign_date" Runat="server"/></td>
 <td><asp:Label id="lb_sign_ip" Runat="server"/></td>
 </tr>
</ItemTemplate>
</asp:Repeater>
</table>
<table border=0 cellpadding=5 cellspacing=0 width=95%  align="center">
 <tr> 
  <td align="left"><asp:PlaceHolder id="Psign" Runat="server"><form runat="server">
<asp:PlaceHolder id="PLogin" Runat="server">
用户名：<input type="textbox" name="username" id="username" size="10" maxlength="30"> 密码：<input type="password" name="password" id="password" size="10" maxlength="30">
</asp:PlaceHolder>
签收人签名/回复：<input type="textbox" name="signature" id="signature" size="30" maxlength="50"> <asp:button Text=" 签收 " id="bt" cssclass="bt" Runat="server" onclick="Add_Sign"/>
</asp:PlaceHolder>
<asp:Label id="lb_siteid" Runat="server" Visible="false"/>
<asp:Label id="lb_currentuser" Runat="server" Visible="false"/>
</form></asp:PlaceHolder>
<asp:Label id="lb_state" Runat="server" Visible="false" Text="签收已经结束!"/>
</td>
 </tr>
</table>
</div>
<script type="text/javascript">
function ck() 
 {
   var obj=document.getElementById("username");
   if(obj!=null && obj.value=="")
    {
      alert("请填写用户名!");
      obj.focus();
      return false;
    }
   obj=document.getElementById("password");
   if(obj!=null && obj.value=="")
    {
      alert("请填写密码!");
      obj.focus();
      return false;
    }
   obj=document.getElementById("signature");
   if(obj!=null && obj.value=="")
    {
      alert("请填写签名或回复!");
      obj.focus();
      return false;
    }
 }
</script>
</body>
</HTML>
