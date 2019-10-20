<% @ Page Language="C#"  Inherits="PageAdmin.data_set"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table border=0 cellpadding=10 cellspacing=0 width=98%>
 <tr>
<td valign=top align="left">
<iframe name="pframe" id="pframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<div id="div1">
<div id="tabdiv">
<ul>
<li id="tab" name="tab"  onclick="showtab(0)" style="font-weight:bold">信息相关</li>
<li id="tab" name="tab"  onclick="showtab(1)">其他设置</li>
</ul>
</div>
<form method="post" target="pframe" action="data_set.aspx?table=<%=Request.QueryString["table"]%>&name=<%=Server.UrlEncode(Request.QueryString["name"])%>">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
<div name="tabcontent" id="tabcontent" style="display:block">
<table border=0 cellpadding=2 cellspacing=0  align=center width=98%>
<tr><td align=left width="80px"><input type="checkbox" name='siteidset' value="1">站点转移</td>
   <td>
<select name="SiteId" onchange="c_site(this.value)"><%=SiteList%></select>

<select name="s_sort" id="s_sort" onchange="c_sort(1,'<%=Request.QueryString["table"]%>','admin')">
<option  value="0">---请选择所属类别---</option>
<%=Sort_List%>
</select>
<input type="hidden" name="sort" id="sort" value="0">
<script type="text/javascript">
var Sort_Type="onlyone";
Write_Select('<%=Request.QueryString["table"]%>','admin');
</script>

</td>
</tr>

 <tr><td align=left width="80px"><input type="checkbox" name='seotitleset' value="1">SEO标题</td>
   <td><input  type="text" name="zdy_Title" Maxlength="100"  size=50></td>
</tr>

<tr><td><input type="checkbox" name='keywordsset' value="1">SEO关键字</td>
<td><input type="text" name="zdy_Keywords" Maxlength="100"  size=50></td>
</tr>

<tr>
<td><input type="checkbox" name='descriptionset' value="1">SEO描述</td>
<td><textarea name="zdy_description" Cols="50" rows="3" onkeyup="if(this.value.length>250){this.value=this.value.substring(0,250)}"></textarea></td>
</tr>

<tr>
<td align=left width='80px'><input type="checkbox" name='permissionsset' value="1">浏览权限</td>
<td>
  <input type="checkbox" name="Visiter_all" id="Visiter_all" value="0"  onclick="select_all()">所有来访者<br>
        <asp:Repeater id="P_permissions" runat="server">
         <ItemTemplate>
           <input type="checkbox" name="Visiter" id="Visiter_<%#DataBinder.Eval(Container.DataItem,"id")%>" value="<%#DataBinder.Eval(Container.DataItem,"id")%>" ><%#DataBinder.Eval(Container.DataItem,"m_type")%>&nbsp;
         </ItemTemplate>
        </asp:Repeater>
      </td>
</tr>

<!--
<tr>
<td align=left><input type="checkbox" name='sxset' value="1">特殊属性</td>
<td><input type="checkbox" name='istop' id='istop' value="1">置顶
<input type="checkbox" name='isgood' id='isgood' value="1">推荐
<input type="checkbox" name='isnew' id='isnew' value="1">最新
<input type="checkbox" name='ishot' id='ishot' value="1">热门
</td>
</tr>
-->

<tr>
<td align=left><input type="checkbox" name='clickset' value="1">点击数+</td>
<td><input type=text name='clicks' id='clicks' Maxlength='10' size='5' value="0" onblur="if(isNaN(value))execCommand('undo')"></td>
</tr>

<tr>
<td align=left><input type="checkbox" name='downloadsset' value="1">下载数+</td>
<td><input type=text name='downloads' id='downloads' Maxlength='10'  size='5' value="0" onblur="if(isNaN(value))execCommand('undo')"></td>
</tr>

<tr>
<td align=left><input type="checkbox" name='reservesset' value="1">库存数+</td>
<td><input type=text name='reserves' id='reserves' Maxlength='10'  size='5' value="0" onblur="if(isNaN(value))execCommand('undo')"></td>
</tr>

<tr><td align=left><input type="checkbox" name='commentset' value="1">评论功能</td>
<td>
<input type="radio" name='comment_open' value="0" checked>关闭
<input type="radio" name='comment_open' id='comment_open_1' value="1">开启&nbsp;
<input type="checkbox" name='comment_check' id='comment_check' value="1" checked>评论需审核
<input type="checkbox" name='comment_anonymous' id='comment_anonymous' value="1" checked>允许匿名评论
</td>
</tr>

<tr><td align=left><input type="checkbox" name='thedateset' value="1">发布日期</td>
<td><input type=text name='thedate' id='thedate' Maxlength='20'  size='18' value="<%=System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")%>"><a href="javascript:open_calendar('thedate',1)"><img src=/e/images/icon/date.gif border=0 height=20 hspace=2 align=absbottom></a></td>
</tr>

<tr><td colspan="2" height="5px"></td></tr>

<tr>
<td align=left>批量替换</td>
<td><select name="replace_field" id="replace_field"><option value="">请选择替换字段</option></select><input type="text" size="18" name="replace_str">替换为<input type="text" size="18" name="replace_result">
</td>
</tr>
</table>
</div>
<div name="tabcontent" id="tabcontent" style="display:none">
 <table border=0 cellpadding=5 cellspacing=0  align=center width=98%>
<tr>
<td align=left width="100px"><input type="checkbox" name='downloadpermissionsset' value="1">附件下载权限</td>
<td>
  <input type="checkbox" name="download_all" id="download_all" value="0"  onclick="select_all('download')">无限制<br>
        <asp:Repeater id="P_DownLoad" runat="server">
         <ItemTemplate>
           <input type="checkbox" name="download" id="download_<%#DataBinder.Eval(Container.DataItem,"id")%>" value="<%#DataBinder.Eval(Container.DataItem,"id")%>" ><%#DataBinder.Eval(Container.DataItem,"m_type")%>&nbsp;
         </ItemTemplate>
        </asp:Repeater>
