<% @ Page Language="C#" Inherits="PageAdmin.member_center_set"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server"  Type="member_type" />
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table border=0 cellpadding=0 cellspacing=0 width=95%>
 <tr>
<td align="left" valign=top><br>
<iframe name="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<div id="div1">
<div id="tabdiv">
<ul>
<li id="tab" name="tab"  onclick="showtab(0)" style="font-weight:bold">会员中心功能</li>
<li id="tab" name="tab"  onclick="showtab(1)">投稿设置</li>
</ul>
</div>
<div name="tabcontent" id="tabcontent">
<form method="post" target="post_iframe">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center class=table_style2>
 <tr>
  <td align="left">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center>
 <tr>
  <td align="left" height=25 width=100px>作用站点</td>
  <td align="left" height=25><select id="site_id" name="site_id"><%=Site_Options%></select>
  </td>
 </tr>
 <tr>
  <td align="left" height=25 width=100px>上传权限(全局)</td>
  <td align="left" height=25>
  <input type="checkbox" name="upload_editor_image" id="upload_editor_image"  value="1">编辑器图片&nbsp;<input type="checkbox" name="upload_editor_attachment" id="upload_editor_attachment" value="1" >编辑器附件&nbsp;<input type="checkbox" name="upload_memberform" id="upload_memberform" value="1" >会员表单&nbsp;
</td>
 </tr>
 <tr>
  <td align="left" height=25 width=100px>会员空间</td>
  <td align="left" height=25>
   <input type="radio" name="m_space" id="m_space" value="1">开启 <input type="radio" name="m_space" value="0" checked>关闭
  </td>
 </tr>

 <tr>
  <td align="left" height=25 width=100px>站内信息</td>
  <td align="left" height=25>
   <input type="radio"  name="message" id="message" value="1" >开启(<input type="checkbox" name="sendemail" id="sendemail" value="1" >允许发邮件 <input type="checkbox" name="sendsms" id="sendsms" value="1" >允许发手机短信) <input type="radio"  name="message" value="0" checked>关闭
  </td>
 </tr>

 <tr>
  <td align="left" height=25>签发信息</td>
  <td align="left" height=25>
   <input type="radio"  name="issue" id="issue"  value="1">开启 <input type="radio"  name="issue" value="0" checked>关闭<br>
  </td>
 </tr>

 <tr>
  <td align="left" height=25>信息签收</td>
  <td align="left" height=25>
   <input type="radio"  name="sign" id="sign" value="1">开启 <input type="radio"  name="sign" value="0" checked>关闭<br>
  </td>
 </tr>

 <tr>
  <td align="left" height=25>信息回复</td>
  <td align="left" height=25>
   <input type="radio"  name="letter" id="letter" value="1">开启 <input type="radio"  name="letter" value="0" checked>关闭<br>
  </td>
 </tr>

 <tr>
  <td align="left" height=25>我的订单</td>
  <td align="left" height=25>
   <input type="radio"  name="order" id="order" value="1" >开启 <input type="radio"  name="order" value="0" checked>关闭<br>
  </td>
 </tr>

 <tr>
  <td align="left" height=25>我的兑换</td>
  <td align="left" height=25>
   <input type="radio"  name="exchange" id="exchange" value="1" >开启 <input type="radio"  name="exchange" value="0" checked>关闭<br>
  </td>
 </tr>

 <tr>
  <td align="left" height=25>我的财务</td>
  <td align="left" height=25><input type="radio" name="fnc" id="fnc" value="1">开启 <input type="radio" name="fnc" value="0" checked>关闭</td>
 </tr>

 <tr>
  <td align="left" height=25>我的积分</td>
  <td align="left" height=25><input type="radio" name="point" id="point" value="1">开启 <input type="radio" name="point" value="0" checked>关闭
 </td>
 </tr>

 <tr>
  <td align="left" height=25>会员留言</td>
  <td align="left" height=25><input type="radio" name="feedback" id="feedback" value="1">开启 <input type="radio"  name="feedback" value="0" checked>关闭</td>
 </tr>

 <tr>
  <td align="left" height=25>我的收藏</td>
  <td align="left" height=25><input type="radio" name="favorites" id="favorites" value="1">开启 <input type="radio"  name="favorites" value="0" checked>关闭</td>
 </tr>
