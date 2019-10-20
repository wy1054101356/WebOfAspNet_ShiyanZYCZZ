<% @ Page Language="C#" Inherits="PageAdmin.task_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server"  Type="basic_task" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload(true)" title="点击刷新"><b>计划任务管理</b></a></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">

<form runat="server" >
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>

<table border=0 cellpadding=0 cellspacing=0 width=95% align=center>
<tr>
    <td align="right">[<a href='javascript:Task_Dialog("增加新任务","task_add.aspx")'>增加新任务</a>] &nbsp; [<a href="javascript:view_log()">查看运行日志</a>]</td>
 </tr>
</table>

    <table border=0 cellpadding=0 cellspacing=2 width=96% align=center>
      <tr>
        <td  colspan=2 height=25>
               <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle id="tb_list">
                <tr>
                  <td align=center width=30% class=white height=25px>任务名称</td>
                  <td align=center width=10% class=white>是否启用</td>
                  <td align=center width=30% class=white>运行周期</td>
                  <td align=center width=15% class=white>上次运行时间</td>
                  <td align=center width=15% class=white>操作</td>
                </tr>
          <asp:Repeater id="List" runat="server" OnItemDataBound="Data_Bound">            
             <ItemTemplate>
                <tr class="listitem">
                  <td class=tdstyle>[<%#DataBinder.Eval(Container.DataItem,"isloop").ToString()=="1"?"循环任务":"一次性任务"%>]<asp:Label id="lb_name" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"name")%>' /><%#Get_State(DataBinder.Eval(Container.DataItem,"enddate").ToString())%></td>
                  <td align=center class=tdstyle><%#DataBinder.Eval(Container.DataItem,"isopen").ToString()=="1"?"启用中":"关闭"%></td> 
                  <td align=center class=tdstyle><%#Get_Cycle(DataBinder.Eval(Container.DataItem,"do_cycle").ToString(),DataBinder.Eval(Container.DataItem,"do_day").ToString(),DataBinder.Eval(Container.DataItem,"do_week").ToString(),DataBinder.Eval(Container.DataItem,"do_hour").ToString())%></td>
                  <td align=center class=tdstyle><%#Get_DoDate(DataBinder.Eval(Container.DataItem,"prevdate").ToString(),DataBinder.Eval(Container.DataItem,"thedate").ToString())%></td>
                  <td align=center class=tdstyle>
                  <asp:Label id="lb_id" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' visible="false"/>
                  <a href="<%#GetUrl(DataBinder.Eval(Container.DataItem,"fileurl").ToString())%>?<%#DataBinder.Eval(Container.DataItem,"parameter")%>" target="dotask">运行文件</a>
                  <a href="javascript:Task_Dialog('编辑任务','task_add.aspx?id=<%#DataBinder.Eval(Container.DataItem,"id")%>&name=<%#Server.UrlEncode(DataBinder.Eval(Container.DataItem,"name").ToString())%>')">修改</a>
                  <asp:LinkButton runat="server" id="Delete" Text="删除"  CommandArgument='<%#DataBinder.Eval(Container.DataItem,"id")%>' CommandName='<%#DataBinder.Eval(Container.DataItem,"name")%>' oncommand="Data_Delete"/>
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
<span style="display:block;padding-top:3px;"><font color=red>提醒：</font>调试运行文件前请备份好数据，避免误操作导致数据丢失。</span>
</form>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
MouseoverColor("tb_list");
function view_log()
 {
  General_Set("计划任务日志","task_log.aspx?istask=1");
 } 
function Task_Dialog(Title,Url)
 {
  General_Set(Title,Url);
 }
</script>
</body>
</html>  
