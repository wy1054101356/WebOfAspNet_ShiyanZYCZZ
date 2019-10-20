<% @ Page Language="C#" Inherits="PageAdmin.admin_permissions"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="admin_permissions"/>
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td align="left" valign=top>
<br>
<div id="tabdiv">
<ul>
<li id="tab" name="tab"  onclick="showtab(0)" style="font-weight:bold">基础权限</li>
<li id="tab" name="tab"  onclick="showtab(1)">信息权限</li>
</ul>
</div>
<div name="tabcontent" id="tabcontent">
<iframe name="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form method="post" Runat="server" target="post_iframe">
<table border=0 cellpadding=5 cellspacing=5 width=100% align=center  class=table_style2>
<tr>
  <td align="left" valign=top>
<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
 <tr>
  <td align="left" height=25 width=100><b><%=Site_Name%></b></td>
  <td align="left" height=25><input type="checkbox" id="site_<%=SiteId%>" name="site_<%=SiteId%>" value="1" onclick="open_siteadmin(this.checked)">开启管理权限</td>
 <tr>
</table>
<div id="p_div" style="display:none">
<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
 <tr>
  <td align="left" height=25 width=100><b>基础管理权限</b></td>
  <td align="left" height=25>
   <input type="checkbox" id="basic_webset" name="basic" value="basic_webset">网站参数设置&nbsp;
   <input type="checkbox" id="basic_task" name="basic" value="basic_task">计划任务管理
   <input type="checkbox" id="basic_worklist" name="basic" value="basic_worklist">工作流管理
   <input type="checkbox" id="basic_onlinepay" name="basic" value="basic_onlinepay">在线支付接口&nbsp;
   <input type="checkbox" id="basic_pointcard" name="basic" value="basic_pointcard">积分充值管理&nbsp;
   <input type="checkbox" id="basic_sendwaylist" name="basic" value="basic_sendwaylist">配送方式管理&nbsp;
   <input type="checkbox" id="basic_datamanage" name="basic" value="basic_datamanage">数据库操作
   <input type="checkbox" id="basic_log" name="basic" value="basic_log">日志管理
   <input type="checkbox" id="basic_tongji" name="basic" value="basic_tongji">流量统计
 </td>
 </tr>

<tr><td colspan="2" height="10px"></td></tr>
<tr>
  <td align="left" height=25><b>会员中心</b></td>
  <td align="left" height=25>
   <input type="checkbox" id="member_set" name="member" value="member_set">会员系统设置&nbsp;
   <input type="checkbox" id="member_type" name="member" value="member_type">会员类别设置&nbsp;
   <input type="checkbox" id="member_department" name="member" value="member_department">会员部门设置&nbsp;
   <input type="checkbox" id="member_field" name="member" value="member_field">会员字段管理&nbsp;
   <input type="checkbox" id="member_menu" name="member" value="member_menu">新增会员菜单&nbsp;<br>
   <input type="checkbox" id="member_add" name="member" value="member_add">新增会员用户&nbsp;<br>
   <input type="checkbox" id="member_list" name="member" value="member_list">会员管理&nbsp;(如需要限制管理类别，请在下面选择框中选择)<br>
   <asp:ListBox id="P_MtypeList" Runat="server" DataTextField="name" DataValueField="id" SelectionMode="Multiple" Rows="5" style="width:200px" title="可按住Ctrl键实现多选或取消选择"/>
 </td>
 </tr>

<tr><td colspan="2" height="10px"></td></tr>
<tr>
  <td align="left" height=25><b>事务管理</b></td>
  <td align="left" height=25>
   <input type="checkbox" id="bs_issue" name="business" value="bs_issue">签发信息&nbsp;
   <input type="checkbox" id="bs_sign" name="business" value="bs_sign">信息签收&nbsp;
   <input type="checkbox" id="bs_letter" name="business" value="bs_letter">信息回复&nbsp;
   <input type="checkbox" id="bs_feedback" name="business" value="bs_feedback">会员留言&nbsp;
   <input type="checkbox" id="bs_order" name="business" value="bs_order">订单管理&nbsp;
   <input type="checkbox" id="bs_exchange" name="business" value="bs_exchange">兑换管理&nbsp;
   <input type="checkbox" id="bs_finance" name="business" value="bs_finance">财务记录查看&nbsp;
   <input type="checkbox" id="bs_point" name="business" value="bs_point">积分记录查看&nbsp;
   <input type="checkbox" id="bs_collection"  name="business" value="bs_collection">信息采集&nbsp;
   <input type="checkbox" id="bs_msgsend"  name="business" value="bs_msgsend">信息群发&nbsp;
 </td>
 </tr>