</td>
</tr>
<tr>
<td align=left><input type="checkbox" name='donwloadpointset' value="1">附件下载积分</td>
<td><input type="textbox" name="point" id="point"  size="10" Maxlength="10" value="0" onkeyup="if(isNaN(value))execCommand('undo')"></td>
</tr>

<tr>
 <td><input type="checkbox" name='ztset' value="1">所属专题<br><span style="color:#999999">双击删除</span></td>
          <td>
<table border=0 cellpadding=2 cellspacing=0>
<tr><td>
<select id="zt_list" name="zt_list" multiple style='width:300px;height:80px' ondblclick="clear_select('zt_list');get_ztids()"></select>
</td>
<td>
<input type="button" value="选择专题" class="bt" onclick="open_ztlist()">
<input type="hidden" id="zt_ids" name="zt_ids">
</td></tr>
</table>
    </td>
      </tr>
</table>
</div>

<br>
<div align="center">
<input type="hidden" value="update" name="post">
<input type="hidden" value="0" id="ids" name="ids">
<input type="hidden" value="" id="sortid" name="sortid">
<input type="hidden" value="<%=Thetable%>" name="table">
<input type="submit" class=button value="提交">
<input type="button" value="关闭" class="button" onclick="parent.ClosePop()";>
</div>
  </td>
  <tr>
 </table>
</form>
</div>
<div id="div2" align="center" style="display:none">
<br><br><br><br><img src="images/suc.png" vspace="5"><br><br>
<a href="#" onclick="restore(1);return false;">点击这里返回提交页面</a></div>
</div>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
var Fields="<%=Fields%>"
var Fields_Name="<%=Fields_Name%>"
var AFields=Fields.split(',');
var AFields_Name=Fields_Name.split(',');
var obj=document.getElementById("replace_field");
for(var i=0;i<AFields.length-1;i++)
 {
    obj.options.add(new Option(AFields_Name[i]+"("+AFields[i].split('|')[0]+")",AFields[i]));
 }
document.getElementById("ids").value=parent.document.getElementById("ids").value;
document.getElementById("sortid").value=parent.document.getElementById("sortid").value;

//其他函数
function lock_mem_check(type)
 {
  if(type=="download")
   {

    for(i=0;i<document.forms[0].download.length;i++)
      {
       document.forms[0].download[i].checked=true;
       document.forms[0].download[i].disabled=true;
      }
   }
  else
   {
    for(i=0;i<document.forms[0].Visiter.length;i++)
      {
        document.forms[0].Visiter[i].checked=true;
        document.forms[0].Visiter[i].disabled=true;
      }
   }
 }

function unlock_mem_check(type)
 {
  if(type=="download")
   {
    for(i=0;i<document.forms[0].download.length;i++)
     {
       //document.forms[0].download[i].checked=false;
       document.forms[0].download[i].disabled=false;
     }
   }
  else
   {
    for(i=0;i<document.forms[0].Visiter.length;i++)
     {
       //document.forms[0].Visiter[i].checked=false;
       document.forms[0].Visiter[i].disabled=false;
     }
   }
 }

function select_all(type)
 {
   var obj;
   if(type=="download")
    {
      obj=document.getElementById("download_all");
    }
  else
    {
      obj=document.getElementById("Visiter_all");
    }

     if(obj.checked)
     {
      lock_mem_check(type);
     }
    else
     {
     unlock_mem_check(type)
     }
 }

function IsExists(Id,id)
 {
   var obj=document.getElementById(Id);
   if(obj.options.length==0){return false;}
   for(i=0;i<obj.options.length;i++)
   {
     if(obj.options[i].value==id)
      {
        return true;
      }
   }
  return false;
 }

function clear_select(Id)
 {
  var obj=document.getElementById(Id);
  if(obj.options.length==0){return;}
  for(i=0;i<obj.options.length;i++)
   {
    if(obj.options[i].selected)
     {
       obj.remove(i);
       clear_select(Id);
     }
   }
 }

function AddSelect(txt,value,id)
 {
   var obj=document.getElementById(id);
   obj.options.add(new Option(txt,value));
   if(id=="zt_list")
    {
      get_ztids();
    }
 }

function get_ztids()
 {
  var obj=document.getElementById("zt_list")
  var obj1=document.getElementById("zt_ids")
  var Ids="";
  if(obj.options.length==0)
   {
     obj1.value="";
     return;
   }
  for(i=0;i<obj.options.length;i++)
   {
     if(Ids=="")
      {
       Ids+=obj.options[i].value;
      }
    else
      {
       Ids+=","+obj.options[i].value;
      }
   }
  obj1.value=Ids;
 }
document.getElementById("Visiter_all").click();
document.getElementById("download_all").click();

function restore(backtype)
 {
   var d1=document.getElementById("div1");
   var d2=document.getElementById("div2");
   if(backtype==1)
    {
      d1.style.display="block";
      d2.style.display="none";
    }
   else
    {
      d2.style.display="block";
      d1.style.display="none";
    }
 }

function c_site(siteid)
 {
   location.href="?table=<%=Request.QueryString["table"]%>&name=<%=Server.UrlEncode(Request.QueryString["name"])%>&siteid="+siteid;
 }

function ShowTab()
 {
  if(GetCookie("tab")!="")
  {
   showtab(GetCookie("tab"));
  }
 }
window.onload=ShowTab;
</script>
</body>
</html>  
