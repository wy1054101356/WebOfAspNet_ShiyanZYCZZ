<% @ Page language="c#" Inherits="PageAdmin.orderview" src="~/e/order/orderview.cs"%>
<html>
<head>
<title>订单查看</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
body,td{  
        word-break:break-all;
        color:#000000;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #ffffff;
	font-size: 12px;
        line-height:18px;

}
a{color:#333333}
.table_style{background-color:#ffffff;border-collapse:collapse;}
.pdpic{width:150px;display:none}
</style>
</head>
<br>
 <table border=0 cellpadding=0 cellspacing=0 width=800 align=center >
    <tr>
      <td align="center">
 <asp:PlaceHolder  id="P1" runat="server">
   <table border=0 cellpadding=5 cellspacing=0 width=95% align=center>
    <tr>
      <td height=25 width=30%></td>
     <td height=25 width=40% align=center style="font-size:16;font-weight:bold;text-decoration:underline">订 购 单</td>
      <td height=25 width=30% align=right><span style="font-size:13">No：</span><asp:Label id="Lblorderid" runat="server"/></td>
    </tr>
      <tr>
         <td height=1 colspan=3 bgcolor=#cccccc></td>
        </tr>
  </table>
   <table border=0 cellpadding=5 cellspacing=0 width=95% align=center class="table_style">
    <tr>
      <td height=25 width=70%>
付款状态：<asp:Label id="PayState" runat="server"  forecolor="#ff0000" />&nbsp;
发货状态：<asp:Label id="SendState" runat="server" forecolor="#ff0000" />&nbsp;
跟单客服：<asp:Label id="ChargeName" runat="server" />
</td>
     <td height=25 width=30% align=center>订单日期：<asp:Label id="Thedate" runat="server" /></td>
    </tr>
  </table>

<asp:Repeater id="DL_1"   runat="server" >
   <HeaderTemplate>
     <table border=0 cellpadding=5 cellspacing=1 width=95% align=center bgcolor="#cccccc">
      <tr>
         <td height=25 width=5% align=center class="table_style">序号</td>
         <td width=45% align=center class="table_style">产品</td>
         <td width=10% align=center class="table_style">会员价格</td>
         <td width=10% align=center class="table_style">订购数量</td>
         <td width=15% align=center class="table_style">总计</td>
         <td width=15% align=center class="table_style">产品状态</td>
        </tr>
   </HeaderTemplate>
   <ItemTemplate>  
        <tr bgcolor="#ffffff">
         <td height=25 align=center class="table_style"><%#GetXuhao()%></td>
         <td class="table_style" align=center>
<a href="<%#Get_DetailUrl(DataBinder.Eval(Container.DataItem,"thetable").ToString(),DataBinder.Eval(Container.DataItem,"detail_id").ToString())%>" target="_blank"><img src="<%#Get_Field(DataBinder.Eval(Container.DataItem,"thetable").ToString(),"titlepic",DataBinder.Eval(Container.DataItem,"detail_id").ToString())%>" border=0 class="pdpic"><%#DataBinder.Eval(Container.DataItem,"title")%></a>
          <%#DataBinder.Eval(Container.DataItem,"color").ToString()==""?"":"<br>颜色："+DataBinder.Eval(Container.DataItem,"color").ToString()%>
          <%#DataBinder.Eval(Container.DataItem,"size").ToString()==""?"":"<br>尺寸："+DataBinder.Eval(Container.DataItem,"size").ToString()%>
          <%#DataBinder.Eval(Container.DataItem,"type").ToString()==""?"":"<br>类型："+DataBinder.Eval(Container.DataItem,"type").ToString()%>
       </td>
         <td class="table_style"  align=center><asp:Label Id="MPrice" Text='<%#DataBinder.Eval(Container.DataItem,"member_price")%>' runat="server" /></td>
         <td class="table_style"  align=center><%#DataBinder.Eval(Container.DataItem,"num")%></td>
         <td class="table_style"  align=center><%#DataBinder.Eval(Container.DataItem,"tongji")%></td>
         <td class="table_style"  align=center><%#Get_State((DataBinder.Eval(Container.DataItem,"state")).ToString())%></td>
        </tr>
      </ItemTemplate> 

</asp:Repeater>
      <tr>
         <td height=20 width=80% class="table_style" colspan="8"><b>产品总价：</b><span style="color:#ff0000;font-weight:bold">￥<asp:Label Id="LblPdtongji" runat="server"/></span></td>
       </tr>
      <tr>
         <td height=20 width=80% class="table_style" colspan="8"><b>配送费用：</b><span style="color:#ff0000;font-weight:bold">￥<asp:Label Id="LblSendExpense" runat="server"/></span> (<asp:Label Id="LblSendWay" runat="server"/>)</td>
       </tr>
      <tr>
         <td height=20 width=80% class="table_style" colspan="8"><b>总计：</b><span style="color:#ff0000;font-weight:bold">￥<asp:Label Id="LblTongji" runat="server"/></span></td>
       </tr>
</table>
<br>
<table border=0 cellpadding=5 cellspacing=1 width=95% align=center bgcolor=#cccccc>
      <tr>
         <td height=20 bgcolor=#eeeeee colspan=2 align=center>收货人信息</td>
       </tr>
        <tr>
         <td height=20 bgcolor=#eeeeee width=120>会员帐户：</td><td bgcolor=#ffffff><asp:Label id="TheMember" runat="server" /></td>
       </tr>
      <tr>
         <td height=20 bgcolor=#eeeeee width=120>联系人姓名：</td><td bgcolor=#ffffff><asp:Label id="LbName" runat="server" /></td>
       </tr>
      <tr>
         <td height=20 bgcolor=#eeeeee>联系人电话：</td><td bgcolor=#ffffff><asp:Label id="LbTel" runat="server" /></td>
       </tr>
     <!--
      <tr>
         <td height=20 bgcolor=#eeeeee>省份：</td><td bgcolor=#ffffff><asp:Label id="LbProvince" runat="server" /></td>
       </tr>
      <tr>
         <td height=20 bgcolor=#eeeeee>城市：</td><td bgcolor=#ffffff><asp:Label id="LbCity" runat="server" /></td>
       </tr>
     -->
      <tr>
         <td height=20 bgcolor=#eeeeee>电子邮件：</td><td bgcolor=#ffffff><asp:Label id="LbEmail" runat="server" /></td>
       </tr>
      <tr>
         <td height=20 bgcolor=#eeeeee>邮编：</td><td bgcolor=#ffffff><asp:Label id="LbPostcode" runat="server" /></td>
       </tr>
      <tr>
         <td height=20 bgcolor=#eeeeee>详细地址：</td><td bgcolor=#ffffff><asp:Label id="LbAddress" runat="server" /></td>
       </tr>
      <tr>
         <td height=20 bgcolor=#eeeeee>备注：</td><td bgcolor=#ffffff><asp:Label id="Lbbeizhu" runat="server" /></td>
       </tr>
</table>
<br>
<table border=0 cellpadding=5 cellspacing=1 width=95% align=center bgcolor=#cccccc>
      <tr>
         <td height=20 bgcolor=#eeeeee width=120>回复：</td><td bgcolor=#ffffff><asp:Label id="Lbbeizhu1" runat="server" /></td>
       </tr>
</table>
</asp:PlaceHolder>
<br>
<asp:Label id="Lbl_info" runat="server" Text="对不起！没有此定单号。" visible="false"/>
</td>
</tr>
</table>

</body>
</html>