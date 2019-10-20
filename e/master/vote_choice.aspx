<% @ Page Language="C#" Inherits="PageAdmin.vote_choice"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="js_vote"/>
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table border=0 cellpadding=10 cellspacing=0 width=98% >
 <tr>
<td valign=top align="left">
<form runat="server" >
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>

<table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
<tr>
  <td  colspan=2 height=25><b>问题：</b><%=Request.QueryString["quesion"]%></td>
 </tr>
</table>

  <table border=0 cellpadding=0 cellspacing=2 width=98% align=center>
      <tr>
        <td   height=25>  

             <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle >
               <tr>
                <td bgcolor=#ffffff>
                 <asp:DataList id="List" runat="server" border=0 RepeatLayout="Table" width=100% cellspacing=0 cellpadding=0
                   OnItemDataBound="Data_Bound"  OnDeleteCommand="Data_Delete"> 
                    <HeaderTemplate> 
                      <table border=0 cellpadding=0 cellspacing=1 width=100% class=tablestyle >
                      <tr>
                      <td align=center width=60% class=white height=20>选项</td>
                      <td align=center width=15% class=white>票数</td>
                      <td align=center width=15% class=white>序号</td>
                      <td align=center width=20% class=white>管理</td>
                    </tr>
                   </table>
                    </HeaderTemplate> 
                    <ItemTemplate>

                   <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle >
                      <tr>
                      <td width=60% class=tdstyle  height=20> <asp:TextBox id="tb_choice" runat="server" size="50" maxlength="80" Text='<%#DataBinder.Eval(Container.DataItem,"choice")%>'/></td>
                      <td align=center width=15% class=tdstyle><asp:TextBox id="tb_num" runat="server" size="10" maxlength="10" Text='<%#DataBinder.Eval(Container.DataItem,"num")%>'/></td>
        
                      <td align=center width=15% class=tdstyle><asp:TextBox id="tb_xuhao" runat="server" size="3" maxlength="5" Text='<%#DataBinder.Eval(Container.DataItem,"xuhao")%>'/></td>
 
                      <td align=left width=20% class=tdstyle>
                         <asp:Label id="Lb_id"  runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' Visible="false" />
                         <asp:LinkButton  id="Delete" CommandName="Delete" runat="server" Text="删除" />
                      </td>
                    </tr>
                   </table>                  
                    </ItemTemplate>
            </asp:DataList>
       </td>
    </tr>
   </table>
       </td>
    </tr>
   </table>
<br>
<div align=center style="display:<%=ListCount==0?"none":""%>">
<asp:Button  runat="server" Text="修改" CssClass="button" OnClick="Data_Update" />
</div>
  </td>
  <tr>
 </table>
<br>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center class=table_style2>
<tr>
  <td valign=top>
    <table border=0 cellpadding=0 cellspacing=2 width=100% align=center>
    <tr><td  colspan=3 height=25><b>增加选项</b></td>
    </tr>
      <tr>
        <td  height=25 align="left">
选项：<asp:TextBox  id="Add_choice"  maxlength="100" size="40"  runat="server" />
初始票数：<asp:TextBox  id="Add_num"  maxlength="10" size="5"  runat="server" Text="0"/>
序号：<asp:TextBox id="AddXuhao" text="1" maxlength=5 size=5 runat="server" />
<asp:button CssClass="button" Text="增加" runat="server" OnClick="Data_Add" />
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



