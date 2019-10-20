<% @ Page Language="C#" Inherits="PageAdmin.member_info"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="member_list" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>会员信息</b><%if(Can_Delete=="1"){%><a href="javascript:delusername()">[删除当前会员]</a><%}%></td></tr>
 <tr><td height=10 ></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<iframe name="post_iframe" id="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form runat="server" target="post_iframe">
<div id="tabdiv">
<ul>
<li id="tab" name="tab"  style="font-weight:bold">会员信息</li>
<li id="tab" name="tab"  onclick="location.href='member_fnc_rk.aspx?username=<%=Server.UrlEncode(Request.QueryString["username"])%>'">入款/充积分</li>
<li id="tab" name="tab"  onclick="location.href='member_fnc_xf.aspx?username=<%=Server.UrlEncode(Request.QueryString["username"])%>'">扣款/扣积分</li>
<li id="tab" name="tab"  onclick="location.href='member_fnc_fk.aspx?username=<%=Server.UrlEncode(Request.QueryString["username"])%>'">返款/返积分</li>
<li id="tab" name="tab"  onclick="location.href='finance_list.aspx?field=username&keyword==<%=Server.UrlEncode(Request.QueryString["username"])%>'">财务记录</li>
<li id="tab" name="tab"  onclick="location.href='point_list.aspx?field=username&keyword==<%=Server.UrlEncode(Request.QueryString["username"])%>'">积分记录</li>
</ul>
</div>
<table border=0 cellpadding=2 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
 <table border=0 cellpadding="0px" cellspacing="1px" width=95% align=center>
      <tr>
        <td align="left" height="30px">会员类别：</td><td lign="left"><asp:DropDownList Id="Member_type" DataTextField="name"  DataValueField="id" runat="server"/></td>
        <td align="left"></td><td align="left"></td>
     </tr>
      <tr>
        <td align="left" width="10%" height="25px">用户名：</td><td lign="left"><asp:TextBox Id="UserName" runat="server" Cssclass="member_info_textbox" Readonly style="width:120px" />&nbsp;<input type="button" value="会员中心" class="f_bt" onclick="Go_Member()"/><a href="gotomember.aspx?username=<%=User_Name%>" id="gotomember" target="_blank"></a>&nbsp;<input type="button" value="发信" class="f_bt" onclick="SendMsg('<%=User_Name%>')"></td>
        <td align="left" style="color:#ff0000;display:<%=M_Group=="admin"?"none":""%>">类别转换：</td><td lign="left" style="display:<%=M_Group=="admin"?"none":""%>"><asp:TextBox  Id="ChangeType_Date" runat="server" size="15"  Maxlength="18" onclick="open_calendar('ChangeType_Date')"/>后转为 <asp:DropDownList Id="To_type" DataTextField="name"  DataValueField="id" runat="server"/></span> &nbsp;<asp:button Text="修改" cssclass="f_bt" runat="server" OnClick="Update_ChangeType"/></td>
     </tr>

     <tr>
        <td align="left" height="25px">部门：</td><td lign="left">
<select name="DepartMent" id="DepartMent">
<option value="0">未设置</option>
<%=DepartMentList%>
</select><script typr="text/javascript">document.getElementById("DepartMent").value="<%=DepartMent%>";</script></td>
       <td align="left" width="10%"  height="25px" style="color:#ff0000">密码：</td><td lign="left" ><asp:TextBox  Id="UserPass"  Cssclass="member_info_textbox"  runat="server" Maxlength="16"/>&nbsp;&nbsp;<asp:button Text="重置" id="SetPass" cssclass="f_bt" runat="server" OnClick="Update_Pass"/></td>       
     </tr>

      <tr>
        <td align="left" height="25px">注册时间：</td><td lign="left"><asp:TextBox Id="RegDate" runat="server" Cssclass="member_info_textbox" /></td>
        <td align="left">注册IP：</td><td lign="left"><asp:TextBox  Id="Reg_Ip" runat="server" Cssclass="member_info_textbox" /> <a href="javascript:GetIPAdd(Id('Reg_Ip').value)"><img src=images/sign_detail.gif border=0></a></td>
     </tr>

     <tr>
        <td align="left" height="25px">最后登陆时间：</td><td lign="left"><asp:TextBox Id="LastLogin" runat="server" Cssclass="member_info_textbox"/></td>
        <td align="left">最后登陆IP：</td><td lign="left"><asp:TextBox  Id="Lst_Ip" runat="server" Cssclass="member_info_textbox" /> <a href="javascript:GetIPAdd(Id('Lst_Ip').value)"><img src=images/sign_detail.gif border=0></a></td>
     </tr>
     <tr>
        <td align="left" height="25px">登录次数：</td><td lign="left"><asp:TextBox Id="Logins" runat="server" Cssclass="member_info_textbox" /></td>
        <td align="left"></td><td lign="left"></td>
     </tr>
   </table>
  </td>
  <tr>
 </table>

