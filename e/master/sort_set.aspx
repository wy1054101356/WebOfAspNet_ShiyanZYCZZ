<% @ Page Language="C#" Inherits="PageAdmin.sort_set"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table border=0 cellpadding=5 cellspacing=0 width=98%>
 <tr>
<td valign=top align="left">
<iframe name="post_iframe" id="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form method="post" action="sort_set.aspx?id=<%=Request.QueryString["id"]%>&name=<%=Server.UrlEncode(SortName)%>" target="post_iframe">
<table border=0 cellpadding=2 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
  <table border=0 cellpadding=2 cellspacing=0 width=98% align=center>
    <tr>
     <td height=20px><b><%=SortName%></b></td>
   </tr>
   </table>

   <table border=0 cellpadding=2 cellspacing=0 width=98% align=center>
     <tr> <td height=20px width="120px"><input type="checkbox" name="add_check_set" value="1" style="display:<%=posttype=="p_update"?"":"none"%>">新增信息审核</td>
       <td>
       <select id="add_check" name="add_check">
        <option value="-1">默认</option>
        <option value="0">无需审核</option>
        <option value="1">需审核</option>
       </select> <span style="color:#999">此设置优先于会员类别和部门设置</span>
      </td>
     </tr>

     <tr><td height=20px width="120px"><input type="checkbox" name="edit_check_set value="1" style="display:<%=posttype=="p_update"?"":"none"%>">修改信息审核</td>
       <td>
       <select id="edit_check" name="edit_check">
        <option value="-1">默认</option>
        <option value="0">无需审核</option>
        <option value="1">需审核</option>
       </select> <span style="color:#999">此设置优先于会员类别和部门设置</span>
      </td>
     </tr>

     <tr>
       <td height=20px width="120px"><input type="checkbox" name="work_id_set" value="1" style="display:<%=posttype=="p_update"?"":"none"%>">审核工作流</td>
       <td>
       <select id="work_id" name="work_id">
        <option value="-1">默认</option>
        <option value="0">不采用工作流</option>
        <%=Works_Option%>
       </select> <span style="color:#999">此设置优先于会员类别和部门设置</span>
      </td>
     </tr>

   <tr>
     <td align=left height=20px><input type="checkbox" name="tg_visiter_set" value="1" style="display:<%=posttype=="p_update"?"":"none"%>">默认访问权限</td>
     <td>
       <select id="permissions" name="permissions" size="10" multiple style="width:200px">
        <option value="0">所有人可访问</option>
        <%=Mtype_Option%>
       </select> <span style="color:#999">可以按住Ctrl键多选</span>
      </td>
    </tr>

    <tr>
      <td height=20px><input type="checkbox" name="comment_open_set" value="1" style="display:<%=posttype=="p_update"?"":"none"%>">默认评论功能</td>
      <td><input type="radio" name='comment_open' value="1" checked>开启 <input type="radio" name='comment_open' value="0" <%=comment_open=="0"?"checked":""%>>关闭 &nbsp;评论审核：<input type="checkbox" name='comment_check' id='comment_check_1' value="1" <%=comment_check=="1"?"checked":""%>>需审核&nbsp;<input type="checkbox" name='comment_anonymous' id='comment_anonymous' value="1" <%=comment_anonymous=="1"?"checked":""%>>允许匿名评论
      </td>
    </tr>

     <tr style="display:<%=TableType=="feedback"?"":"none"%>">
       <td height=20px><input type="checkbox" name="reply_username_set" value="1" style="display:<%=posttype=="p_update"?"":"none"%>">指定回复用户</td>
       <td><input name="reply_username" id="reply_username" type="text" maxlength="50" size="12" value="<%=Reply_UserName%>">[<a href="#" onclick="open_departmentuser('text','reply_username','','选择信息回复用户')">选择用户</a>] &nbsp;留言信息预设的回复用户</td>
     </tr>

    <tr>
     <td><input type="checkbox" name="static_dir_set" value="1" style="display:<%=posttype=="p_update"?"":"none"%>">信息保存目录</td><td><input name="static_dir" id="static_dir" type="text" maxlength="40" size="25" value="<%=Static_Dir%>" title="注意目录名只能由字母，数字和下划线组成，留空则默认数据表中的设置"> 特殊字符：{table}/{yyyy}{mm}{dd}分别表示：表/年月日</td>
    </tr>

    <tr style="display:<%=IsFinalSort=="1"?"none":""%>">
       <td height=20px>覆盖子类设置</td>
       <td title="选择后将复制当前设置到对应子类中">
        <input type="checkbox" name='copy_set' id='copy_set' value="1">
      </td>
     </tr>

   <tr>
    <td colspan="2" align="center" height="30px">
<input type="hidden" value="<%=Request.QueryString["id"]%>" name="id">
<input type="hidden" value="<%=IsFinalSort%>" name="FinalSort">
<input type="hidden" value="" name="ids" id="ids">
<input type="hidden" value="<%=posttype%>" name="post">
<input type="hidden" value="<%=TableName%>" name="tablename">

<div align=center style="padding:10px">
<span id="post_area">
<input type="submit" class=button value="提交" onclick="startpost()">
<input type="button" value="关闭" class="button" onclick="parent.CloseDialog()">
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>
</div>

</td>
  </tr>
  </table>
  </td>
  <tr>
 </table>
</form>
</td>
</tr>
</table>
</center>
<script Language="javascript">
document.getElementById("ids").value=parent.document.getElementById("ids").value;
<%if(posttype=="update"){%>
var add_check="<%=Add_Check%>";
var edit_check="<%=Edit_Check%>";
var Work_Id="<%=Work_Id%>";
document.getElementById("add_check").value=add_check;
document.getElementById("edit_check").value=edit_check;
document.getElementById("work_id").value=Work_Id;
var Permissions="<%=Permissions%>";
var APermissions=Permissions.split(',');
var objselect=document.getElementById("permissions");
if(Permissions=="")
{
 objselect[0].selected=true;
}
else
{

for(i=0;i<APermissions.length;i++)
     {
      for(k=0;k<objselect.length;k++)
       {
        if(objselect[k].value==APermissions[i])
         {
          objselect[k].selected=true;
         }
      }
    }
}
<%}%>
</script>
</body>
</html>  
