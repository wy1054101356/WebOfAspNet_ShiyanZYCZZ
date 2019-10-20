<% @ Page Language="C#"  Inherits="PageAdmin.member_set"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="member_set"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>会员系统设置</b></td></tr>
 <tr><td height=10 ></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<iframe name="post_iframe" id="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form runat="server" target="post_iframe">
<div id="tabdiv">
<ul>
<li id="tab" name="tab"  onclick="showtab(0)" style="font-weight:bold">基础设置</li>
<li id="tab" name="tab"  onclick="showtab(1)">邮件设置</li>
</ul>
</div>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">

<div name="tabcontent" id="tabcontent">
    <table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
      <tr>
        <td height=25  width="150px">会员注册</td>
        <td>
         <asp:DropDownList Id="Dl_Reg" Runat="server">
          <asp:ListItem value="1">开放注册</asp:ListItem>
          <asp:ListItem value="0">关闭注册</asp:ListItem>
         </asp:DropDownList>
       </td>
     </tr>

   <tr>
    <td align="left">禁止注册会员<br><span style="color:#666666">半角逗号分开</span></td>
   <td align="left" ><asp:TextBox id="Tb_forbid_username"  TextMode="multiLine"  columns="80" rows="5" runat="server" /></td>
  </tr>

   <tr>
    <td align="left">同ip注册时间限制<br><span style="color:#666666">0为不限制</span></td>
   <td align="left"><asp:TextBox id="Tb_regtime_limit" runat="server" maxlength="6" size="5"/>分钟</td>
  </tr>

 <tr>
   <td align="left">短信息自动清理</td>
   <td align="left"><asp:TextBox id="Tb_msg_expire" runat="server" maxlength="10" size="10"/>天前的信息  &nbsp;<span style="color:#666666">0为不清理</span></td>
 </tr>

 <tr>
   <td align="left">防注册机随机码</td>
   <td align="left"><asp:TextBox id="Tb_security_code" runat="server" maxlength="15" size="15"/> &nbsp;<span style="color:#666666">定时修改可有效防止注册机</span></td>
 </tr>

   <tr>
    <td align="left">会员注册协议</td>
   <td align="left"><asp:TextBox id="Agreement"  TextMode="multiLine"  columns="80" rows="15" runat="server" /></td>
  </tr>
  </table>
</div>

<div name="tabcontent" id="tabcontent" style="display:none">
 <table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
      <tr>
        <td height=25 width="180px" align=left>会员注册发送邮件
         <br><span style="color:#666666">{pa:username}:用户名<br>{pa:password}:用户密码<br>{pa:truename}:姓名
        </td>
        <td>
           标题：<asp:TextBox Id="regmail_title" runat="server" maxlength="50" size="40"/>
           <br>
           <asp:TextBox id="regmail_content"  TextMode="multiLine"  columns="80" rows="8" runat="server" />
        </td>
     </tr>
  <tr>
        <td height=25 width="180px" align=left>会员注册激活邮件
         <br><span style="color:#666666">{pa:username}:用户名<br>{pa:password}:用户密码<br>{pa:truename}:姓名<br>{pa:acturl}:激活地址
        </td>
        <td>
           标题：<asp:TextBox Id="actmail_title" runat="server" maxlength="50" size="40"/>
           <br>
           <asp:TextBox id="actmail_content"  TextMode="multiLine"  columns="80" rows="8" runat="server" />
        </td>
     </tr>
  <tr>
        <td height=25 width="180px" align=left>会员密码找回邮件
         <br><span style="color:#666666">{pa:username}:用户名<br>{pa:password}:新密码<br>{pa:truename}:姓名
        </td>
        <td>
           标题：<asp:TextBox Id="passmail_title" runat="server" maxlength="50" size="40"/>
           <br>
           <asp:TextBox id="passmail_content"  TextMode="multiLine"  columns="80" rows="8" runat="server" />
        </td>
     </tr>
  </table>
</div>

  </td>
  <tr>
 </table>
<br>
<div align=center>
<span id="post_area"><asp:Button class=button  text="提交"  Id="Bt_Submit" runat="server" OnClick="Data_Update" /></span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>
</div>
</form>
<br>
</td>
</tr>
</table>
</center>
</body>
<script language="javascript"> 
document.getElementById("Bt_Submit").onclick=msetpost;

function msetpost()
 {
   var security_code=document.getElementById("Tb_security_code").value;
   var R=Math.random();
   var x=new PAAjax();
   x.setarg("post",false);
   x.send("field_list.aspx","act=updateform&table=pa_member&security_code="+security_code+"&r="+R,function(v){startpost();});
 }
</script>
</html>  