</table>
</td>
 </tr>
</table>
<div align=center style="padding:10px">
<span id="post_area">
<input type="hidden" name="table" value="">
<input type="hidden" id="m_set" name="m_set" value="<%=M_Set%>">
<input type="submit" id="Bt_Submit" value="提 交" class="button" />
<input type="button" value="关闭" class="button" onclick="parent.CloseDialog()" />
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>
</div>
</form>
<script type="text/javascript">
var Ids="upload_editor_image,upload_editor_attachment,upload_memberform";
Ids+=",m_space,message,sendemail,sendsms,issue,sign,sign,letter,order,exchange,fnc,point,feedback,favorites";
var Aids=Ids.split(",");
function Create_Mset()
 {
  var obj;
  var mset=",";
  for(i=0;i<Aids.length;i++)
   {
     obj=document.getElementById(Aids[i]);
     if(obj==null)
      {
        alert(Aids[i]);
      }
     else
     {
       if(obj.checked)
       {
         mset+=Aids[i]+",";
       }
     }
   }
  document.getElementById("m_set").value=mset;
  startpost();
 }
document.getElementById("Bt_Submit").onclick=Create_Mset;
var M_Center="<%=M_Set%>";
document.getElementById("site_id").value="<%=Act_SiteId%>";
if(M_Center!="")
  {
     if(M_Center.indexOf(",upload_editor_image,")>=0)
      {
        document.getElementById("upload_editor_image").checked=true;
      }
     if(M_Center.indexOf(",upload_editor_attachment,")>=0)
      {
        document.getElementById("upload_editor_attachment").checked=true;
      }
     if(M_Center.indexOf(",upload_memberform,")>=0)
      {
        document.getElementById("upload_memberform").checked=true;
      }
    /*
     if(M_Center.indexOf(",upload_field_image,")>=0)
      {
        document.getElementById("upload_field_image").checked=true;
      }
     if(M_Center.indexOf(",upload_field_attachment,")>=0)
      {
        document.getElementById("upload_field_attachment").checked=true;
      }
     if(M_Center.indexOf(",upload_field_images,")>=0)
      {
        document.getElementById("upload_field_images").checked=true;
      }
     if(M_Center.indexOf(",upload_field_attachments,")>=0)
      {
        document.getElementById("upload_field_attachments").checked=true;
      }

     */
     if(M_Center.indexOf(",m_space,")>=0)
      {
        document.getElementById("m_space").checked=true;
      }
     if(M_Center.indexOf(",message,")>=0)
      {
        document.getElementById("message").checked=true;
        if(M_Center.indexOf(",sendemail,")>=0){document.getElementById("sendemail").checked=true;}
        if(M_Center.indexOf(",sendsms,")>=0){document.getElementById("sendsms").checked=true;}
      }
     if(M_Center.indexOf(",issue,")>=0)
      {
        document.getElementById("issue").checked=true;
      }
     if(M_Center.indexOf(",sign,")>=0)
      {
        document.getElementById("sign").checked=true;
      }
     if(M_Center.indexOf(",letter,")>=0)
      {
        document.getElementById("letter").checked=true;
      }
     if(M_Center.indexOf(",order,")>=0)
      {
        document.getElementById("order").checked=true;
      }
     if(M_Center.indexOf(",exchange,")>=0)
      {
        document.getElementById("exchange").checked=true;
      }
      if(M_Center.indexOf(",fnc,")>=0)
      {
        document.getElementById("fnc").checked=true;
      }
      if(M_Center.indexOf(",point,")>=0)
      {
        document.getElementById("point").checked=true;
      }
      if(M_Center.indexOf(",pointlist,")>=0)
      {
        document.getElementById("pointlist").checked=true;
      }
      if(M_Center.indexOf(",onlinepay,")>=0)
      {
        document.getElementById("onlinepay").checked=true;
      }
      if(M_Center.indexOf(",feedback,")>=0)
      {
        document.getElementById("feedback").checked=true;
      }
      if(M_Center.indexOf(",favorites,")>=0)
      {
        document.getElementById("favorites").checked=true;
      }
  }
