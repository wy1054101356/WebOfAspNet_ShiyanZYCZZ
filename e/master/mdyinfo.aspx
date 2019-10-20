<% @ Page Language="C#" Inherits="PageAdmin.mdyinfo"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>资料修改</b></td></tr>
 <tr><td height=10 ></td></tr>
</table>
<style type="text/css">
#mdyinfo tr td input.tb{border:1px solid #cccccc}
</style>
<table border=0 cellpadding=10 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<table border=0 cellpadding=0 cellspacing=0 width=100% align=center  class=table_style2>
<form  method="post" name="pa_member">
<tr>
  <td valign=top align="left">
<table border="0" cellpadding=5 cellspacing=0  align=center width="95%" id="mdyinfo">
<tr>
  <td align="left" colspan=2 height=30px><b>资料修改</b></td>
 </tr>
<tr>
 <td align=right>新密码<span style="color:#ff0000">*</span></td>
 <td><input type="password" size="25" maxlength="16" name="password" id="password" class="tb"/> 不修改密码请留空 </td>
</tr>

<tr>
 <td align=right>密码确认<span style="color:#ff0000">*</span></td>
 <td><input type="password" size="25" maxlength="16" name="password1" id="password1" class="tb"/> 密码再次确认 </td>
</tr>

<asp:PlaceHolder id="P_Form" Runat="server"/>
<tr><td colspan="2" align="center"><input name="post" type="hidden" value="edit"><input id="sub" type="submit"  value="修改" onclick="return Check_Reg()" class="button"><td></tr>
</table>
</form>
</td>
</tr>
</table>
</td>
</tr>
</table>
</center>
<script type="text/javascript">

function Check_Reg()
 {
  var obj=document.pa_member.password;
  if(obj.value=="")
   {
     //修改密码
   }
  else if(!IsStr(obj.value))
   {
     alert("密码只能由字母、数字、下划线组成!");
     obj.focus();
     return false;
   }
  else if(obj.value.length<4 || obj.value.length>16)
   {
     alert("密码必须在4—16个字符之间!");
     obj.focus();
     return false;
   }

 if(obj.value!=document.pa_member.password1.value)
   {
     alert("两次输入的密码不一致!");
     document.pa_member.password1.value="";
     return false;
   }
   
  var zdyform=Check_ZdyForm('pa_member');
  if(!zdyform)
   {
     return false;
   }
 }
</script>
</body>
</html>  



