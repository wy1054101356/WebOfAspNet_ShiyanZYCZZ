<% @ Page Language="C#" Inherits="PageAdmin.data_add"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="data_add"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<script type="text/javascript">
var Current_SiteId="<%=Request.Cookies["SiteId"].Value%>"; //ajax加载数据用到
var Tg_Table="<%=The_Table%>"; //ajax加载数据用到
</script>
<div align=center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload(true)" title="点击刷新"><b><%=PostType=="edit"?"修改信息":"增加信息"%></b></a></td></tr>
 <tr><td height=10></td></tr>
</table>

<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top  align="left">
<div id="tabdiv">
<ul>
<li id="tab" name="tab"  onclick="showtab(0)" style="font-weight:bold">信息详情</li>
<li id="tab" name="tab"  onclick="showtab(1)">其他属性</li>
<li id="tab" name="tab"  onclick="showtab(2)">文件签收</li>
</ul>
</div>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center class=table_style2>
<tr>
  <td valign=top>
<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr>
  <td  height=25><b>所属表：</b><%=Request.QueryString["name"]%></td>
 </tr>
</table>
<iframe name="post_iframe" id="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form name='<%=The_Table%>' method='post' Enctype='multipart/form-data' target="post_iframe">
<div name="tabcontent" id="tabcontent">
<table border=0 cellpadding=5 cellspacing=0 align=center width="96%"  class="form_<%=The_Table%>">
<asp:PlaceHolder id="P_Sort" Runat="server">
<tr>
<td align=right class="tdhead">所属类别<a href="sort_list.aspx?table=<%=The_Table%>&name=<%=Server.UrlEncode(Request.QueryString["name"].ToString())%>" title="修改和增加分类" style="color:green;">[?]</a><span style='color:#ff0000'>*</span></td>
<td align="left">
<select name="s_sort" id="s_sort" onchange="c_sort(<%=Request.Cookies["SiteId"].Value%>,1,'<%=The_Table%>','admin')">
<option  value="0">---请选择所属类别---</option>
<%=Sort_List%>
</select><input type="hidden" name="sort" id="sort" value="<%=Sort_Id%>">
<script type="text/javascript">
var Sort_Type="onlyone";
Write_Select(Current_SiteId,Tg_Table);
</script>
</td>
</tr></asp:PlaceHolder><asp:PlaceHolder id="P_Form" Runat="server"/></table>
</div>
<div name="tabcontent" id="tabcontent" style="display:none">
<table border=0 cellpadding=5 cellspacing=0  align=center width=96%>
   <tr>
        <td  width="100px">文件路径</td>
        <td>
<ul style="clear:both">
 <li style="float:left;width:160px;padding-left:60px">文件目录</li>
 <li style="float:left;">文件名</li>
 <li style="clear:both;font-size:0px;height:0px;line-height:0px;width:0px;margin:0 0 0 0;padding:0 0 0 0;overflow:hidden"></li>
 <li style="float:left;">/站点目录/<input type="text" name="static_dir" id="static_dir" Maxlength="50" style="width:150px" value="<%=Static_Dir%>" title="{default}表示继承数据表设置中(或分类设置)的目录格式设置">/</li>
 <li style="float:left;"><input type="text" name="static_file" id="static_file" Maxlength="50" style="width:150px" value="<%=Static_File%>" title="留空表示继承数据表设置中(或分类设置)的文件名格式设置"> 注：文件名留空则由系统默认</li>
</ul><input type="hidden" value="<%=Table_Static_Dir%>" name="table_static_dir">

</td>
 </tr>

 <tr>
      <td align=left >SEO标题</td>
          <td><input type="text" name="zdy_title" Maxlength="150" size=50 value="<%=Zdy_Title%>">
        </td>
      </tr>

      <tr>
          <td>SEO关键字</td>
          <td><input type="text" name="zdy_keywords" Maxlength="150" size=50 value="<%=Zdy_Keywords%>">
        </td>
      </tr>

      <tr>
          <td>SEO描述</td>
          <td><textarea name="zdy_description" Cols="65" rows="4" onkeyup="if(this.value.length>250){this.value=this.value.substring(0,250)}"><%=Zdy_Description%></textarea>
        </td>
      </tr>
<tr>
     <td align=left>自定义url</td>
     <td><input type="text" name="zdy_Url" Maxlength="150" size=50 value="<%=zdy_Url%>"></td>
</tr>

      <tr>
          <td>所属专题<br><span style="color:#999999">双击删除</span></td>
          <td>
<table border=0 cellpadding=0 cellspacing=0>
<tr><td>
<select id="zt_list" name="zt_list" multiple style='width:430px;height:80px' ondblclick="clear_select('zt_list')"></select>

