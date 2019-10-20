<% @ Page Language="C#" Inherits="PageAdmin.pointcard_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server"  Type="basic_pointcard" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>充值类型管理</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">

<form runat="server" >
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
  <table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
      <tr>
        <td  colspan=2 height=25>
          <asp:Repeater id="List" runat="server" OnItemDataBound="Data_Bound">
             <HeaderTemplate>
               <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle id="tb_list">
                <tr>
                  <td align=center width=20% class=white height=25px>类型名称</td>
                  <td align=center width=15% class=white height=25px>购买费用</td>
                  <td align=center width=15% class=white height=25px>充值点数</td>
                  <td align=center width=30% class=white>说明</td>
                  <td align=center width=10% class=white height=25px>序号</td>
                  <td align=center width=10% class=white>操作</td>
                </tr>
             </HeaderTemplate>            
             <ItemTemplate>
                <tr class="listitem">
                  <td align=center class=tdstyle><asp:TextBox id="Tb_name" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"name")%>' maxlength="50" size="15"/></td>
                  <td align=center class=tdstyle><asp:TextBox id="Tb_spending" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"spending")%>' maxlength="15" size="5"/></td>
                  <td align=center class=tdstyle><asp:TextBox id="Tb_point" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"point")%>' maxlength="15" size="5"/></td>
                  <td align=center class=tdstyle><asp:TextBox id="Tb_introduct" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"introduct")%>' maxlength="50" size="30"/></td> 
                  <td align=center class=tdstyle><asp:TextBox id="Tb_xuhao" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"xuhao")%>'  maxlength="2" size="3"/></td>
                  <td align=center class=tdstyle>
                   <asp:Label id="Lb_Id" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' Visible="false" />
                   <asp:LinkButton id="Delete" runat="server" Text="删除" CommandName='<%#DataBinder.Eval(Container.DataItem,"name")%>' CommandArgument='<%#DataBinder.Eval(Container.DataItem,"id")%>' OnCommand="Data_Delete"/>
                  </td>
                </tr>
             </ItemTemplate>
         </asp:Repeater>
         </table>
       </td>
    </tr>
   </table>
   <br><div align="center"><asp:Button Text="更新" Runat="server" Onclick="Data_Update" CssClass="button" /></div>
  </td>
  <tr>
 </table>
<br>
<br>
<table border=0 cellpadding=0 cellspacing=0 width=100% align=center class=table_style2>
<tr>
  <td valign=top>
    <table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
    <tr><td height=25><b>增加充值类型</b></td></tr>
      <tr>
        <td align="left">
类型名称：<asp:TextBox  id="Add_Name"  maxlength="50" size="15"  runat="server" />
购买费用：<asp:TextBox  id="Add_Spending" maxlength="15" size="5"  runat="server" />
充值点数：<asp:TextBox  id="Add_Point"  maxlength="15" size="5"  runat="server" />
说明：<asp:TextBox  id="Add_Introduct" runat="server" maxlength="50" size="20" />
序号：<asp:TextBox id="AddXuhao"  text="0" maxlength=5 size=2 runat="server" />
<asp:button  CssClass="button"  Text="增加" runat="server" OnClick="Data_Add" />
        </td>
    </tr>
   </table>
</td>
</tr>
</table>
<br>
<asp:Label id="LblErr" runat="server" ForeColor="#ff0000" />
</form>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
MouseoverColor("tb_list");
</script>
</body>
</html>