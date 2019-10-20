<% @ Page Language="C#" Inherits="PageAdmin.order_info"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="bs_order" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload()" title="点击刷新"><b>订单查看</b></a></td></tr>
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
  <td  width=50% height=25><b>订单查看</b></td>
  <td width=50%  height=25 align=right></td>
 </tr>
</table>
  <table border=0 cellpadding=0 cellspacing=0 width=95% align=center>
    <tr>
      <td height=25 width=20%>No：</span><asp:Label id="Lblorderid" runat="server"/></span></td>
     <td height=25 width=60% align=center style="font-size:16;font-weight:bold;text-decoration:underline">订 购 单</td>
      <td height=25 width=20% align=right><span style="font-size:13">订单日期：<asp:Label id="Thedate" runat="server" /></td>
    </tr>
  </table>
   <table border=0 cellpadding=5 cellspacing=0 width=95% align=center>
    <tr>
      <td height=25 width=70%>

订单确认：
<asp:DropDownList id="SendState" runat="server">
<asp:ListItem value="0">待确认</asp:ListItem>
<asp:ListItem value="1">已确认(不减去库存)</asp:ListItem>
<asp:ListItem value="2">已发货(同时减去库存)</asp:ListItem>
</asp:DropDownList>
<asp:Button Text=" 确定 " runat="server" CssClass="button" Onclick="Confirm_Order" onclientclick="return setstate()"/>&nbsp; 
<asp:TextBox id="ChargeName" runat="server" Size="15" Enabled="false" Visible="false"/>
</td>
     <td height=25 width=30% align=center></td>

    </tr>
  </table>
    <table border=0 cellpadding=0 cellspacing=0 width=95% align=center class=tablestyle >
      <tr>
         <td width=40% height=20px align=center class=white>产品</td>
         <td width=10% align=center class=white>订购数量</td>
         <td width=10% align=center class=white>赠送积分</td>
         <td width=10% align=center class=white>会员价</td>
         <td width=15% align=center class=white>总计</td>
         <td width=15% align=center class=white>销售状态</td>
        </tr>
<asp:Repeater id="DL_1" runat="server" OnItemDataBound="Data_Bound">
   <ItemTemplate>  
        <tr bgcolor="#ffffff">
         <td class=tdstyle>
          <a href="<%#Get_DetailUrl(DataBinder.Eval(Container.DataItem,"thetable").ToString(),DataBinder.Eval(Container.DataItem,"detail_id").ToString())%>" target=_blank><%#DataBinder.Eval(Container.DataItem,"title")%></a>
          <%#DataBinder.Eval(Container.DataItem,"color").ToString()==""?"":"<br>颜色："+DataBinder.Eval(Container.DataItem,"color").ToString()%>
          <%#DataBinder.Eval(Container.DataItem,"size").ToString()==""?"":"<br>尺寸："+DataBinder.Eval(Container.DataItem,"size").ToString()%>
          <%#DataBinder.Eval(Container.DataItem,"type").ToString()==""?"":"<br>类型："+DataBinder.Eval(Container.DataItem,"type").ToString()%>
          </td>

         <td align=center class=tdstyle><asp:Label Id="Lbnumber" Text='<%#DataBinder.Eval(Container.DataItem,"num")%>' runat="server" /></td>
         <td align=center class=tdstyle><%#DataBinder.Eval(Container.DataItem,"point_tongji")%></td>
         <td align=center class=tdstyle>￥<asp:TextBox Id="MPrice" Text='<%#DataBinder.Eval(Container.DataItem,"member_price")%>' runat="server" size="5" /></td>
         <td align=center class=tdstyle>￥<%#DataBinder.Eval(Container.DataItem,"tongji")%></td>
         <td align=center class=tdstyle>