</td>
<td>&nbsp;<input type="button" value="选择专题" class="f_bt" onclick="open_ztlist(1,'zt_list')"></td></tr>
</table>
    </td>
      </tr>

      <tr>
          <td>信息推送<br><span style="color:#999999">双击删除</span></td>
          <td>
<table border=0 cellpadding=0 cellspacing=0>
<tr><td>
<select id="push_list" name="push_list" multiple style='width:430px;height:80px' ondblclick="clear_select('push_list');"></select>
</td>
<td>&nbsp;<input type="button" value="选择分类" class="f_bt" onclick="Sort_Select('推送分类','all','<%=Request.Cookies["SiteId"].Value%>','<%=The_Table%>','<%=The_Table%>','push_list',1,1,true,800,450)"></td></tr>
</table>

    </td>
      </tr>
<tr>
<td align=left>浏览权限
<br><input type="checkbox" name='Visiter_sortset_first' value="1" <%=PostType=="add"?"checked":""%>>继承分类设置
</td>
<td>
  <select id="Perms_MemberType" name="Perms_MemberType" size="5" style="width:250px" multiple>
   <option value="">所有用户组</option>
   <%=MemberTypeList%>
  </select>
  <script type="text/javascript">Set_Selected("<%=Permissions%>","Perms_MemberType")</script>
  <br><span style="color:#999">按住Ctrl键可实现多选或取消选择。</span>
</tr>

<tr>
<td align=left>信息属性</td>
<td><span style="display:<%=Work_Id=="0"?"":"none"%>"><input type="checkbox" name='ischecked' id='ischecked' value="1" checked <%if(Can_Check=="0"){%>onclick="alert('对不起，你没有操作这个属性的权限');return false"<%}%>>已审核</span>
<span style="display:<%=Work_Id=="0"?"none":""%>"><input type="checkbox" value="1" disabled>审核中(工作流)</span>
<input type="checkbox" name='isgood' id='isgood' value="1">推荐
<input type="checkbox" name='isnew' id='isnew' value="1">最新
<input type="checkbox" name='ishot' id='ishot' value="1">热门
<input type="checkbox" name='istop' id='istop' value="1">置顶(置顶结束日期<input type="text" name='actdate' id='actdate' value="<%=ActDate%>" maxlength="19" size="15"><a href="javascript:open_calendar('actdate',1)"><img src=/e/images/icon/date.gif border=0 hspace=2 align=absbottom></a>)
</td>
</tr>
<tr style="display:<%=Mprice_Show%>">
  <td  height=25 >会员价</td>
  <td><table id="M_Table" border=0 cellpadding=0 cellspacing=0 width=100%> 
   <asp:Repeater id="P_Member" runat="server">
     <ItemTemplate>
     <tr title="<%#DataBinder.Eval(Container.DataItem,"name")%>价格">
      <td>
        <input type="hidden" name="TBMtypeid"   value="<%#DataBinder.Eval(Container.DataItem,"id")%>">
        <input type="text" name="TBMprice"  Maxlength=15 size=10 onkeyup="if(isNaN(value))execCommand('undo')" value="<%#Get_Price(DataBinder.Eval(Container.DataItem,"id").ToString())%>"> <%#DataBinder.Eval(Container.DataItem,"name")%>
     </td>
     </tr>
     </ItemTemplate>
    </asp:Repeater>
    </table>
         </td>
      </tr>  

<tr  style="display:<%=Mprice_Show%>">
<td align=left width='100px'>兑换积分</td>
<td><input type=text name='point' id='point' Maxlength='10'  size='5' value="<%=Point==null?"0":Point%>" onkeyup="if(isNaN(value))execCommand('undo')"> 注：可兑换产品的积分</td>
</tr>

<tr  style="display:<%=Mprice_Show%>">
<td align=left width='100px'>购买赠送积分</td>
<td><input type=text name='sendpoint' id='sendpoint' Maxlength='10'  size='5' value="<%=SendPoint==null?"0":SendPoint%>" onkeyup="if(isNaN(value))execCommand('undo')"> 注：购买每单位产品的赠送积分</td>
</tr>

<tr style="display:<%=Mprice_Show%>">
<td align=left width='100px'>库存</td>
<td><input type=text name='reserves' id='reserves' Maxlength='10'  size='5' value="<%=Reserves==null?"0":Reserves%>" onkeyup="if(isNaN(value))execCommand('undo')"></td>
</tr>

<tr>
<td align=left width='100px'>点击数</td>
<td><input type=text name='clicks' id='clicks' Maxlength='10'  size='5' value="<%=Clicks==null?"0":Clicks%>" onkeyup="if(isNaN(value))execCommand('undo')"></td>
</tr>

