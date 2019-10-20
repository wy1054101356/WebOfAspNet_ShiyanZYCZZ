<% @ Page Language="C#" Inherits="PageAdmin.feedback_info"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="bs_feedback" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>留言查看</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top  align="left">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
<form runat="server" >
  <td valign=top>
<table border=0 cellpadding=0 cellspacing=0 width=95% align=center>
<tr>
  <td  width=50% height=25><b>留言反馈查看</b></td>
  <td width=50%  height=25 align=right></td>
 </tr>
</table>

<table border=0 cellpadding="0" cellspacing="0" width=95% align=center class=tablestyle style="table-layout:fixed;">
      <tr>
         <td height=20 class=white colspan=2 class="tdstyle">[<%=Fb_Type%>]<%=Fb_Title%></td>
       </tr>
</table>
<table border=0 cellpadding="5px" cellspacing="0" width=95% align=center class=tablestyle style="table-layout:fixed;">
       <tr> 
         <td  class="tdstyle" height=20 align=left width="100px">联系资料：</td>
         <td  class="tdstyle">
         联系人：<%=Fb_Name%> &nbsp;&nbsp;
         电话：<%=Fb_Tel%> &nbsp;&nbsp;
         Email：<asp:Label id="Lb_Email" runat="server"/>
        </td>
       </tr>
      <tr>
        <td  class="tdstyle" align=left><asp:Label id="Username" runat="server" /></td>
        <td class="tdstyle" style="padding:5px 5px 5px 5px"><div style="overflow-x:auto;padding:5px 5px 5px 5px"><%=Fb_Content%><br></div>
          <div align=right>[<%=Fb_State%>]&nbsp;<asp:LinkButton runat="server" id="Lbt_Over" onCommand="Feedback_Over" >[结贴]</asp:LinkButton>&nbsp; 发布时间：<%=Fb_Date%>&nbsp;</div></td>
      </tr>
</table>

<br>

<asp:Repeater id="P1" runat="server"  OnItemDataBound="P1_Bind">
     <ItemTemplate>
     <table border=0 cellpadding=0 cellspacing=0 width=95% align=center class="tablestyle" style="table-layout:fixed;">
      <tr>
        <td align=left width="100px" class="tdstyle"><%#GetDepartMent(DataBinder.Eval(Container.DataItem,"username").ToString(),DataBinder.Eval(Container.DataItem,"department").ToString())%></td>
        <td class="tdstyle">
           <div style="overflow-x:auto;padding:5px 5px 5px 5px"><%#DataBinder.Eval(Container.DataItem,"reply").ToString()%><br></div>
           <div align=right>
<asp:LinkButton runat="server"  CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' onCommand="Reply_Edit" >[修改]</asp:LinkButton>&nbsp;
<asp:LinkButton runat="server" CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' id="Delete" onCommand="Reply_Delete" >[删除]</asp:LinkButton>&nbsp;
发布时间：<%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd HH:mm:ss}")%>&nbsp;</div>
        </td>
      </tr>
     </table><br>
     </ItemTemplate>
</asp:Repeater>

<table border=0 cellpadding=5px cellspacing=0 width=95% align=center class="tablestyle" style="table-layout:fixed;"  >
      <tr>
        <td  align=left width="100px" class="tdstyle">回复：</td>
        <td  align=left class="tdstyle" style="text-indent:0;padding:5px">
<asp:TextBox id="Reply" TextMode="MultiLine" runat="server" style="width:100%;height:200px"/><asp:Label id="Lbl_id" runat="server" Visible="false"/>
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
          <input type="checkbox" value="1" name="sendmail" id="sendmail" checked>同时发送邮件
          <asp:Button Text=" 修改 " Cssclass="button" Runat="server" id="Bt_Update" onclick="Data_Update" onclientclick="return ck()" Visible="false" />
          <asp:Button Text=" 取消 " Cssclass="button" Runat="server" id="Bt_Cancel" onclick="Data_Cancel" Visible="false" />
          <asp:Button Text=" 提交 " Cssclass="button" Runat="server" id="Bt_Add"  onclick="Data_Add" onclientclick="return ck()"  Visible="true"/>
          <input type="button"    value="返回"     class="button" onclick="location.href='feedback_list.aspx?username=<%=Server.UrlEncode(Request.QueryString["username"])%>&type=<%=Request.QueryString["type"]%>'"/>
       </td>
     </tr>
</table>

</td>
</tr>
</form>
</table>
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
</center>
</body>
</html> 