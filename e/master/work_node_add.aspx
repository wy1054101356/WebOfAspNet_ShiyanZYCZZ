<% @ Page Language="C#" Inherits="PageAdmin.work_node_add"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx"%>
<aspcn:uc_head runat="server" Type="basic_worklist"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95%>
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b><%=Request.QueryString["nodeid"]==null?"新增工作流步骤":"编辑工作流步骤"%></b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=5 cellspacing=0 width=95%>
 <tr>
<td valign=top  align="left">
<iframe name="post_iframe" id="post_iframe"  src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form  method="post" name="f1" target="post_iframe">
<table border=0 cellpadding=2 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
<table border=0 cellpadding=2 cellspacing=2 width=98% align=center>
 </tr>
  <tr>
  <td  height=25 width=100px>步骤名称</td>
  <td><input name="node_name" id="node_name" type="text" maxlength="50" size="30" value="<%=NodeName%>"></td>
 </tr>

  <tr>
  <td height=25 width=100px>操作用户</td>
  <td><input name="work_username" id="work_username" type="text" maxlength="50" size="20"  value="<%=Work_User%>">[<a href="javascript:void(0)" onclick="Member_Select('选择用户',0,1,0,'work_username',true,350,400)">选择用户</a>]
      <input type="checkbox" value="1" name="send_notice" <%=Send_Notice=="1"?"checked":""%>>新任务发出邮件通知
  </td>
  </tr>

  <tr>
  <td height=25 width=100px>相关权限</td>
  <td><input type="checkbox" name="can_edit" id="can_edit" value="1">允许修改 &nbsp;&nbsp;<input type="checkbox" name="can_delete" id="can_delete" value="1">允许删除</td>
  </tr>

  <tr>
  <td height=25 width=100px>步骤描述</td>
  <td><textarea name="node_description" id="node_description" cols="40" rows="3"><%=Description%></textarea></td>
  </tr>

  <tr>
  <td  height=25 width=100px>处理中的状态名</td>
  <td><input name="process_name" id="process_name" type="text" maxlength="20" size="20" value="<%=Process_Name%>"></td>
  </tr>


  <tr>
  <td height=25 width=100px>通过后的状态名</td>
  <td><input name="pass_name" id="pass_name" type="text" maxlength="20" size="20" value="<%=Pass_Name%>">
通过后：<select id="pass_act" name="pass_act">
<option value="next">转到下一步骤</option></select> 注：没有下一步则通过审核
</td>
  </tr>

  <tr>
  <td height=25 width=100px>退回的状态名</td>
  <td><input name="rework_name" id="rework_name" type="text" maxlength="20" size="20" value="<%=Rework_Name%>">
退回到：<select id="rework_node" name="rework_node">
<%=Back_Options%>
<option value="0" <%=Rework_Node=="0"?"selected":""%>>退回发布人</option>
</select>
</td>
  </tr>

  <tr id="tr_recheck_mode">
  <td height=25 width=100px>退回修改重审流程</td>
  <td><select id="recheck_mode" name="recheck_mode">
<option value="0">重走工作流</option>
<option value="1" <%=Recheck_Mode=="1"?"selected":""%>>转到本步骤</option>
</select> <span style="color:#999">说明：退回步骤选择“退回发布人“此设置才有效</span>
</td>
  </tr>

</table>
</td>
</tr>
</table>

<br>
<div align=center>
<input type="hidden" name="Old_Work_User" value="<%=Work_User%>">
<input type="hidden" name="tijiao"  value="yes">
<span id="post_area">
<input type="submit" class=button  id="Bt_Submit" value="提交" onclick="return C_Form()">
<input type="button" class=button  value="关闭"  onclick="closewin()">                 
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>
</div>
</form>
</td>
</tr>
</table>
</center>
</body>
<script type="text/javascript">
 var canedit=document.getElementById("can_edit");
 var candelete=document.getElementById("can_delete");
 var NodeId="<%=Request.QueryString["nodeid"]%>";
 if(NodeId=="")
  {
   document.getElementById("process_name").value="处理中"
   document.getElementById("rework_name").value="被退回"
   document.getElementById("pass_name").value="通过审核"
  }
 else
  {
   if("<%=Can_Edit%>"=="1")
    {
     canedit.checked=true;
    }
   if("<%=Can_Delete%>"=="1")
    {
     candelete.checked=true;
    }
  }

 function C_Form()
  {
     var obj=document.getElementById("node_name");
     if(obj.value=="")
     {
       alert("请填写步骤名称!");
       obj.focus();
       return false;
     }

     obj=document.getElementById("work_username");
     if(obj.value=="")
     {
       alert("请填写指定的工作人员!");
       obj.focus();
       return false;
     }

     obj=document.getElementById("process_name");
     if(obj.value=="")
     {
       alert("请填写处理中的状态名!");
       obj.focus();
       return false;
     }

     obj=document.getElementById("rework_name");
     if(obj.value=="")
     {
       alert("请填写退回的状态名!");
       obj.focus();
       return false;
     }

     obj=document.getElementById("pass_name");
     if(obj.value=="")
     {
       alert("请填写通过后的状态名!");
       obj.focus();
       return false;
     }
   startpost();
  }

var closewinrefresh=0;
function worknode_postover(ptype)
 {
   if(ptype=="add")
    {
      alert("增加成功!");
      parent.location.reload();
    }
   else if(ptype=="edit")
    {
      alert("修改成功!");
      closewinrefresh=1;
    }
   document.getElementById("post_area").style.display="";
   document.getElementById("post_loading").style.display="none";
 }

function closewin()
 {
   if(closewinrefresh==1)
   {
    parent.location.reload();
    parent.CloseDialog();
   }
   else
   {
    parent.CloseDialog();
   }
 }
</script>
</html>  