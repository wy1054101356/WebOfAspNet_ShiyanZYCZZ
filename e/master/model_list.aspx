<% @ Page Language="C#" Inherits="PageAdmin.model_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="zdytable_list" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>模型管理</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">

<form runat="server">
<div id="tabdiv">
<ul>
<li id="tab" name="tab" onclick="location.href='?type=nav&table=<%=Request.QueryString["table"]%>&tablename=<%=Server.UrlEncode(Request.QueryString["tablename"])%>'">导航模型</li>
<li id="tab" name="tab" onclick="location.href='?type=module&table=<%=Request.QueryString["table"]%>&tablename=<%=Server.UrlEncode(Request.QueryString["tablename"])%>'">模块模型</li>
<li id="tab" name="tab" onclick="location.href='?type=sublanmu&table=<%=Request.QueryString["table"]%>&tablename=<%=Server.UrlEncode(Request.QueryString["tablename"])%>'">子栏目模型</li>
<li id="tab" name="tab" onclick="location.href='?type=detail&table=<%=Request.QueryString["table"]%>&tablename=<%=Server.UrlEncode(Request.QueryString["tablename"])%>'">内容页模型</li>
<li id="tab" name="tab" onclick="location.href='?type=search&table=<%=Request.QueryString["table"]%>&tablename=<%=Server.UrlEncode(Request.QueryString["tablename"])%>'">搜索模型</li>
<li id="tab" name="tab" onclick="location.href='?type=ajax&table=<%=Request.QueryString["table"]%>&tablename=<%=Server.UrlEncode(Request.QueryString["tablename"])%>'">ajax列表模型</li>
<li id="tab" name="tab" onclick="location.href='?type=custom&table=<%=Request.QueryString["table"]%>&tablename=<%=Server.UrlEncode(Request.QueryString["tablename"])%>'">自定义文件模型</li>
</ul>
</div>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">

<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr>
  <td height=25><b>当前表</b>：<%=Request.QueryString["tablename"]%></td>
  <td height=25 align="right">根据语种显示：<asp:DropDownList id="D_Language" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ChanggeLanguage"><asp:ListItem value="">所有模型</asp:ListItem></asp:DropDownList></td>
 </tr>

</table>
    <table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
      <tr>
        <td  colspan=2 height=25>  

            <asp:DataList id="DataList_1" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal"
                   OnItemDataBound="Data_Bound"  OnDeleteCommand="Data_Delete"> 
                    <HeaderTemplate> 
                      <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle id="tb_tblist">
                      <tr>
                      <td align=center width=10% class=white height=20>模型id</td>
                      <td align=center width=30% class=white>模型名称</td>
                      <td align=center width=10% class=white>模型语种</td>
                      <td align=center width=20% class=white>序号</td>
                     <%if(Request.QueryString["type"]!="ajax" && Request.QueryString["type"]!="custom"){%>
                      <td align=center width=10% class=white>状态</td><%}%>
                      <td align=center  class=white>操作</td>
                    </tr>
                    </HeaderTemplate> 
                    <ItemTemplate>
                       <tr class="listitem">
                        <td align=center class=tdstyle><asp:TextBox Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' runat="server" size="2" readonly/></a></td>
                        <td align=center class=tdstyle><asp:TextBox id="Tb_Name" Text='<%#DataBinder.Eval(Container.DataItem,"name")%>' runat="server" size="40" maxlength="50" /></a></td>
                        <td align=center class=tdstyle><asp:DropDownList id="D_Language" runat="server" /></td>
                        <td align=center class=tdstyle><asp:TextBox id="Xuhao"  Text='<%#DataBinder.Eval(Container.DataItem,"xuhao")%>' runat="server"  size=5  maxlength=10 /></td> <%if(Request.QueryString["type"]!="ajax" && Request.QueryString["type"]!="custom"){%>
                        <td align=center class=tdstyle><%#DataBinder.Eval(Container.DataItem,"show").ToString()=="1"?"可调用":"<span style='color:#ff0000'>已停用</span>"%></td><%}%>
                        <td class=tdstyle align=center> <%if(Request.QueryString["type"]!="ajax" && Request.QueryString["type"]!="custom"){%>
<asp:Button id="State" Text='<%#DataBinder.Eval(Container.DataItem,"show").ToString()=="1"?"停用":"启用"%>' runat="server" CommandArgument='<%#DataBinder.Eval(Container.DataItem,"show")%>' CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' OnCommand="Change_State" cssclass='f_bt' /><%}%>
                             <asp:Label id="Id"  Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' runat="server"  visible="false" />
                             <asp:Label id="Lb_language" Text='<%#DataBinder.Eval(Container.DataItem,"language")%>' runat="server"  visible="false" />
                             <a href='javascript:Model_Set("<%#DataBinder.Eval(Container.DataItem,"thetable")%>","<%#DataBinder.Eval(Container.DataItem,"thetype")%>","<%#DataBinder.Eval(Container.DataItem,"name")%>","<%#DataBinder.Eval(Container.DataItem,"id")%>")'>模型设置</a>
                             <asp:LinkButton id="Copy" runat="server" Text="复制" CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' OnCommand="Data_Copy"/>
                             <asp:LinkButton id="Delete" runat="server" Text="删除" CommandName="Delete" />
                        </td>
                      </tr>
                    </ItemTemplate>
                 </asp:DataList>
                 </table>

    </td>
     </tr>
 </table>
<br>
<div align=center>
<asp:Button  runat="server" Text="更新"  CssClass="button" OnClick="Data_Update" />
&nbsp;&nbsp;<input type="button" value="返回" Class="button" OnClick="location.href='table_list.aspx'">
</div>
  </td>
  <tr>
 </table>
<br>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center class=table_style2>
<tr>
  <td valign=top>
    <table border=0 cellpadding=0 cellspacing=2 width=100% align=center>
    <tr><td  colspan=3 height=25><b>增加模型</b></td>
    </tr>
      <tr>
        <td  height=25 align="left">
模型名称：<asp:TextBox  id="Add_Name"  maxlength="100" size="25"  runat="server" />
语种：<asp:DropDownlist id="Add_Language" runat="server"/>

序号：<asp:TextBox id="AddXuhao"  text="1" maxlength=5 size=5 runat="server" />
<asp:Label id="Lb_Table" Runat="server" Visible="false"/>
<asp:Label id="Lb_Type" Runat="server" Visible="false"/>
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
<script type="text/javascript">
 MouseoverColor("tb_tblist");
 function Load_Tab(num)
  {
    var Obj1=document.getElementsByName("tab");
    var k=0;
     for(k=0;k<Obj1.length;k++)
      {
       Obj1[k].style.fontWeight="normal";
      }
     Obj1[num].style.fontWeight="bold";
  }

var thetype="<%=Request.QueryString["type"]%>";
switch(thetype)
 {
   case "nav":
    Load_Tab(0);
   break;

   case "module":
    Load_Tab(1);
   break;

   case "sublanmu":
    Load_Tab(2);
   break;

   case "detail":
    Load_Tab(3);
   break;

   case "search":
    Load_Tab(4);
   break;

   case "ajax":
    Load_Tab(5);
   break;

   case "custom":
    Load_Tab(6);
   break;

   default:
    Load_Tab(2);
   break;
 }

function Model_Set(Table,Type,Name,Id)
 {
  IDialog("模型制作","model_set.aspx?table="+Table+"&id="+Id+"&type="+Type+"&Name="+encodeURI(Name),"96%","90%");
 }
</script>
</body>
</html>  