<br>
<table border=0 cellpadding=0 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">

 <table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
   <tr>
     <td height=20 colspan=4><b>财务信息</b></td>
   </tr>
      <tr>
        <td align="left" width="25%">可用金额&nbsp;&nbsp;<asp:TextBox  Id="Fnc_ky" runat="server" size="12" Maxlength="20"  onkeyup="if(isNaN(value))this.value='0'" /></td>

        <td align="left" width="25%">消费金额&nbsp;&nbsp;<asp:TextBox  Id="Fnc_xf" size="12"  runat="server" Maxlength="20" onkeyup="if(isNaN(value))this.value='0'"  /></td>

        <td align="left" width="25%">返款总额&nbsp;&nbsp;<asp:TextBox  Id="Fnc_fk" runat="server" size="12"  Maxlength="20" onkeyup="if(isNaN(value))this.value='0'"  /></td>

        <td align="left" width="25%">入款总数&nbsp;&nbsp;<asp:TextBox  Id="Fnc_rk" runat="server" size="12"  Maxlength="20" onkeyup="if(isNaN(value))this.value='0'"  /></td>
     </tr>
   </table>
  </td>
  <tr>
 </table>
<br>
<table border=0 cellpadding=0 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
 <table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
   <tr>
     <td height=20 colspan=4><b>积分信息</b></td>
   </tr>
      <tr>
        <td align="left" width="25%">可用积分&nbsp;&nbsp;<asp:TextBox  Id="Point_ky" runat="server" size="12" Maxlength="20"  onkeyup="if(isNaN(value))this.value='0'"/></td>

        <td align="left" width="25%">消费积分&nbsp;&nbsp;<asp:TextBox  Id="Point_xf" size="12"  runat="server" Maxlength="20" onkeyup="if(isNaN(value))this.value='0'"/></td>

        <td align="left" width="25%">返点积分&nbsp;&nbsp;<asp:TextBox  Id="Point_fk" runat="server" size="12"  Maxlength="20" onkeyup="if(isNaN(value))this.value='0'" /></td>

        <td align="left" width="25%">充值总数&nbsp;&nbsp;<asp:TextBox  Id="Point_rk" runat="server" size="12"  Maxlength="20" onkeyup="if(isNaN(value))this.value='0'" /></td>
     </tr>
   </table>

  </td>
  <tr>
 </table>
<br>

<table border=0 cellpadding=0 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
 <table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
      <asp:Repeater id="p_tb" runat="server">
         <ItemTemplate>
          <tr>
          <td align="left" width="80px"><b><%#DataBinder.Eval(Container.DataItem,"table_name")%></b></td>
          <td align="left">
         总数：<input type="text" value="<%#Tj(DataBinder.Eval(Container.DataItem,"thetable").ToString(),"all")%>"  disabled="disabled" class="member_info_textbox" style="width:50px" />&nbsp;&nbsp;
         待审：<input type="text" value="<%#Tj(DataBinder.Eval(Container.DataItem,"thetable").ToString(),"nocheck")%>" disabled="disabled" class="member_info_textbox" style="width:50px" />&nbsp;&nbsp
         草稿：<input type="text" value="<%#Tj(DataBinder.Eval(Container.DataItem,"thetable").ToString(),"cg")%>"  disabled="disabled" class="member_info_textbox" style="width:50px" />
         <a href="data_list.aspx?table=<%#Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"thetable").ToString())%>&name=<%#Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"table_name").ToString())%>&field=username&keyword=<%=Server.UrlEncode(Request.QueryString["username"])%>"><img src=images/sign_detail.gif border=0></a>
        </td>
         </tr>
         </ItemTemplate>
        </asp:Repeater>
   </table>

  </td>
  <tr>
 </table>
<br>

<table border=0 cellpadding=0 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">

  <table border=0 cellpadding=5 cellspacing=0 width=95% align=center>
    <tr><td width=100px></td><td></td></tr>
   <tr>
     <td height=20 colspan=2><b>自定义信息</b></td>
   </tr>
   <asp:PlaceHolder id="P_Form" Runat="server"/>
  </table>
 </td>
 <tr>
</table>

<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr>
<td height=25 align=center >
<span id="post_area">
<asp:Button  Cssclass=button  text="修改"  id="Bt_Submit" onclick="Data_Update" runat="server" />
<input type="button" class=button  value="返回"  onclick="Back()">
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>
</td>
 </tr>
</table>
</form>
</td>
</tr>
</table>
<br>
</center>
<script type="text/javascript">
if(typeof(load_form_structure)=="function")
{
 load_form_structure("<%=Mtype_Id%>","edit","pa_member");
}
function Go_Member()
 {
  document.getElementById("gotomember").click();
 }
function SendMsg(UserName)
 {
  IDialog("发送信息","msg_single.aspx?receiver="+encodeURI(UserName),600,360);
 }

function Back()
 {
   if("<%=Request.QueryString["typeid"]%>"!="")
    {
    location.href="member_list.aspx?typeid=<%=Request.QueryString["typeid"]%>";
    }
   else
    {
    location.href="member_list.aspx";
    }
 }

function delusername()
 {
  if(confirm("确定删除吗?"))
   {
   var UserName="<%=Request.QueryString["username"]%>";
   var R=Math.random();
   var x=new PAAjax();
   x.setarg("post",false);
   x.send("member_list.aspx","act=delete&username="+encodeURI(UserName)+"&r="+R,function(v){document.write("<br>&nbsp;&nbsp;用户："+UserName+"删除成功!")});
  }
 }
document.getElementById("Bt_Submit").onclick=startpost;
</script>
</body>
</html>