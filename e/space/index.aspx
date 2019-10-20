<% @ Page language="c#" Inherits="PageAdmin.space" src="space.cs"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=Space_Title%>-PageAdmin Cms</title>
<meta name="Author" content="PageAdmin CMS" />
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<script src="/e/js/jquery.min.js" type="text/javascript"></script>
<script src="/e/js/function.js" type="text/javascript"></script>
<script src="/e/js/space.js" type="text/javascript"></script>
<link href="skins/01/style.css" type="text/css" rel="stylesheet" />
</head>
<body>
<div class="page_style">
<div class="top_box">
<asp:PlaceHolder id="P1" Runat="server" Visible="false">
<a href="<%=Get_Url("login")%>">会员登录</a> &nbsp;|&nbsp; <a href="<%=Get_Url("reg")%>">会员注册</a>
</asp:PlaceHolder>
<asp:PlaceHolder id="P2" Runat="server" Visible="false">
会员名：<%=LoginName%><a href="<%=Get_Url("mem_msg")%>"><img src=/e/images/public/message.gif border=0 width=20px height=17px style="display:<%=msg_icon_show%>"></a>
&nbsp;&nbsp;会员组：<%=Login_Member_Type%>&nbsp;&nbsp;<a href="<%=Get_Url("mem_idx")%>" class="login" target="_blank">会员中心</a>&nbsp;&nbsp;<a href="/e/space/?uid=<%=UID%>&type=exit" class="login">注销退出</a>
</asp:PlaceHolder>
</div>
<div class="banner_box" style="background:url(<%=Space_Banner%>) no-repeat 0 0">
<span class="title"><%=Space_Title%></span>
<span class="introduction"><%=Space_Introduction%></span>
</div>
<!--菜单开始-->
<div class="menu_box">
<div class="menu_box_top"></div>

  <div class="menu_box_lanmu" id="Menu"><ul>
 
  <li class="menu_style"><a href="/e/space/?uid=<%=UID%>" class="menu" target='_self'>空间首页</a></li>
  <asp:Repeater Id="P_Menu" runat="server">
  <ItemTemplate>
  <li class="menu_style"><a href="/e/space/?uid=<%=UID%>&tid=<%#DataBinder.Eval(Container.DataItem,"id")%>" class="menu" target='_self'><%#DataBinder.Eval(Container.DataItem,"table_name")%></a></li>
  </ItemTemplate></asp:Repeater>
  <li class="menu_style"><a href="/e/space/?uid=<%=UID%>&type=fbk" class="menu" target='_self'>给我留言</a></li>
  </ul></div>
</div>
<!--菜单结束-->
<div class="lanmu_box">
<div class="lanmu_box_left"><!--左侧开始--><asp:PlaceHolder Id="P_UC" Runat="server"/><!--左侧结束--></div>
<div class="lanmu_box_right"><!--右侧-->
<div  class="nav_box">
<div class="nav_title"><span class="nav_sign"><%=UserName%>的个人资料</span></div>
<div class="nav_content"><ul style="line-height:25px">
<li style="text-align:center;padding:5px 0 5px 0">
<img  src="<%=Head_Image%>" class="headimage">
<br>[<a href="<%=Get_Url("mem_msgsend")%>&sendto=<%=UserName%>" target="_blank">发短信</a>] &nbsp;[<a href="/e/space/index.aspx?uid=<%=UID%>&type=fbk">留言</a>] &nbsp;[<a href="javascript:addFav()">收藏</a>]
</li>
<li>姓名：<%=TrueName%></li>
<li>用户组：<%=Member_Type%></li>
<li>空间访问次数：<%=Space_Clicks%></li>
</ul>
</div>
</div>
<div  class="nav_box">
<div class="nav_title"><span class="nav_sign"><%=UserName%>的简介</span></div>
<div class="nav_content"><%=Introduction%></div>
</div>
<!--右侧结束-->
</div>
<div class="clear"></div>
<div class="bottom_box">
Copyright © 2012  <%=Request.ServerVariables["SERVER_NAME"]%>
</div>
</div>
</body>
<script type="text/javascript">
SpaceCount("<%=UID%>");
function addFav()
{
try{window.external.addFavorite(location.href,"<%=Space_Title%>");}
catch(e) 
 {
  try {window.sidebar.addPanel("<%=Space_Title%>",location.hre, "");}
  catch (e) {alert("浏览器不支持此功能，请手工添加");}
  }
}   
</script>
</html>