function tbshow(id,type)
 {
  var Tballsite=document.getElementById("tb_allsite_"+id);
  var Tb=document.getElementById("tb_"+id);
  if(type==1)
   {
     Tballsite.style.display="";
     Tb.style.display="";
   }
  else
   {
     Tballsite.style.display="none";
     Tb.style.display="none";
   }
 }
</script>
</div>

<div name="tabcontent" id="tabcontent"  style="display:none">
<asp:Repeater id="P_zdyform" runat="server" OnItemDataBound="Data_Bound">
<ItemTemplate>
<form method="post" target="post_iframe" name="f_<%#DataBinder.Eval(Container.DataItem,"id")%>">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
<td valign=top align="left">
    <table border=0 cellpadding=5 cellspacing=0 width=100%>
      <tr>
       <td width=100><%#DataBinder.Eval(Container.DataItem,"table_name")%></td>
       <td>
         <input type="radio" value="1" name="can_admin" onclick="tbshow('<%#DataBinder.Eval(Container.DataItem,"id")%>',1)">开启管理<span style="display:none" id="tb_allsite_<%#DataBinder.Eval(Container.DataItem,"id")%>">(<input type="checkbox" name="can_admin_allsite" value="1">分站合并管理)</span> &nbsp;&nbsp;<input type="radio" name="can_admin" value="0" checked onclick="tbshow('<%#DataBinder.Eval(Container.DataItem,"id")%>',0)">关闭管理
       </td>
      </tr>
     </table>
    <table border=0 cellpadding=5 cellspacing=0 width=100% align=center style="display:none" id="tb_<%#DataBinder.Eval(Container.DataItem,"id")%>">
      <tr>
       <td width=100 style="height:25px">发布功能</td>
        <td width=250>
         <input type="radio" value="1" name="can_add" checked>开启 <input type="radio" name="can_add" value="0">关闭
       </td>
       <td rowspan="10" valign=top>
          <div style="line-height:20px;height:20px;overflow:hidden">注：如果选择了子类，则必须选择对应的上一级父类别(可以按住Ctrl键多选)</div>
          <select name="can_sortids" size="14" multiple>
          <option value="0">所有分类(可管理和发布所有分类)</option>
          <%#Get_Sort(DataBinder.Eval(Container.DataItem,"thetable").ToString())%>
          </select>
       </td>
      </tr>

      <tr>
       <td style="height:25px">新增信息</td>
       <td>
        <input type="radio" name="add_check" value="0"  checked>无需审核
        <input type="radio" name="add_check" value="1">需要审核
      </td>
     </tr>

      <tr>
       <td style="height:25px">修改信息</td>
       <td>
        <input type="radio" name="edit_check" value="0"  checked>无需审核
        <input type="radio" name="edit_check" value="1">需要审核
      </td>
     </tr>
    <tr>
       <td height=20px>已审核信息</td>
       <td><input type="checkbox"  name="can_edit" value="1">允许修改 <input type="checkbox"  name="can_delete" value="1">允许删除</td>
   </tr>
     <tr>
       <td style="height:25px">审核工作流</td>
       <td>
       <select name="tg_workid">
        <option value="0">不指定</option>
        <%=Works_Option%>
       </select> 注:信息设置为需要审核时有效。
      </td>
     </tr>

    <tr>
       <td style="height:25px">投稿赠送积分</td>
       <td>
        <input type="textbox" name="add_sendpoint"  size="5" Maxlength="15" value=0>点(为负数时则表示扣除积分)
      </td>
    </tr>

    <tr>
       <td style="height:25px">每天投稿上限</td>
       <td>
        <input type="textbox" name="tg_day_maxnum"  size="5" Maxlength="15" value="0">(0则表示无限制)
      </td>
    </tr>

    <tr>
       <td style="height:25px">投稿总数上限</td>
       <td>
        <input type="textbox" name="tg_all_maxnum"  size="5" Maxlength="15" value="0">(0则表示无限制)
      </td>
    </tr>

    <tr>
       <td style="height:25px">超过上限扣除积分</td>
       <td>
        <input type="textbox" name="tg_exceed_needpoint"  size="5" Maxlength="15" value=0>(0表示不允许再发布)
      </td>
    </tr>

    <tr>
       <td style="height:25px">上传权限</td>
       <td colspan=2>
        <input type="checkbox" name="up_editor_image" value="1">编辑器图片&nbsp;<input type="checkbox" name="up_editor_flash" id="up_editor_flash" value="1" >编辑器视频&nbsp;<input type="checkbox" name="up_editor_attachment" id="upload_editor_attachment" value="1" >编辑器附件&nbsp;
        <input type="checkbox" name="up_field_image" value="1">图片字段&nbsp;<input type="checkbox" name="up_field_file" value="1">附件字段&nbsp;
        <input type="checkbox" name="up_field_images" value="1">图片组字段&nbsp;<input type="checkbox" name="up_field_files" value="1">附件组字段
      </td>
    </tr>

     <tr>
       <td style="height:25px">信息置顶</td>
       <td colspan="2">
