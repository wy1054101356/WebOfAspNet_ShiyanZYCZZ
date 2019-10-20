<% @ Page Language="C#" Inherits="PageAdmin.table_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server"  Type="zdytable_list" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload()" title="点击刷新"><b>扩展属性表管理</b></a></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">

<form runat="server" >
<div id="tabdiv">
<ul>
<li id="tab" name="tab" style="font-weight:bold">扩展属性表</li>
<li id="tab" name="tab" onclick="location.href='table_add.aspx?xuhao=<%=ListCounts+1%>'">增加新表</li>
</ul>
</div>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>

<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr>
    <td height=25><b>当前位置</b>：表明细</td>
 </tr>
</table>
    <table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
      <tr>
        <td>
            <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle id="tb_list">
                <tr>
                  <td align=center width=5% class=white height=25px>序号</td>
                  <td align=center width=20% class=white height=25px>表标识</td>
                  <td align=center width=15% class=white height=25px>表名</td>
                  <td align=center width=15% class=white height=25px>表用途</td>
                  <td align=center width=30% class=white>管理</td>
                  <td align=center width=15% class=white>操作</td>
                </tr>
               <asp:Repeater id="DL_1" runat="server" OnItemDataBound="Data_Bound">
               <ItemTemplate>
                <tr class="listitem">
                  <td align=center class=tdstyle><%#DataBinder.Eval(Container.DataItem,"xuhao")%></td>
                  <td align=center class=tdstyle><%#DataBinder.Eval(Container.DataItem,"table_name")%></td>
                  
                  <td align=center class=tdstyle><asp:Label id="Lb_Table" Text='<%#DataBinder.Eval(Container.DataItem,"thetable")%>' runat="server"/></td>
                  <td align=center class=tdstyle><%#GetType(DataBinder.Eval(Container.DataItem,"thetype").ToString())%></td>

                  <td align=center class=tdstyle>
                    <a href="model_list.aspx?type=sublanmu&table=<%#DataBinder.Eval(Container.DataItem,"thetable")%>&tablename=<%#Server.UrlEncode(DataBinder.Eval(Container.DataItem,"table_name").ToString())%>">模型管理</a>
                    <a href="field_list.aspx?table=<%#DataBinder.Eval(Container.DataItem,"thetable")%>&tablename=<%#Server.UrlEncode(DataBinder.Eval(Container.DataItem,"table_name").ToString())%>">字段管理</a>
                    <a href="javascript:get_form('get_form.aspx?table=<%#DataBinder.Eval(Container.DataItem,"thetable")%>&tablename=<%#Server.UrlEncode(DataBinder.Eval(Container.DataItem,"table_name").ToString())%>')">获取表单</a>
                    <asp:Button id="Update" runat="server" Text="更新文件"  cssclass="bt" CommandName='<%#DataBinder.Eval(Container.DataItem,"thetable")%>' oncommand="Update_File"/>
                   </td>
                  <td align=center width=15% class=tdstyle>
                   <a href="table_add.aspx?act=copy&id=<%#DataBinder.Eval(Container.DataItem,"id")%>&xuhao=<%=ListCounts+1%>">复制</a>
                   <a href="table_add.aspx?act=edit&id=<%#DataBinder.Eval(Container.DataItem,"id")%>">修改</a>
                   <asp:LinkButton runat="server" id="Delete" Text="删除"  CommandName='<%#DataBinder.Eval(Container.DataItem,"thetable")%>' oncommand="Data_Delete"/>
                  </td>
                </tr>
             </ItemTemplate>
           </asp:Repeater>
          </table>
       </td>
    </tr>
   </table>
  </td>
  <tr>
 </table>
<br>
说明：点“更新文件”按钮将批量生成所有模型文件和表单文件。
<asp:Label id="LblErr" runat="server" />
</form>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
MouseoverColor("tb_list");
function get_form(url)
 {
  General_Set("表单界面",url);
 }
</script>
</body>
</html>