<tr><td colspan="2" height="10px"></td></tr>
<tr>
  <td align="left" height=25><b>栏目布局配置</b></td>
  <td align="left" height=25>
   <input type="checkbox" id="lanmu_admin" name="lanmu" value="lanmu_admin">栏目管理（<input type="checkbox" id="lanmu_add" name="lanmu" value="lanmu_add">增加&nbsp;
   <input type="checkbox" id="lanmu_edit" name="lanmu" value="lanmu_edit">修改&nbsp;
   <input type="checkbox" id="lanmu_del" name="lanmu" value="lanmu_del">删除&nbsp;
   <input type="checkbox" id="lanmu_set" name="lanmu" value="lanmu_set">设置&nbsp;
   <input type="checkbox" id="lanmu_nav" name="lanmu" value="lanmu_nav">导航管理&nbsp;
   <input type="checkbox" id="lanmu_module" name="lanmu" value="lanmu_module">模块管理）&nbsp;
   <br><asp:ListBox id="P_LanmuList" Runat="server" DataTextField="name" DataValueField="id" SelectionMode="Multiple" Rows="5" style="width:200px" title="按住Ctrl键实现多选或取消选择"/>
   <br>
   <input type="checkbox" id="lanmu_ztlist" name="lanmu" value="lanmu_ztlist">专题管理（<input type="checkbox" id="lanmu_ztlistself" name="lanmu" value="lanmu_ztlistself">只能管理自己的专题&nbsp;）&nbsp;
   <input type="checkbox" id="lanmu_style" name="lanmu" value="lanmu_style">局部样式设置&nbsp;
   <input type="checkbox" id="lanmu_spc" name="lanmu" value="lanmu_spc">局部内容设置
</td>
 </tr>



<tr><td colspan="2" height="10px"></td></tr>
<tr>
  <td align="left" height=25><b>表单模型管理</b></td>
  <td align="left" height=25>
   <input type="checkbox" id="zdytable_list" name="zdytable" value="zdytable_list">自定义表单&nbsp;
 </td>
 </tr>


<tr><td colspan="2" height="10px"></td></tr>
<tr>
  <td align="left" height=25><b>插件调用区</b></td>
  <td align="left" height=25>
   <input type="checkbox" id="js_loginbox" name="js" value="js_loginbox">会员登陆&nbsp;
   <input type="checkbox" id="js_slide" name="js" value="js_slide">幻灯片 &nbsp;
   <input type="checkbox" id="js_vote" name="js" value="js_vote">问卷调查 &nbsp;
   <input type="checkbox" id="js_adv"  name="js" value="js_adv">问卷调查 &nbsp;
   <input type="checkbox" id="js_link" name="js" value="js_link">友情链接 &nbsp;
 </td>
 </tr>
</table>
 </div>
 </td>
 </tr>
</table>

<div  align="center" style="padding:20px 0 0 0">
<input type="hidden" name="tijiao" value="yes" >
<span id="post_area">
<input type="submit" value="提 交" id="Bt_Submit" class="button" />
<input type="button" value="关闭" class="button" onclick="parent.CloseDialog()" />
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>
</form>
</div>
<script language="javascript">
 function open_siteadmin(this_checked)
  {
    if(this_checked)
     {
      document.getElementById("p_div").style.display="";
     }
    else
     {
       document.getElementById("p_div").style.display="none";
     }
  }

 var CSiteAdmin="<%=CSiteAdmin%>";
 if(CSiteAdmin=="1")
  {
   document.getElementById("site_<%=SiteId%>").checked=true;
   open_siteadmin(true);
  }
 else
  {
   open_siteadmin(false);
  }
 var Obj;
 var Permissions="<%=Permissions%>";
 var APermissions=Permissions.split(',');
 for(i=0;i<APermissions.length;i++)
  {
    if(APermissions[i]!="")
     {
        Obj=document.getElementById(APermissions[i]);
        if(Obj!=null)
         {
          Obj.checked=true;
         }
     }
  }