<select name="settop"><option value="0">关闭</option><option value="1">开启</option></select>  
置顶费用：<input type="textbox"  name="settop_needpoint" size="5" Maxlength="10" onkeyup="if(isNaN(value))execCommand('undo')" value=0>积分/天
</td></tr>

    <tr style="display:none">
       <td height=20px>评论管理</td>
       <td colspan="2"><input type="checkbox"  name="comments_check" value="1">允许审核 <input type="checkbox"  name="comments_delete" value="1">允许删除 <input type="checkbox" name="comments_reply" value="1">允许回复</td>
    </tr>

    <tr style="display:none">
       <td height=20px>其他功能</td>
       <td colspan="2"><input type="checkbox"  name="set_sign" value="1">允许设置签收 <input type="checkbox"  name="set_related" value="1">允许设置相关信息 <input type="checkbox" name="set_permission" value="1">允许设置访问权限</td>
    </tr>
  </table>
<input type="hidden" name="table" value="<%#DataBinder.Eval(Container.DataItem,"thetable")%>" />
<div align=left style="padding:5px">
<span id="post_area_<%#DataBinder.Eval(Container.DataItem,"thetable")%>">
<input type="submit"  value="保存" class="button" onclick="tg_startpost('<%#DataBinder.Eval(Container.DataItem,"thetable")%>')"/>
</span>
<span id="post_loading_<%#DataBinder.Eval(Container.DataItem,"thetable")%>" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>
</div>
</td>
</tr>
</table>
</form>
<br><%#Get_Tgset(DataBinder.Eval(Container.DataItem,"thetable").ToString())%>
 <script type="text/javascript">
   function load_<%#DataBinder.Eval(Container.DataItem,"id")%>()
    {
     var id="<%#DataBinder.Eval(Container.DataItem,"id")%>";
     var obj=document.f_<%#DataBinder.Eval(Container.DataItem,"id")%>;
     var can_admin="<%#can_admin%>";if(can_admin=="1"){obj.can_admin[0].click();tbshow(id,1);}
     var can_admin_allsite="<%#can_admin_allsite%>";if(can_admin_allsite=="1"){obj.can_admin_allsite.checked=true;}
     var can_add="<%#can_add%>";if(can_add=="0"){obj.can_add[1].checked=true;}

     var add_check="<%#add_check%>";if(add_check=="1"){obj.add_check[1].checked=true;}
     var edit_check="<%#edit_check%>";if(edit_check=="1"){obj.edit_check[1].checked=true;}

     var can_sortids="<%#can_sortids%>";
     var objselect=obj.can_sortids;
     var Acan_sortids=can_sortids.split(',');
     for(i=0;i<Acan_sortids.length;i++)
     {
      for(k=0;k<objselect.length;k++)
       {
        if(objselect[k].value==Acan_sortids[i])
         {
          objselect[k].selected=true;
         }
      }
    }

     var can_edit="<%#can_edit%>";if(can_edit=="1"){obj.can_edit.checked=true;}
     var can_delete="<%#can_delete%>";if(can_delete=="1"){obj.can_delete.checked=true;}
     var tg_workid="<%#tg_workid%>";obj.tg_workid.value=tg_workid;
     var add_sendpoint="<%#add_sendpoint%>";obj.add_sendpoint.value=add_sendpoint;
     var tg_day_maxnum="<%#tg_day_maxnum%>";obj.tg_day_maxnum.value=tg_day_maxnum;
     var tg_all_maxnum="<%#tg_all_maxnum%>";obj.tg_all_maxnum.value=tg_all_maxnum;
     var tg_exceed_needpoint="<%#tg_exceed_needpoint%>";obj.tg_exceed_needpoint.value=tg_exceed_needpoint;
     var settop="<%#settop%>";obj.settop.value=settop;
     var settop_needpoint="<%#settop_needpoint%>";obj.settop_needpoint.value=settop_needpoint;
     var comments_check="<%#comments_check%>";if(comments_check=="1"){obj.comments_check.checked=true;}
     var comments_delete="<%#comments_delete%>";if(comments_delete=="1"){obj.comments_delete.checked=true;}
     var comments_reply="<%#comments_reply%>";if(comments_reply=="1"){obj.comments_reply.checked=true;}
     var set_sign="<%#set_sign%>";if(set_sign=="1"){obj.set_sign.checked=true;}
     var set_related="<%#set_related%>";if(set_related=="1"){obj.set_related.checked=true;}
     var set_permission="<%#set_permission%>";if(set_permission=="1"){obj.set_permission.checked=true;}
     var up_editor_image="<%#up_editor_image%>";if(up_editor_image=="1"){obj.up_editor_image.checked=true;}
     var up_editor_flash="<%#up_editor_flash%>";if(up_editor_flash=="1"){obj.up_editor_flash.checked=true;}
     var up_editor_attachment="<%#up_editor_attachment%>";if(up_editor_attachment=="1"){obj.up_editor_attachment.checked=true;}
     var up_field_image="<%#up_field_image%>";if(up_field_image=="1"){obj.up_field_image.checked=true;}
     var up_field_file="<%#up_field_file%>";if(up_field_file=="1"){obj.up_field_file.checked=true;}
     var up_field_images="<%#up_field_images%>";if(up_field_images=="1"){obj.up_field_images.checked=true;}
     var up_field_files="<%#up_field_files%>";if(up_field_files=="1"){obj.up_field_files.checked=true;}
    }
   load_<%#DataBinder.Eval(Container.DataItem,"id")%>();
 </script>
 <asp:Label id="lb_table" runat="server" visible="false" text='<%#DataBinder.Eval(Container.DataItem,"thetable")%>'/>
 </ItemTemplate>
</asp:Repeater>
<div align=center style="padding:10px">
<input type="button" value="关闭" class="button" onclick="parent.CloseDialog()" />
</div>
</div>
<br>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
function tg_startpost(table)
 {
  document.getElementById("post_area_"+table).style.display="none";
  document.getElementById("post_loading_"+table).style.display="";
 }

function tg_postover(table)
 {
  alert("提交成功");
  document.getElementById("post_area_"+table).style.display="";
  document.getElementById("post_loading_"+table).style.display="none";
 }
</script>
</body>
</html>