<asp:Label Id="Lb_id" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' runat="server" visible="false" />
<asp:Label Id="Lb_state" Text='<%#DataBinder.Eval(Container.DataItem,"state")%>' runat="server" visible="false" />
<asp:Label Id="Lb_thetable" Text='<%#DataBinder.Eval(Container.DataItem,"thetable")%>' runat="server" visible="false" />
<asp:Label Id="Lb_detailid" Text='<%#DataBinder.Eval(Container.DataItem,"detail_id")%>' runat="server" visible="false" />
<asp:DropDownList id="PdState" runat="server">
<asp:ListItem value="1">正常销售</asp:ListItem>
<asp:ListItem value="-1">停售</asp:ListItem>
</asp:DropDownList>
        </td>
      </tr>
      </ItemTemplate> 
      </asp:Repeater>

      <tr>
         <td height=30 class=tdstyle colspan="7">产品总价：<span  style="color:#ff0000">￥<asp:Label Id="ProdTongji" runat="server"/></span> &nbsp;&nbsp; 赠送总积分为：<span  style="color:#ff0000"><%=AllPoint%></span></td>
       </tr>
      <tr>
         <td height=30 class=tdstyle colspan="7">配送费用：￥<asp:TextBox Id="SendExpense" runat="server" size="5" /> &nbsp;配送方式：<asp:TextBox Id="Tb_SendWay" runat="server" size="25" Maxlength="50" /></td>
       </tr>
      <tr>
         <td height=30 class=tdstyle colspan="7">总费用：<span  style="color:#ff0000">￥<asp:Label Id="LblTongji" runat="server"/></span></td>
       </tr>
      <tr>
         <td height=30 class=tdstyle colspan="7">付款状态：<asp:DropDownList id="PayState" runat="server">
<asp:ListItem value="0">未付款</asp:ListItem>
<asp:ListItem value="1">已付款</asp:ListItem>
</asp:DropDownList></td>
       </tr>
</table>
<br>
<table border=0 cellpadding=0 cellspacing=0 width=95% align=center  class=tablestyle>
      <tr>
         <td height=20 class=white colspan=2 align=center>订购人信息</td>
       </tr>
      <tr>
         <td height=20  width=120 class=tdstyle>会员号：</td><td class=tdstyle><a href='member_info.aspx?username=<%=UserName%>'><%=UserName%></a><%=Anonymous==""?"":"非会员"%></td>
       </tr>
      <tr>
         <td height=20  width=120 class=tdstyle>联系人姓名：</td><td class=tdstyle><asp:Label id="LbName" runat="server" /></td>
       </tr>
      <tr>
         <td height=20 class=tdstyle>E-mail：</td><td class=tdstyle><asp:Label id="LbEmail" runat="server" /></td>
       </tr>
      <tr>
         <td height=20 class=tdstyle>联系人电话：</td><td class=tdstyle><asp:Label id="LbTel" runat="server" /></td>
       </tr>
      <tr>
         <td height=20 class=tdstyle>详细地址：</td><td class=tdstyle><asp:Label id="LbAddress" runat="server" /></td>
       </tr>
      <tr>
         <td height=20 class=tdstyle>邮编：</td><td class=tdstyle><asp:Label id="LbPostcode" runat="server" /></td>
       </tr>
     <!--

      <tr>
         <td height=20 class=tdstyle>省份：</td><td class=tdstyle><asp:Label id="LbProvince" runat="server" /></td>
       </tr>
      <tr>
         <td height=20 class=tdstyle>城市：</td><td class=tdstyle><asp:Label id="LbCity" runat="server" /></td>
       </tr>
      <tr>
         <td height=20 class=tdstyle>传真：</td><td class=tdstyle><asp:Label id="LbFax"  runat="server" /></td>
       </tr>
     -->
      <tr>
         <td height=20 class=tdstyle>QQ：</td><td class=tdstyle><asp:Label id="Lbqq"  runat="server" /></td>
       </tr>
      <tr>
         <td height=20 class=tdstyle>备注：</td><td class=tdstyle><asp:Label id="LbBizhu"  runat="server" /></td>
       </tr>
      <tr>
         <td height=20 class=tdstyle>回复：</td><td class=tdstyle><asp:TextBox id="LbBizhu1" TextMode="multiline" Columns="60" rows="4"  runat="server" /></td>
       </tr>
</table>
<br>
<div align=center>
<asp:Button Text=" 更新 " runat="server" CssClass="button" Onclick="Update_Info" />&nbsp; 
<input type="button" class="button"  value=" 返回 "  onclick="location.href='order_list.aspx?username=<%=Server.UrlEncode(Request.QueryString["username"])%>'">
</div>
</td>
</tr>
</table>

</form>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
var current_state=parseInt(document.getElementById("SendState").value);
function setstate()
 {
    var now_state=parseInt(document.getElementById("SendState").value);
    if(now_state==0)
       {
         alert("请选择状态!");
         return false;
       }
    return true;
 }
</script>
</body>
</html>  