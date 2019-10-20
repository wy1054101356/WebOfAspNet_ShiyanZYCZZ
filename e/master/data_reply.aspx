<% @ Page Language="C#" Inherits="PageAdmin.data_reply"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="data_list"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload()" title="点击刷新"><b>信息回复</b></a></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top  align="left">
<div id="tabdiv">
<ul>
<li id="tab" name="tab" onclick="location.href='data_add.aspx?id=<%=Request.QueryString["detailid"]%>&table=<%=Request.QueryString["table"]%>&name=<%=Server.UrlEncode(Table_Name)%>'">信息详情</li>
<li id="tab" name="tab" style="font-weight:bold">信息回复</li>
</ul>
</div>
<table border=0 cellpadding=0 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
<form runat="server">
<td valign=top>
<table border=0 cellpadding=0 cellspacing=0 width=95% align=center>
<tr>
  <td  colspan=2 height=25><b>当前位置：</b><%=Table_Name%> &gt; 信息回复</td>
 </tr>
</table>

<table border=0 cellpadding="0px" cellspacing="0" width=95% align=center class=tablestyle style="table-layout:fixed;">
      <tr>
         <td height=20 class=white colspan=2 class="tdstyle"><%=Fb_Sort%><%=Fb_Title%></td>
       </tr>
</table>
<table border=0 cellpadding="5px" cellspacing="0" width=95% align=center class=tablestyle style="table-layout:fixed;">
      <tr>
        <td class="tdstyle" style="padding:5px 5px 5px 5px"><div style="overflow-x:auto;padding:5px 5px 5px 5px">
         <%if(string.IsNullOrEmpty(Model_Id)){%><%=Fb_Content%><%}else{%>
<script src="/e/aspx/ajax_list.aspx?modelid=<%=Model_Id%>" type="text/javascript"></script>
<script type="text/javascript">
var ajaxparameter_<%=Model_Id%>="id=<%=Request.QueryString["detailid"]%>"
rajax_<%=Model_Id%>(1);
</script>
<%}%>
        </div>
          <div align=right style="color:#666666">发布时间：<%=Fb_Date%>&nbsp; <asp:Label id="Username" runat="server" /><asp:Label id="Lb_Email" runat="server" Visible="false"/>&nbsp; <a href=#>[<%=Fb_State%>]</a>&nbsp;<asp:LinkButton runat="server" id="Lbt_Over" onCommand="Feedback_Over">[结贴]</asp:LinkButton>
     </div>
  </td>
      </tr>
</table>

<br>

<asp:Repeater id="P1" runat="server"  OnItemDataBound="P1_Bind">
     <ItemTemplate>
     <table border=0 cellpadding=0 cellspacing=0 width=95% align=center class="tablestyle" style="table-layout:fixed;">
      <tr>
        <td align=left width="100px" class="tdstyle"><a href="member_info.aspx?username=<%#Server.UrlEncode(DataBinder.Eval(Container.DataItem,"username").ToString())%>"><%#DataBinder.Eval(Container.DataItem,"username")%></a></td>
        <td class="tdstyle">
           <div style="overflow-x:auto;padding:5px 5px 5px 5px"><%#DataBinder.Eval(Container.DataItem,"reply").ToString()%><br></div>
           <div align=right  style="color:#666666"><%#DataBinder.Eval(Container.DataItem,"username")%>(姓名：<%#DataBinder.Eval(Container.DataItem,"truename")%> 部门：<%#DataBinder.Eval(Container.DataItem,"department")%>) 回复时间：<%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd HH:mm:ss}")%>&nbsp;
[<asp:LinkButton runat="server"  CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' onCommand="Reply_Edit">修改</asp:LinkButton>]
[<asp:LinkButton runat="server" CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' id="Delete" onCommand="Reply_Delete">删除</asp:LinkButton>]
</div>
        </td>
      </tr>
     </table><br>
     </ItemTemplate>
</asp:Repeater>

<table border=0 cellpadding=5px cellspacing=0 width=95% align=center class="tablestyle" style="table-layout:fixed;">

      <tr>
        <td align=left width="100px" class="tdstyle">转办用户</td>
        <td align=left class="tdstyle" style="text-indent:0;padding:5px">
         <asp:TextBox id="Tranform_UserName" size="20" Runat="server" />[<a href="javascript:void(0)" onclick="Member_Select('选择用户',0,1,0,'Tranform_UserName',true,350,400)">选择用户</a>]
         <asp:CheckBox id="C_State" Text="是否继续处理" Runat="server" Checked/> <asp:Button Text=" 转发 " Cssclass="button" Runat="server" onclick="Data_Tranform"/>
          <asp:Label id="Lb_err" Runat="server" ForeColor="#ff0000"/> <asp:Label id="Lb_zb" Runat="server"/><asp:Label id="Lb_Reply_UserName" Runat="server" Visible="false"/>
       </td>
      </tr>

      <tr>
        <td  align=left class="tdstyle">回复：</td>
        <td  align=left class="tdstyle" style="text-indent:0;padding:5px">
<asp:TextBox id="Reply" TextMode="MultiLine" runat="server" style="width:100%;height:200px"/>
<script charset="utf-8" src="/e/incs/kindeditor/kindeditor.js"></script>
<script type="text/javascript">
        var editor;
        KindEditor.ready(function(K) {
                editor = K.create('#Reply',
                    {
                      uploadJson :kindeditor_uploadJson,
                      fileManagerJson :kindeditor_fileManagerJson,
                      allowFileManager :false,
                      items :kindeditor_SimpleItems,
                      newlineTag:"p",
                      filterMode:false
                    }
                );
        });
</script>
</td>
      </tr>
</table>

<table border=0 cellpadding=5 cellspacing=1 width=95% align=center>
      <tr>
        <td height=25  align=center>
           <input type="checkbox" value="1" name="sendmail" id="sendmail" checked>同时邮件回复
           <asp:Label id="Lb_id" runat="server" Visible="false"/>
           <asp:Label id="Lb_siteid" runat="server" Visible="false"/>
          <asp:Button Text=" 修改 " Cssclass="button" Runat="server" id="Bt_Update" onclick="Data_Update" onclientclick="return ck()" Visible="false" />
          <asp:Button Text=" 取消 " Cssclass="button" Runat="server" id="Bt_Cancel" onclick="Data_Cancel" Visible="false" />
          <asp:Button Text=" 提交 " Cssclass="button" Runat="server" id="Bt_Add"  onclick="Data_Add" onclientclick="return ck()"  Visible="true"/>
          <input type="button"  value="返回"  class="button" onclick="location.href='data_list.aspx?table=<%=Request.QueryString["table"]%>&name=<%=Server.UrlEncode(Request.QueryString["name"])%>'">
       </td>
     </tr>
</table>
</td>
</tr>
</form>
</table>
<br>
</center>
<script type="text/javascript">
function ck()
 {
   if(editor.count("text")==0)
    {
      alert("内容不能留空!");
      editor.focus();
      return false;
    }
    editor.sync();
    return true;
 }
</script>
</body>
</html> 