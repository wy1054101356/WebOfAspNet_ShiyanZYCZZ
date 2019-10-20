<% @ Page Language="C#" Inherits="PageAdmin.member_add"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="member_add" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b><%=Act=="add"?"增加会员":"资料修改"%></b></td></tr>
 <tr><td height=10 ></td></tr>
</table>
<style type="text/css">
#mdyinfo tr td input.tb{border:1px solid #cccccc}
</style>
<table border=0 cellpadding=0 cellspacing=0 width=95%>
 <tr>
<td valign=top align="left">
<table border=0 cellpadding=0 cellspacing=0 width=100% align=center class=table_style2>
<iframe name="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form  method="post" name="pa_member" target="post_iframe">
<tr>
  <td valign=top align="left" style="padding:10px 0 0 0">
<table border="0" cellpadding=5 cellspacing=0  align=center width="98%" id="mdyinfo">
<%if(Act=="add"){%>
<tr style="display:<%=RegTypeCount<1?"none":""%>">
 <td align=right class="tdhead">注册类型<span style="color:#ff0000">*</span></td>
 <td>
 <select name="Reg_type" id="Reg_type" onChange="c_regtype(this.options[this.selectedIndex].value)" >
<option value="0">请选择注册类型</option>
<%
Default_MemberTypeId="0";
string[] Amtypes=Amtype.Split(',');
string[] Amids=Amid.Split(',');
for(int i=0;i<RegTypeCount;i++)
 {
%><option value="<%=Amids[i]%>"><%=Amtypes[i]%></option>
<%}%></select>
</td>
</tr>
<tr>
 <td align=right width=100px>用户名<span style="color:#ff0000">*</span></td>
 <td><input type="text" size="25" maxlength="16" name="username" id="username" class="m_tb"/> 由汉字、字母、数字、下划线组成(4-16位)</td>
</tr>
<%}%>
<tr>
 <td align=right>新密码<span style="color:#ff0000">*</span></td>
 <td><input type="password" size="25" maxlength="16" name="password" id="password" class="m_tb"/> <%=Act=="add"?"用户登录密码":"不修改密码请留空 "%></td>
</tr>
<tr>
 <td align=right>密码确认<span style="color:#ff0000">*</span></td>
 <td><input type="password" size="25" maxlength="16" name="password1" id="password1" class="m_tb"/> 密码再次确认 </td>
</tr>
<asp:PlaceHolder id="P_Form" Runat="server"/>
</table>
<div align=center style="padding:10px">
<span id="post_area">
<input name="post" type="hidden" value="<%=Act%>">
<input id="Bt_Submit" type="submit"  value="提交" onclick="return Check_Info()" class="button">
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>
</div>
</form>
</td>
</tr>
</table>
</td>
</tr>
</table><br>
</center>
<script type="text/javascript">
var Act="<%=Act%>";
if(typeof(load_form_structure)=="function")
{
load_form_structure("<%=Default_MemberTypeId%>","add","pa_member");
}
function c_regtype(typeid)
 {
  if(typeof(load_form_structure)=="function")
  {
  load_form_structure(typeid,"add",pa_member);
  }
 }
function Check_Info()
 {
  var obj;
  if(Act=="add")
  {
   obj=document.pa_member.Reg_type;
   if(obj.value=="0")
   {
     alert("请选择注册类型!");
     obj.focus();
     return false;
   }
  obj=document.pa_member.username;
  if(obj.value=="")
   {
     alert("请填写用户名!");
     obj.focus();
     return false;
   }
  else if(!IsUserName(obj.value))
   {
     alert("用户名只能由字母、数字、下划线组成!");
     obj.focus();
     return false;
   }
  else if(Length(obj.value)<4 || Length(obj.value)>16)
   {
     alert("用户名必须在4—16个字符之间!");
     obj.focus();
     return false;
   }
  }

  obj=document.pa_member.password;
  if(obj.value=="")
   {
    if(Act=="add")
     {
      alert("请填写密码!");
      obj.focus();
      return false;
     }
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
 if(obj.value!="" && document.pa_member.password1.value=="")
   {
     alert("请输入确认密码!");
     document.pa_member.password1.focus();
     return false;
   }
 if(obj.value!="" && obj.value!=document.pa_member.password1.value)
   {
     alert("两次输入的密码不一致!");
     document.pa_member.password1.value="";
     obj.focus();
     return false;
   }
  var zdyform=Check_ZdyForm('pa_member');
  if(!zdyform)
   {
     return false;
   }
 }
//document.getElementById("Bt_Submit").onclick=startpost;
</script>
</body>
</html>