<tr>
<td align=left width='100px'>下载数</td>
<td><input type=text name='downloads' id='downloads' Maxlength='10'  size='5' value="<%=Downloads==null?"0":Downloads%>" onkeyup="if(isNaN(value))execCommand('undo')"></td>
</tr>

<tr>
<td align=left width='100px'>评论数</td>
<td><input type=text name='comments' id='comments' Maxlength='10'  size='5' value="<%=Comments==null?"0":Comments%>" onkeyup="if(isNaN(value))execCommand('undo')"> <a href="comments_list.aspx?table=<%=The_Table%>&name=<%=Server.UrlEncode(Request.QueryString["name"])%>&detailid=<%=Request.QueryString["id"]%>"><img src="images/sign_detail.gif" border="0"></a></td>
</tr>

<tr><td align=left width='100px'>评论功能</td>
<td>
<input type="radio" name='comment_open' value="0" checked>关闭
<input type="radio" name='comment_open' id='comment_open_1' value="1">开启&nbsp;
<input type="checkbox" name='comment_check' id='comment_check' value="1" checked>评论需审核
<input type="checkbox" name='comment_anonymous' id='comment_anonymous' value="1" checked>允许匿名评论
(<input type="checkbox" name='comment_sortset_first' value="1" <%=PostType=="add"?"checked":""%>>分类设置优先)
</td>
</tr>

<tr style="display:<%=TableType=="feedback"?"":"none"%>">
<td align=left width='100px'>回复用户</td>
<td><input type="text" name='reply_username' id='reply_username' size=20 value="<%=Reply_UserName%>">(<input type="checkbox" name='reply_sortset_first' value="1" <%=PostType=="add"?"checked":""%>>分类设置优先)</td>
</tr>

<%if(PostType=="edit")
 {
%>
<tr>
<td align=left width='100px'>提交ip</td>
<td><input type="text" id="Ip" size=20 value="<%=Ip%>" readonly style="color:#999999"> <a href="javascript:GetIPAdd('<%=Ip%>')"><img src=images/sign_detail.gif border=0></a></td>
</tr>

<tr>
<td align=left width='100px'>信息编号</td>
<td><input type="text" size=20  name="code" value="<%=TheCode%>" readonly style="color:#999999"></td>
</tr>
<%}%>
</table>
</div>

<div name="tabcontent" id="tabcontent" style="display:none">
<table border=0 cellpadding=5 cellspacing=0  align=center width=96%>

<tr><td align=left width='100px'>签收功能</td>
<td>
<input type="radio" name='qs_open' id="sign_open_1" value="1" onclick="Qs_Set(1)">开启&nbsp;
<input type="radio" name='qs_open' value="0" checked onclick="Qs_Set(0)">关闭
</td>
</tr>

<tr id="tr_qs" name="tr_qs"><td align=left width='100px'>指定签收部门</td>
<td>
<select id="qs_department" name="qs_department" size="10" multiple style="width:300px" title="按住Ctrl可多选或取消选中状态" ondblclick="unselect('qs_department')">
<%=DepartmentList%>
</select>
</td>
</tr>

<tr id="tr_qs" name="tr_qs"><td align=left width='100px'>指定签收用户<br><span style="color:#999999">双击删除</span></td>
<td>
<table border=0 cellpadding=0 cellspacing=0>
<tr><td>
<select id="qs_list" name="qs_list" multiple style='width:300px;height:250px' ondblclick="clear_select('qs_list');" title="双击可以删除选定用户"></select>
</td>
<td>&nbsp;&nbsp;<input type="button" value="选择用户" class="f_bt" onclick="Member_Select('选择签收用户',0,0,1,'qs_list',true,350,400)"></td></tr>
</table>
</td>
</tr>

<tr id="tr_qs" name="tr_qs"><td align=left width='100px'>签收截止日期</td>
<td><input type=text name='qs_enddate' id='qs_enddate' Maxlength='20' size='15' value="<%=Sign_Enddate%>"><a href="javascript:open_calendar('qs_enddate',1)"><img src=/e/images/icon/date.gif border=0 height=20 hspace=2 align=absbottom></a>
</td>
</tr>
</table>
</div>

