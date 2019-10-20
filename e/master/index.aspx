<!DOCTYPE HTML>
<HTML>
<head>
<title>PageAdmin网站管理系统</title>
<meta name="Author"  content="PageAdmin CMS" />
</head>
</html>
<%if(Request.Cookies["master"]!=null){%>
<frameset cols="140,*" framespacing="0" border="0"  id="leftmenu" name="leftmenu">
    <frame id="left" name="left" scrolling="auto" noresize frameborder=no marginwidth=0 marginheight=0 src="left.aspx">
    <frameset rows="50,*,15" framespacing="0" border="0">
         <frame id="m_head" name="m_head"  frameborder="no" scrolling="no" noresize marginwidth=0 marginheight=0 src="m_top.aspx">
         <frame id="right" name="right"   frameborder="no" scrolling="auto" noresize marginwidth=0 marginheight=0 src="sysmain.aspx">
         <frame frameborder="no" scrolling="no" noresize marginwidth=0 marginheight=0 src="m_bottom.aspx">
   </frameset>
</frameset>
<%}else{%>
<script type="text/javascript">
top.location.href="login.aspx";
</script><%}%>



