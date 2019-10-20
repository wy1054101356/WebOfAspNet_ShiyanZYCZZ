<% @ Page Language="c#" Inherits="PageAdmin.master_login"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>PageAdmin网站管理系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Author"  content="PageAdmin CMS" />
<meta name="Copyright"  content="http://www.pageadmin.net" />
<link rel="stylesheet" href="master.css" type="text/css">
<script src="master.js" type="text/javascript"></script>

<style type="text/css">
.master_tb{width:130px;height:18px;border:1px solid #cccccc;background:url(images/login_tb_bg.jpg) repeat-x 0 0;}
.master_yzm{width:60px;height:18px;border:1px solid #cccccc;background:url(images/login_tb_bg.jpg) repeat-x 0 0;}
.masterlogin{background:url(images/master_login.jpg) no-repeat 0 0;width:62px;height:20px;border-width:0px;margin:2px 5px 0 0;color:#333;font-size:12px;cursor:pointer}
.masterlogin:hover{color:#666;font-size:13px;}
</style>
</head>
<body>
<table border=0 cellpadding=0 cellspacing=0 width=100% style="margin:150px 0 0 0;">
 <tr>
  <td valign=center height=100% align=center style="padding:20px 0 0 0">

  <div style="background:url(images/login.jpg) no-repeat;width:242px;height:141px;padding:155px 0px 0px 264px;margin:0px auto;">
<table border="0" cellpadding=0 cellspacing=0 width=100%>
<form method="post" onsubmit="return check_login()">
<tr>
<td height=27px align="right" width="80px">管理员：</td><td align=left><input type="textbox" class="master_tb" id="username" name="username"  maxlength="25" size="15" /></td>
<tr>
<td height=27px align="right">密&nbsp;&nbsp;码：</td><td align=left><input type="password" class="master_tb" id="password"  name="password" maxlength="25" size="15" /></td>
</tr>
<tr>
<td height=27px align="right">验证码：</td><td align=left><input type="textbox" class="master_yzm" id="validatecode" name="validatecode" maxlength="25" size="15"/>
<img src="/e/aspx/yzm.aspx" align=absmiddle border=0 Onclick="Code_Change()" id="validatecodeimg"  alt="点击更换" style='cursor:pointer;height:20px'>
</td>
</tr>
<tr>
<td height=27px align=center colspan="2">
    <input type="submit" value="登 陆" class="masterlogin">&nbsp;&nbsp;
    <input type="button" value="返 回" class="masterlogin"  onclick="location.href='/'">
</td>
</tr>
</form>
</table>
 </div>
 </td>
 </tr>
</table>
<script  language="javascript" type="text/javascript">
function check_login()
 {

  Obj=document.getElementById("username");
  if(Obj.value=="")
   {
     alert("请输入管理员账户!");
     Obj.focus();
     return false;
   }


  Obj=document.getElementById("password");
  if(Obj.value=="")
   {
     alert("请输入管理员密码!");
     Obj.focus();
     return false;
   }

  Obj=document.getElementById("validatecode");
  if(Obj.value=="")
   {
     alert("请输入验证码!");
     Obj.focus();
     return false;
   }

 }

function Code_Change()
 {
  var R=Math.floor(Math.random()*10+1);
  Obj=document.getElementById("validatecodeimg");
  Obj.src="../aspx/yzm.aspx?r="+R;
 }
</script>
</body>
</html>
