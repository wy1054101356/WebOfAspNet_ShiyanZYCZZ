<% @ Page Language="C#" Inherits="PageAdmin.exchange_info"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="bs_exchange" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload()" title="点击刷新"><b>兑换详细资料</b></a></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top  align="left">

<form runat="server" >
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
<table border=0 cellpadding=0 cellspacing=0 width=95% align=center>
<tr>
  <td  width=50% height=25><b>兑换详细资料</b></td>
  <td width=50%  height=25 align=right></td>
 </tr>
</table>
   <table border=0 cellpadding=0 cellspacing=0 width=95% align=center>
    <tr>
      <td height=25>
兑换用户：admin &nbsp;
发货状态：
<asp:DropDownList id="SendState" runat="server">
<asp:ListItem value="0">待处理</asp:ListItem>
<asp:ListItem value="1">已发货</asp:ListItem>
</asp:DropDownList>
操作人：<asp:TextBox id="TbChargeName" runat="server" Size="15" Enabled="false"/>
</td>

    </tr>
  </table>

<table border=0 cellpadding=5 cellspacing=0 width=95% align=center  class=tablestyle>
      <tr>
         <td height=20 class=white colspan=2 align=center>兑换信息</td>
       </tr>

      <tr>
         <td height=20  width=120 class=tdstyle>兑换商品：</td><td class=tdstyle><a target=view href="<%=Url%>"><%=TheTitle%></a></td>
       </tr>

      <tr>
         <td height=20  width=120 class=tdstyle>兑换数量：</td><td class=tdstyle><%=Num%></td>
       </tr>

      <tr>
         <td height=20 class=tdstyle>兑换积分：</td><td class=tdstyle><span style="color:#ff0000;font-weight:bold"><%=PayPoint%></span>积分</td>
       </tr>

      <tr>
         <td height=20 class=tdstyle>兑换时间：</td><td class=tdstyle><%=TheDate%></td>
       </tr>

      <tr>
         <td height=20 class=tdstyle>收货人：</td><td class=tdstyle><%=Name%></td>
       </tr>

      <tr>
         <td height=20 class=tdstyle>联系电话：</td><td class=tdstyle><%=Tel%></td>
       </tr>

       <tr>
         <td height=20 class=tdstyle>Email：</td><td class=tdstyle><%=Email%></td>
       </tr>

       <tr>
         <td height=20 class=tdstyle>收货地址：</td><td class=tdstyle><%=Address%></td>
       </tr>

      <tr>
         <td height=20 class=tdstyle>邮编：</td><td class=tdstyle><%=PostCode%></td>
       </tr>

      <tr>
         <td height=20 class=tdstyle>回复：</td><td class=tdstyle><asp:TextBox id="TBizhu" TextMode="multiline" Columns="60" rows="4"  runat="server" /></td>
       </tr>
</table>
<br>
<div align=center>
<asp:Button Text="提交" runat="server" CssClass="button" Onclick="Update_Data" />
<input type="button" class=button  value="返回"  onclick="location.href='exchange_list.aspx?username=<%=Server.UrlEncode(Request.QueryString["username"])%>'">

</div>
</td>
</tr>
</table>
</form>
</td>
</tr>
</table>
<br>
</center>
</body>
</html>  