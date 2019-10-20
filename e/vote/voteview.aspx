<% @ Page language="c#" Inherits="PageAdmin.voteview" src="~/e/vote/voteview.aspx.cs"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=VoteTitle%></title>
</head>
<style type="text/css">
body {word-break:break-all;color:#333333;margin: 0 0 0 0;font-size:12px;line-height:20px;text-align:center;font-family:宋体,Arial;background:url(images/top_bg.jpg) repeat-x center top;}
a:hover {color:#FF9900;text-decoration:none;}
ul,li,td{list-style-type:none;margin:0 0 0 0;padding:0 0 0 0;font-size:12px;}
a{color:#333333;text-decoration:none;}
a:hover {color:#FF9900;text-decoration:none;}
.clear{display:block;clear:both;font-size:0px;height:0px;line-height:0px;width:0px;margin:0 0 0 0;padding:0 0 0 0;overflow:hidden}

.page_style{width:800px;margin:0 0 0 0;Text-align:left;padding-top:50px;margin-left:auto;margin-right:auto;Text-align:center;}

.head{height:100px;background:url(images/head_bg.jpg) repeat-y center top;Text-align:left;}
.middle{background:url(images/middle_bg.jpg) repeat-y center top;Text-align:left;padding:10px 40px 0 60px;}
.bottom{width:100%;height:40px;background:url(images/bottom_bg.jpg) repeat-y center top;Text-align:left;}


.votetitle{display:block;padding:35px 0px 0 90px;font-weight:bold;font-size:15px;color:#ffffff}
.voteinfo{display:block;text-align:right;padding:10px 100px 0 0}

.q_item{padding-bottom:10px;}
.quesion{display:block;font-weight:bold;font-size:13px;background-color:#ececec;height:20px;padding:2px 0 3px 5px;margin-bottom:2px}
li .choice{float:left;width:73%;padding:2px 0 3px 0;}
li .result{float:right;width:27%;padding:0 0 0 0;}
</style>
</head>
<body>
<div class="page_style">
<div class="head">
<span class="votetitle"><%=VoteTitle%></span>
<span class="voteinfo">调查日期：<%=StartDate%> 至 <%=EndDate%></span>
</div>
<div class="middle">
<ul>
<asp:Repeater id="P" runat="server" OnItemDataBound="Data_Bound">
<ItemTemplate>
 <li class="q_item"><span class="quesion"><%=I++%>.<%#DataBinder.Eval(Container.DataItem,"quesion")%></span>
<asp:Label id="Lb_thetype" Text='<%#DataBinder.Eval(Container.DataItem,"thetype")%>' Runat="server" Visible="false"/>
<asp:Label id="Lb_id" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' Runat="server"  Visible="false"/>
  <ul>
     <asp:Repeater id="P1" runat="server"><ItemTemplate>
       <li class="choice"><input type="<%#Thetype%>" name="q_<%#QuesionId%>" id="q_<%#QuesionId%>" value="<%#DataBinder.Eval(Container.DataItem,"id")%>" disabled><%#DataBinder.Eval(Container.DataItem,"choice")%></li>
       <li class="result"><%#GetPercent(DataBinder.Eval(Container.DataItem,"num").ToString(),QuesionId)%> <img src="images/vote_bar.jpg" height="8px" width="<%#BarWidth%>px"> <%#DataBinder.Eval(Container.DataItem,"num")%>票&nbsp;<%#Per%></li>
       <li class="clear"></li>
     </ItemTemplate></asp:Repeater>
  </ul>      
 </li>
</ItemTemplate>
</asp:Repeater>
<ul>
</div>
<div class="bottom"></div>
</body>
</html>