<div align=center style="padding:10px 0 5px 0">
<input type='hidden' name="post" value="<%=PostType%>">
<input type='hidden' name="workid" value="<%=Work_Id%>">
<input type='hidden' name="dbtype" value="<%=TableType%>">
<input type='hidden' name="tg_workid" value="<%=Tg_WorkId%>">
<input type='hidden' name="edit_check" value="<%=Edit_Check%>">
<span id="post_area">
<%if(Work_Id!="0" && Current_Work_Node=="0"){%>
<input type="checkbox" name="rechecked" value="1" checked>重新送审
<%}%>
<input type='button' class='button' value='提交' onclick="return fun_datapost()"> 
<%if(PostType=="add"){%>
<input type='button' value='返回' class='button' onclick="location.href='data_list.aspx?table=<%=The_Table%>&name=<%=Server.UrlEncode(Request.QueryString["name"])%><%=Sort_Id=="0"?"":"&sortid="+Sort_Id%>'">
<%}else{%>
<input type="button" class=button  value="关闭"  onclick="parent.CloseDialog()">
<%}%>
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>  
</div>
</form>
</td>
</tr>
</table>
<br>
</div>
</body>
<script language="javascript">
var Current_Id="<%=Request.QueryString["id"]%>";
var Sorts="<%=Parent_Ids%>,<%=Sort_Id%>";
var Department="<%=Sign_Department%>";
var ADepartment=Department.split(',');
var qs_department=document.getElementById("qs_department");
if(Department!="") //初始签收部门checkbox
 {
     for(i=0;i<qs_department.length;i++)
     {
      for(k=0;k<ADepartment.length;k++)
      {
        if(qs_department[i].value==ADepartment[k])
         {
          qs_department[i].selected=true;
         }
      }
    }
 }

var TWidth=document.getElementById("thumbnail_width"); //初始缩略图尺寸
var THeight=document.getElementById("thumbnail_height");
if(TWidth!=null && THeight!=null)
 {
   TWidth.value="<%=Thumbnail_MinWidth%>";
   THeight.value="<%=Thumbnail_MinHeight%>";
 }

function Qs_Set(open)
 {
   var Tr_Qs=document.getElementsByName("tr_qs");
   if(open==1)
    {
     Tr_Qs[0].style.display="";
     Tr_Qs[1].style.display="";
     Tr_Qs[2].style.display="";
    }
   else 
    {
     Tr_Qs[0].style.display="none";
     Tr_Qs[1].style.display="none";
     Tr_Qs[2].style.display="none";
    }
 }

  <%if(PostType=="add"){%>
    if("<%=Add_Check%>"=="1")
     {
      document.getElementById("ischecked").checked=false;
     }
   <%}
     else
   {%>
    if("<%=IsChecked%>"=="0")
     {
      document.getElementById("ischecked").checked=false;
     }
  <%}%>
  if("<%=IsTop%>"=="1")
   {
     document.getElementById("istop").checked=true;
   }
  if("<%=IsGood%>"=="1")
   {
     document.getElementById("isgood").checked=true;
   }
  if("<%=IsNew%>"=="1")
   {
     document.getElementById("isnew").checked=true;
   }
  if("<%=IsHot%>"=="1")
   {
     document.getElementById("ishot").checked=true;
   }
  if("<%=Comment_Open%>"=="1")
   {
     document.getElementById("comment_open_1").checked=true;
   }
  if("<%=Comment_Check%>"=="0")
   {
     document.getElementById("comment_check").checked=false;
   }
  if("<%=Comment_Anonymous%>"=="0")
   {
     document.getElementById("comment_anonymous").checked=false;
   }
  if("<%=Sign_Open%>"=="1")
   {
     document.getElementById("sign_open_1").checked=true;
   }
   Qs_Set(<%=Sign_Open%>);
<%if(PostType=="edit")
 {
%>
  load_ajaxdata("pa_lanmu","<%=Zt_Ids%>","zt_list");//专题列表
  load_ajaxdata("pa_sort","<%=Push_SortIds%>","push_list");//推送分类
  load_ajaxdata("pa_member","<%=Sign_Users%>","qs_list","department");//签收用户
<%}else{%>
  var saveimage=document.forms[0].saveimage;
  var autotitlepic=document.forms[0].autotitlepic;
  if(saveimage!=null){saveimage.checked=false}
  if(autotitlepic!=null){autotitlepic.checked=false}
<%}%>
<%if(Sort_Id!="0"){%>
Load_Sort(Current_SiteId,Sorts,'<%=The_Table%>');
<%}%>

var IP=document.getElementById("Ip");
function ShowIp()
  {
   GetIPAdd(IP.value);
  }
if(IP!=null)
{
 IP.ondbclick=ShowIp;
}

function fun_datapost()
 {
   Set_Selected('select-all','zt_list');
   Set_Selected('select-all','push_list');
   Set_Selected('select-all','qs_list');
   return Check_ZdyForm('<%=The_Table%>')
 }
</script>
</html>