document.getElementById("Bt_Submit").onclick=startpost;

function tbshow(id,type)
 {
  var tb_admin_onlyself=document.getElementById("tb_onlyself_"+id);
  var Tb=document.getElementById("tb_"+id);
  if(type==1)
   {
     tb_admin_onlyself.style.display="";
     Tb.style.display="";
   }
  else
   {
     tb_admin_onlyself.style.display="none";
     Tb.style.display="none";
   }
 }
</script>
</div>


<div name="tabcontent" id="tabcontent"  style="display:none">
<asp:Repeater id="P_zdyform" runat="server">
<ItemTemplate>
<form method="post" target="post_iframe" name="f_<%#DataBinder.Eval(Container.DataItem,"id")%>">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
<td valign=top align="left">
    <table border=0 cellpadding=5 cellspacing=0 width=100%>
      <tr>
       <td width=100><%#DataBinder.Eval(Container.DataItem,"table_name")%></td>
       <td>
         <input type="radio" value="1" name="can_admin" onclick="tbshow('<%#DataBinder.Eval(Container.DataItem,"id")%>',1)">开启管理<span style="display:none" id="tb_onlyself_<%#DataBinder.Eval(Container.DataItem,"id")%>">(<input type="checkbox" name="can_admin_onlyself" value="1">只能管理自己的信息)</span> &nbsp;&nbsp;<input type="radio" name="can_admin" value="0" checked onclick="tbshow('<%#DataBinder.Eval(Container.DataItem,"id")%>',0)">关闭管理
       </td>
      </tr>
     </table>
    <table border=0 cellpadding=5 cellspacing=0 width=100% align=center style="display:none" id="tb_<%#DataBinder.Eval(Container.DataItem,"id")%>">
      <tr>
       <td width=100>发布功能</td>
       <td width=350>
        <input type="radio" value="1" name="can_add" checked>开启 <input type="radio" name="can_add" value="0">关闭<br>
       </td>
       <td rowspan=7 valign=top>
         <select name="can_sortids" size="13" multiple>
          <option value="0">所有分类(可管理和发布所有分类)</option>
          <%#Get_Sort(DataBinder.Eval(Container.DataItem,"thetable").ToString())%>
         </select>
         <br>注：如果选择了子类，则必须选择对应的上一级父类别(可以按住Ctrl键多选)。
       </td>
      </tr>
      <tr>
       <td>新增信息</td>
       <td>
        <input type="radio" name="add_check" value="0"  checked>无需审核
        <input type="radio" name="add_check" value="1">需要审核
      </td>
     </tr>

      <tr>
       <td>修改信息</td>
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
       <td>审核工作流</td>
       <td>
       <select name="tg_workid">
        <option value="0">不指定</option>
        <%=Works_Option%>
       </select> 注:信息设置为需要审核时有效。
      </td>
     </tr>

     <tr>
       <td>审核信息权限</td>
       <td><input type="checkbox"  name="can_check" value="1">开启
      </td>
     </tr>

    <tr>
       <td height=20px>相关功能</td>
       <td><input type="checkbox" name="sort_admin" value="1">分类管理 <input type="checkbox" name="comments_admin" value="1">评论管理</td>
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
     var can_admin="<%#can_admin%>";if(can_admin!="0" && can_admin!=""){obj.can_admin[0].click();tbshow(id,1);}
     if(can_admin=="1"){obj.can_admin_onlyself.checked=true;}

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
     var can_check="<%#can_check%>";if(can_check=="1"){obj.can_check.checked=true;}
     var sort_admin="<%#sort_admin%>";if(sort_admin=="1"){obj.sort_admin.checked=true;}
     var comments_admin="<%#comments_admin%>";if(comments_admin=="1"){obj.comments_admin.checked=true;}
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
