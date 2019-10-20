<% @ Page Language="C#" Inherits="PageAdmin.link_item"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" />  
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>链接内容设置</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">

<form runat="server" >
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">

<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr>
  <td  colspan=2 height=25><b><%=Request.QueryString["name"]%></b></td>
 </tr>
</table>

    <table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
      <tr>
        <td  colspan=2 height=25>
          <asp:DataList id="DL_1" runat="server" border=0 RepeatLayout="Table" width=100% cellspacing=0 cellpadding=0 OnItemDataBound="Data_Bound" OnDeleteCommand="Data_Delete">
             <HeaderTemplate>
                 <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle >
                <tr>
                  <td align=center width=20% class=white height=20px>名称</td>
                  <td align=center width=30% class=white>链接地址</td>
                  <td align=center width=30% class=white>图片路径</td>
                  <td align=center width=10% class=white>序号</td>
                  <td align=center width=10% class=white>管理</td>
                </tr>
              </table>
             </HeaderTemplate>            
             <ItemTemplate>
                <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle >
  
                  <td align=center width=20%  class=tdstyle>
                    <asp:TextBox Id="Tb_name" Text='<%#DataBinder.Eval(Container.DataItem,"title")%>' runat="server" size="20" MaxLength="50"/>
                   </td>

                   <td align=center width=30%  class=tdstyle>
                    <asp:TextBox Id="Tb_url" Text='<%#DataBinder.Eval(Container.DataItem,"url")%>' runat="server" size="25" MaxLength="150"/>
                   </td>

                  <td align=center width=30%  class=tdstyle>
                    <asp:TextBox Id="Tb_image" Text='<%#DataBinder.Eval(Container.DataItem,"image")%>' runat="server" size="25" MaxLength="150"/>
                   </td>
                  <td align=center width=10%  class=tdstyle>
                    <asp:TextBox Id="Tb_xuhao" Text='<%#DataBinder.Eval(Container.DataItem,"xuhao")%>' runat="server" size="2" MaxLength="5"/>
                   </td>
                  <td align=center width=10% class=tdstyle>
                   <asp:Label id="Lb_id" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' runat="server" visible="false"/>
                   <asp:LinkButton id="Delete" runat="server" Text="删除" CommandName="Delete" />
                  </td>
                </tr>
              </table>
             </ItemTemplate>
         </asp:DataList>
       </td>
    </tr>
   </table>
    <br>
  <div align="center">
<asp:Button text="更新" Onclick="Data_Update"  CssClass="button" runat="server" />
<input type="button" value=" 返回 " onclick="location.href='link_list.aspx'" class="button" />
</div>
  </td>
  <tr>
 </table>
<br>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
    <table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
    <tr><td height=25><b>增加链接</b></td>
    </tr>
      <tr>
        <td height=25>
                      名称：<asp:TextBox id="Add_name" maxlength="45" size="15" runat="server" />
                      链接地址：<asp:TextBox   id="Add_url" Text="http://" maxlength="150" size="20" runat="server" />
                      图片路径：<asp:TextBox  id="Add_image" maxlength="150" size="20" runat="server" />
                      序号：<asp:TextBox  id="Add_xuhao" Text="0" maxlength=5 size=2 runat="server" />
                      <asp:button  CssClass="button"  Text="增加" runat="server" OnClick="Data_Add" />
        </td>
    </tr>
   </table>
</td>
</tr>
</table>
<br>
<asp:Label id="LblErr" runat="server" />

</form>

</td>
</tr>
</table>
</center>
</body>
</html>  



