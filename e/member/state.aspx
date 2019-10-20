<% @ Page language="c#" Inherits="PageAdmin.mem_issue"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>信息操作记录</title>
<meta name="Author" content="PageAdmin CMS" />
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/ >
<style type=text/css>
body,div,ul,li,table,p,form,legend,fieldset,input button,select,textarea,button{margin:0px;padding:0px;font-family:inherit;font-size:inherit;}
input,select,textarea,button{font-size:100%;}
ul,li{list-style:none;}
table{border-collapse:collapse;border-spacing:0;}
a{color:#333333;text-decoration:none;}
a:hover{color:#CC0000;text-decoration:none;}
body{word-wrap:break-word;text-align:center;font:12px/20px Verdana,Helvetica,Arial,sans-serif;color:#333333;padding-top:10px}
.page_style{width:95%;margin:0px auto 0px auto;text-align:center;background-color:#ffffff;overflow:hidden;}

#Ftable{border:1px solid #4388A9;text-align:center;}
#Ftable td{border:1px solid #4388A9;padding:5px 2px}
.tdhead{background-color:#4388A9;color:#ffffff;text-align:center;font-weight:bold;border-color:#ffffff;}
.bt{width:55px;font-size:9pt;height:19px;cursor:pointer;background-image:url(/e/images/public/button.gif);background-position: center center;border-top: 0px outset #eeeeee;border-right: 0px outset #888888;border-bottom: 0px outset #888888;border-left: 0px outset #eeeeee;padding-top: 2px;background-repeat: repeat-x;}
.current{background-color:#efefef}

.overcolor td,.tb_datalist tr.overcolor td{background-color:#E0F0FE}
</style>
</head>
<body>
<div class="page_style">
<center>
<table border=0 cellpadding="2px" cellspacing="0" width=100% align=center>
   <tr>
      <td height=20 align="left">信息标题：<%=DataTitle%>(状态：<%=current_work_state%>)</td>
   </tr>
</table>

 <table border=0 cellpadding=0 cellspacing=0 width=100% id="Ftable">
   <tr>
     <td align=center width=15% class=tdhead height=20px>步骤</td>
     <td align=center width=15% class=tdhead>状态/操作</td>
     <td align=center width=30% class=tdhead>点评/回复</td>
     <td align=center width=15% class=tdhead>操作者</td>
     <td align=center width=25% class=tdhead>操作时间</td>
   </tr>
   <asp:Repeater id="plist" Runat="server">
    <ItemTemplate>
   <tr class="listitem">
   <td align=center><%#GetNodeName(DataBinder.Eval(Container.DataItem,"work_node").ToString())%></td>
   <td align=center><%#DataBinder.Eval(Container.DataItem,"act").ToString()%></td>
   <td align=left><%#DataBinder.Eval(Container.DataItem,"reply")%></td>
   <td align=center><%#GetUser(DataBinder.Eval(Container.DataItem,"username").ToString())%></td>
   <td align=center><%#DataBinder.Eval(Container.DataItem,"thedate")%></td>
   </tr>
    </ItemTemplate>
  </asp:Repeater>
 </table>
<br>
</center>
<script type="text/javascript">
MouseoverColor("Ftable");
function MouseoverColor(id)
{
 var trs=document.getElementById(id).getElementsByTagName("tr");
 for(var i=0 ;i<trs.length;i++)
  {
   if(trs[i].className.indexOf("listitem")>=0)
   {
   trs[i].onmouseover=function(){this.className+=" overcolor";}
   trs[i].onmouseout=function(){this.className=this.className.replace(" overcolor","")}
   }
  }
}
</script>
</body>
</html> 