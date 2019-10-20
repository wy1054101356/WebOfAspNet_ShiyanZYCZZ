<% @ Page Language="C#" Inherits="PageAdmin.vote_quesion"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="js_vote"/>
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b><%=Request.QueryString["title"]%></b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">

<form runat="server" >
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>

<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr>
  <td  colspan=2 height=25><b>当前位置：</b>问卷管理 &gt; 问卷问题设置</td>
 </tr>
</table>

    <table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
      <tr>
        <td height=25>  
             <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle >
               <tr>
                <td bgcolor=#ffffff>
                 <asp:DataList id="List" runat="server" border=0 RepeatLayout="Table" width=100% cellspacing=0 cellpadding=0
                   OnItemDataBound="Data_Bound"  OnDeleteCommand="Data_Delete"> 
                    <HeaderTemplate> 
                      <table border=0 cellpadding=0 cellspacing=1 width=100% class=tablestyle >
                      <tr>
                      <td align=center width=50% class=white height=20>问题</td>
                      <td align=center width=20% class=white>类型</td>
                      <td align=center width=10% class=white>序号</td>
                      <td align=center width=20% class=white>管理</td>
                    </tr>
                   </table>
                    </HeaderTemplate> 
                    <ItemTemplate>

                   <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle >
                      <tr>
                      <td width=50% class=tdstyle  height=20> <asp:TextBox id="tb_quesion" runat="server" size="50" maxlength="60" Text='<%#DataBinder.Eval(Container.DataItem,"quesion")%>'/></td>
                      <td align=center width=20% class=tdstyle>
                     <asp:DropDownList id="DL_Type" runat="server" >
                       <asp:listItem value="single">单选</asp:ListItem>
                       <asp:listItem value="multiple">多选</asp:ListItem>
                     </asp:DropDownList>
                      </td>
        
                      <td align=center width=10% class=tdstyle><asp:TextBox id="tb_xuhao" runat="server" size="3" maxlength="5" Text='<%#DataBinder.Eval(Container.DataItem,"xuhao")%>'/></td>
 
                      <td align=left width=20% class=tdstyle>
                         <asp:Label id="Lb_id"  runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' Visible="false" />
                         <asp:Label id="Lb_type"  runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"thetype")%>' Visible="false" />
                         <a href="javascript:Choice(<%#DataBinder.Eval(Container.DataItem,"vote_id")%>,<%#DataBinder.Eval(Container.DataItem,"id")%>,'<%#Server.UrlEncode(DataBinder.Eval(Container.DataItem,"quesion").ToString())%>')">选项设置</a>
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
<div align=center>
<asp:Button  runat="server" Text="修改"  CssClass="button" OnClick="Data_Update" />
&nbsp;&nbsp;<input type="button" value="返回" Class="button" onclick="location.href='vote_list.aspx'">
</div>
  </td>
  <tr>
 </table>
<br>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center class=table_style2>
<tr>
  <td valign=top>
    <table border=0 cellpadding=0 cellspacing=2 width=100% align=center>
    <tr><td  colspan=3 height=25><b>增加问题</b></td>
    </tr>
      <tr>
        <td  height=25 align="left">
问题：<asp:TextBox  id="Add_quesion"  maxlength="100" size="40"  runat="server" />
类型：<asp:DropDownList id="Add_Type" runat="server">
                     <asp:listItem value="single">单选</asp:ListItem>
                     <asp:listItem value="multiple">多选</asp:ListItem>
       </asp:DropDownList> 

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
<script type="text/javascript">
function Choice(Voteid,Id,Quesion)
 {
  var Width=700;
  var Height=400;
  IDialog("问卷选项管理","vote_choice.aspx?voteid="+Voteid+"&id="+Id+"&Quesion="+escape(Quesion),Width,Height,'auto');
 }
</script>
</body>
</html>  



