<% @ Page Language="C#" Inherits="PageAdmin.field_add"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95%>
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload()" title="点击刷新"><b><%=Request.QueryString["id"]==null?"增加字段":"修改字段"%>(<%=Request.QueryString["tablename"]%>)</b></a></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<iframe name="post_iframe" id="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form method="post" name="f" target="post_iframe">
<div id="tabdiv">
<ul>
<li id="tab" name="tab"  onclick="showtab(0)" style="font-weight:bold">字段属性</li>
<li id="tab" name="tab"  onclick="showtab(1)">字段自定义</li>
</ul>
</div>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
<div name="tabcontent" id="tabcontent">
<table border=0 cellpadding=5 cellspacing=0 width=98% align=center>
<tr>
  <td height=25 align="right" width="100px" >字段名称：</td>
  <td align="left"><input type="text" name="f_name" id="f_name" size="25" maxlength="50" value="<%=Field_name%>"> * <span style="color:#666666">比如：姓名</span></td>
 </tr>
<tr>
  <td   height=25 align="right"> 字段：</td>
  <td align="left"><input type="text" name="f_field" id="f_field" value="<%=Field==null?FieldPrefix:Field%>"  size="25" maxlength="50" <%=Field==null?"":"readonly"%>> * <span style="color:#666666">字段只能为字母、数字和下划线组成；为避免字段冲突,字段前请加一个前缀，如：pa_</span></td>
 </tr>

<tr>
  <td   height=25 align="right"> 表单类型：</td>
  <td align="left">
<select name="f_type" id="f_type" onchange="T_Change(this.options[this.selectedIndex].value);">
<%if(Field_type==null || (Field_type!="textarea" && Field_type!="editor" && Field_type!="images" && Field_type!="files")){%><option value="text">单行文本(text)</option><%}%>
<%if(Field_type==null || (Field_type!="textarea" && Field_type!="editor" && Field_type!="images" && Field_type!="files")){%><option value="select">下拉列表(select)</option><%}%>
<%if(Field_type==null || (Field_type!="textarea" && Field_type!="editor" && Field_type!="images" && Field_type!="files")){%><option value="radio">单选框(radio)</option><%}%>
<%if(Field_value!="int" && Field_value!="float"  && Field_value!="datetime"){%>
<%if(Field_type==null || (Field_type!="textarea" && Field_type!="editor" && Field_type!="images" && Field_type!="files")){%><option value="checkbox">复选框(checkbox)</option><%}%>
<%if(Field_type==null || Field_type=="textarea" || Field_type=="editor"){%><option value="textarea">多行文本(textarea)</option><%}%>
<%if(Field_type==null || Field_type=="textarea" || Field_type=="editor"){%><option value="editor">编辑器</option><%}%>
<%if(Field_type==null || (Field_type!="textarea" && Field_type!="editor" && Field_type!="images" && Field_type!="files")){%><option value="image">图片</option><%}%>
<%if(Field_type==null || (Field_type=="images" || Field_type=="files")){%><option value="images">图片组</option><%}%>
<%if(Field_type==null || (Field_type!="textarea" && Field_type!="editor" && Field_type!="images" && Field_type!="files")){%><option value="file">附件</option><%}%>
<%if(Field_type==null || (Field_type=="images" || Field_type=="files")){%><option value="files">附件组</option><%}%>
<%}%>
</select>
</td>
 </tr>


<tr id="T_1">
  <td  height=25 align="right">字段值类型：</td>
  <td align="left"><input type="radio"  name="f_value" value="nvarchar" checked>字符串 <span id="span_f_value"><input type="radio"  name="f_value"  value="int" <%=Field_value=="int"?"checked":""%>>整数 <input type="radio"  name="f_value"  value="float" <%=Field_value=="float"?"checked":""%>>小数  <input type="radio"  name="f_value"  value="datetime" <%=Field_value=="datetime"?"checked":""%>>日期</span></td>
</tr>


<tr id="T_2">
  <td   height=25 align="right"> 默认值：</td>
  <td align="left"><input type="text" name="f_dfvalue"  size="25" maxlength="50" value="<%=Field_defaultvalue%>"></td>
 </tr>

<tr id="T_Length">
  <td  height=25 align="right">字段长度：</td>
  <td align="left" title="Access数据库只支持250最大长度，Sql数据库支持4000最大长度"><input type="text" name="f_length"  id="f_length"  size="25" maxlength="4" value="<%=Field_Length==null?"200":Field_Length%>"><input type="hidden" name="f_oldlength" value="<%=Field_Length==null?"100":Field_Length%>"> <span style="color:#666666">字段值类型为“字符串”时此设置才有效</span></td>
</tr>

<tr id="T_fckstyle">
  <td   height=25 align="right">编辑器类型：</td>
  <td align="left"><input type="radio" name="f_fckstyle" value="Small" checked>精简版 <input type="radio" name="f_fckstyle" value="Simple"  <%=Field_fckstyle=="Simple"?"checked":""%>>简化版  <input type="radio" name="f_fckstyle" value="Normal" <%=Field_fckstyle=="Normal"?"checked":""%>>全功能版 </td>
 </tr>

<tr id="T_3">
  <td  height=25 align="right"> 文本框样式：</td>
  <td align="left"><input name="f_style" id="f_style" type="text" size="25" maxlength="100" value="<%=Field_style%>"></td>
 </tr>

<tr id="T_4">
  <td   height=25 align="right"> 选项列表：</td>
  <td align="left"><Textarea name="f_item" id="f_item" cols="50" rows="8" ><%=Field_item%></Textarea> <span style="color:#666666">每行为一个列表选项,值和文本用“,”隔开，如：1,推荐</span>
</td>
 </tr>

<tr id="T_RelationTable">
  <td align="right">关联数据表：</td>
  <td align="left"><select name="f_RelationTable" id="f_RelationTable"><option value="">无设置</option><%=TableList%></select> 
  <input type="radio"  name="f_relation_choicetype" value="0" <%=Filed_relation_choicetype!="1"?"checked":""%>>单选 <input type="radio"  name="f_relation_choicetype" id="f_relation_choicetype_1" value="1" <%=Filed_relation_choicetype=="1"?"checked":""%>>多选
  <input type="checkbox" name="f_relation_sortchoicetype_1" id="f_relation_sortchoicetype_1" value="1" <%=Filed_relation_sortchoicetype!="0"?"checked":""%>>只关联分类(<input type="checkbox" id="f_relation_sortchoicetype_2"  name="f_relation_sortchoicetype_2" value="1" <%=Filed_relation_sortchoicetype=="2"?"checked":""%>>可选择所有分类)
  <br><span style="color:#666666"> 提交后会在表单属性，验证输入框及字段自定义中生成对应的表单代码，可自行修改进行扩展，如需重新生成，请点击</span><input type="button" value="重新生成" class="f_bt" onclick="UpdateFormCode()">
</td>
</tr>

<tr id="T_5">
  <td   height=25 align="right"> 允许的扩展名：</td>
  <td align="left"><input type="text" name="f_ext" id="f_ext" value="<%=Field_ext%>" size="40" maxlength="100"> <span style="color:#666666">多个扩展名请用半角“,”隔开</span> </td>
 </tr>

<tr id="T_6">
  <td   height=25 align="right">文件大小：</td>
  <td align="left"><input type="text" name="f_maxsize" value="<%=Field_maxupload==null?"1024":Field_maxupload%>" size="5" maxlength="10">KB * <span style="color:#666666">提示：限制上传文件最大数值，1 MB = 1024 KB</span> </td>
 </tr>

<tr id="T_num">
  <td   height=25 align="right">文件数上限</td>
  <td align="left"><input type="text" name="f_maxnum" value="<%=Field_maxnum==null?"0":Field_maxnum%>" size="4" maxlength="2"> <span style="color:#666666">限制发布图片组或附件组最大数值，0则不限制</span></td>
 </tr>


<tr id="T_onlyitem">
  <td height=25 align="right">值唯一：</td>
  <td align="left"  title="表示此字段不允许出现重复值"><input type="radio"  name="f_onlyitem" value="1" checked>是 <input type="radio" name="f_onlyitem"  value="0" <%=Field_onlyitem=="0"?"checked":""%>>否</td>
</tr>

<tr>
  <td height=25 align="right">必填项：</td>
  <td align="left"><input type="radio"  name="f_mustitem" value="1" <%=Field_mustitem=="1"?"checked":""%>>是 <input type="radio" name="f_mustitem"  value="0" <%=Field_mustitem!="1"?"checked":""%>>否</td>
 </tr>

<tr>
  <td height=25 align="right">可增加：</td>
  <td align="left"><input type="radio"  name="f_additem" value="1" checked>是 <input type="radio" name="f_additem"  value="0" <%=Field_additem=="0"?"checked":""%>>否  <span style="color:#666666">注：只应用于会员中心</span></td>
</tr>

<tr>
  <td height=25 align="right">可修改：</td>
  <td align="left"><input type="radio"  name="f_edititem" value="1" checked>是 <input type="radio" name="f_edititem"  value="0" <%=Field_edititem=="0"?"checked":""%>>否  <span style="color:#666666">注：只应用于会员中心</span></td>
</tr>

<tr>
  <td height=25 align="right">后台发布项：</td>
  <td align="left" ><input type="radio" name="f_tgitem" value="1" checked>是 <input type="radio" name="f_tgitem"  value="0" <%=Field_masteritem=="0"?"checked":""%>>否  <span style="color:#666"> 注：选择否时，获取表单>发布表单代码中不生成此字段的代码。</span></td>
</tr>

<tr>
  <td height=25 align="right">会员发布项：</td>
  <td align="left"><input type="radio" name="f_tgitem" value="1" checked>是 <input type="radio" name="f_tgitem"  value="0" <%=Field_memberitem=="0"?"checked":""%>>否  <span style="color:#666"> 注：选择否时，获取表单>发布表单代码中不生成此字段的代码。</span></td>
</tr>

<tr id="T_tg" style="display:<%=TheTable=="pa_member"?"none":""%>">
  <td height=25 align="right">匿名投稿项：</td>
  <td align="left" title="如果不选择，获取表单界面的不生成此字段的代码" ><input type="radio"  name="f_tgitem" value="1" checked>是 <input type="radio" name="f_tgitem"  value="0" <%=Field_tgitem=="0"?"checked":""%>>否  <span style="color:#666"> 注：选择否时，获取表单>发布表单代码中不生成此字段的代码。</span></td>
</tr>

<tr id="T_search" style="display:<%=TheTable=="pa_member"?"none":""%>">
  <td   height=25 align="right">搜索字段：</td>
  <td align="left"><input type="radio" name="f_searchitem" value="2" <%=Field_searchitem=="2"?"checked":""%>>精确匹配 <input type="radio"  name="f_searchitem" value="1" <%=Field_searchitem=="1"?"checked":""%>>模糊匹配 <input type="radio" name="f_searchitem"  value="0"  <%=Field_searchitem=="0"?"checked":""%><%=Field_searchitem==null?"checked":""%>>否  <span style="color:#666"> 注：模糊匹配只对文本类型有效</span></td>
</tr>

<tr id="T_search" style="display:<%=TheTable=="pa_member"?"none":""%>">
  <td   height=25 align="right">精确匹配必搜项：</td>
  <td align="left"><input type="radio" name="f_searchmustitem" value="1" <%=Field_searchmustitem=="1"?"checked":""%>>是 <input type="radio" name="f_searchmustitem"  value="0" <%=Field_searchmustitem!="1"?"checked":""%>>否  <span style="color:#666">注：选择否时字段值为空则不进行匹配。</span></td>
</tr>

<tr id="T_collection" style="display:<%=TheTable=="pa_member"?"none":""%>">
  <td   height=25 align="right">采集项：</td>
  <td align="left"><input type="radio"  name="f_collectionitem" value="1" <%=Field_collectionitem=="1"?"checked":""%>>是 <input type="radio" name="f_collectionitem"  value="0" <%=Field_collectionitem!="1"?"checked":""%>>否</td>
</tr>
<tr id="T_sort" style="display:<%=TheTable=="pa_member"?"none":""%>">
  <td   height=25 align="right">排序项：
  <td align="left"><input type="radio"  name="f_sortitem" value="1" <%=Field_sortitem=="1"?"checked":""%>>是 <input type="radio" name="f_sortitem"  value="0" <%=Field_sortitem!="1"?"checked":""%>>否</td>
</tr>

<tr  title="应用于信息发布界面的字段，不选择则不在发布界面显示">
  <td  height=25 align="right">信息发布应用：</td>
  <td align="left">
  <input type="checkbox"  name="f_masteritem" value="1" <%=Field_masteritem=="1"?"checked":""%>>后台信息发布界面显示
  <input type="checkbox"  name="f_memberitem" value="1" <%=Field_memberitem=="1"?"checked":""%>>会员信息发布界面显示
</tr>

<tr title="是否在后台和会员信息列表界面显示" style="display:<%=TheTable=="pa_member"?"none":""%>">
  <td  height=25 align="right">信息管理应用：</td>
  <td align="left">
<input type="checkbox"  name="f_masterlistitem" value="1" <%=Field_masterlistitem=="1"?"checked":""%>>后台信息管理界面显示 
<input type="checkbox"  name="f_memberlistitem" value="1" <%=Field_memberlistitem=="1"?"checked":""%>>会员信息管理界面显示
显示字数：<input name="f_listitem_words" id="f_listitem_words" type="text" size="4" maxlength="3" value="<%=Field_listitem_words==null?"50":Field_listitem_words%>"> <span style="color:#666">数值型和日期型字段不受限制</span>
</td>
</tr>


 <tr id="T_7">
  <td  height=25 align="right">表单属性：</td>
  <td align="left"><Textarea name="f_attribute" id="f_attribute" style="width:80%;height:80px" title="每行一个属性"><%=Field_Attribute%></Textarea></td>
 </tr>

 <tr id="T_js">
  <td  height=25 align="right">提交验证js：</td>
  <td align="left"><Textarea name="f_submit_js" id="f_submit_js" style="width:80%;height:80px" title="在点击提交按钮前进行验证"><%=Field_SubmitJs%></Textarea></td>
 </tr>

<tr>
  <td height=25 align="right">字段提示：</td>
  <td align="left"><input name="f_tip" id="f_style" type="text" size="45" maxlength="50" value="<%=Field_tip%>"></td>
 </tr>

<tr>
  <td height=25 align="right">排列序号：</td>
  <td align="left"><input type="text" name="f_xuhao" id="f_xuhao" size="5" maxlength="3" value="<%=Xuhao==null?"1":Xuhao%>"></td>
</tr>
</table>
</div>
<div name="tabcontent" id="tabcontent" style="display:none">
<table border=0 cellpadding=5 cellspacing=0 width=98% align=center>
<tr>
  <td height=25 align="right" width="100px">后台表单自定义</td>
  <td align="left">
    <table border="0" cellpadding="0" cellspacing="0" width=100%>
     <tr title="后台新增信息的自定义表单"><td width="80px">增加表单</td><td><Textarea name="master_form_add" id="master_form_add" style="width:90%;height:120px" ><%=Master_Form_Add%></Textarea></td></tr>
     <tr title="后台编辑信息的自定义表单"><td width="80px">编辑表单</td><td><Textarea name="master_form_edit" id="master_form_edit"  style="width:90%;height:120px"><%=Master_Form_Edit%></Textarea></td></tr>
     </table>
</td>
</tr>

<tr>
  <td height=25 align="right">会员表单自定义</td>
  <td align="left">
     <table border="0" cellpadding="0" cellspacing="0" width=100%>
     <tr title="会员新增信息的自定义表单"><td width="80px">增加表单</td><td><Textarea name="member_form_add" id="member_form_add"  style="width:90%;height:120px" ><%=Member_Form_Add%></Textarea></td></tr>
     <tr title="会员编辑信息的自定义表单"><td width="80px">编辑表单</td><td><Textarea name="member_form_edit" id="member_form_edit"  style="width:90%;height:120px" ><%=Member_Form_Edit%></Textarea></td></tr>
     </table>
  </td>
</tr>
</table>
<div align="left" style="padding:5px 0 5px 0">
注：自定义的字段表单的name和id都必须和字段一样，如：&lt;input type="text" name="<%=Field==null?"title":Field%>" id="<%=Field==null?"title":Field%>" value="&lt;%=r("<%=Field==null?"title":Field%>")%&gt;"&gt;。
<br>自定义支持asp.net语法，留空则系统自动生成,系统提供三个获取数据的重要函数，如下：
<br>
 r(string field)：参数field为字段名，表示获取数据表中当前记录的字段值，一般用于编辑表单中获取字段数据;
<br>
 Get_Data(string sql)：返回一个DataTable类型数据集，sql语句请自行构造;
<br>
 Get_Data(string field,string sql)：返回一个String类型的值，第一个参数为字段名(如标题字段：title)，第二个参数为自己构造的sql语句，此函数主要用来获取表中某个字段的值。
<br></div>
</div>
</td>
</tr>
</table>
<div align="center" style="padding:5px 0 10px 0">
<input type="hidden" name="field_value" value="<%=Field_value%>">
<input type="hidden" name="post" value="<%=Request.QueryString["act"]%>">
<span id="post_area">
<input type="submit" class=button  value="提交" onclick="return CheckInput()" />
<input type="button" class=button  value="关闭"  onclick="closewin()">
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>                 
</div>
<br>
</form>
<br>
</td>
</tr>
</table>
</center>

<asp:Label id="LblErr" runat="server" />
<script language="javascript">
 var TheTable="<%=TheTable%>";
 var Prev_Xuaho="<%=Request.QueryString["xuhao"]%>";
 if(Prev_Xuaho!="")
  {
   document.getElementById("f_xuhao").value=parseInt(Prev_Xuaho)+1;
  }

var ObJtype=document.getElementById("f_type");
var Obj_fext=document.getElementById("f_ext");

var ObjValue=document.f.f_value;
var Field="<%=Field%>";
var Field_type="<%=Field_type%>";
var Field_Value="<%=Field_value%>";
if(Field_type!="")
{
 ObJtype.value=Field_type;
 for(i=0;i<ObjValue.length;i++)
  {
   ObjValue[i].disabled="disabled";
  }
}

var ObJItem=document.getElementById("f_item");

var T1=document.getElementById("T_1");
var T_length=document.getElementById("T_Length");
var T2=document.getElementById("T_2");
var T3=document.getElementById("T_3");
var T4=document.getElementById("T_4");
var T5=document.getElementById("T_5");
var T6=document.getElementById("T_6");
var T7=document.getElementById("T_7");
var T_search=document.getElementById("T_search");
var T_collection=document.getElementById("T_collection");
var T_sort=document.getElementById("T_sort");
var T_onlyitem=document.getElementById("T_onlyitem");
var T_tg=document.getElementById("T_tg");
var T_fckstyle=document.getElementById("T_fckstyle");
var T_num=document.getElementById("T_num");
var T_RelationTable=document.getElementById("T_RelationTable");
function T_Change(Str)
 {
   document.getElementById("f_name").focus();
   HideAll();
   switch(Str)
    {
      case "text":
        T1.style.display="";
        T_length.style.display="";
        T2.style.display="";
        T3.style.display="";
        T4.style.display="none";
        T5.style.display="none";
        T6.style.display="none";
        T7.style.display="";
        T_search.style.display="";
        T_collection.style.display="";
        T_sort.style.display="";
        T_tg.style.display="";
        T_onlyitem.style.display="";
        T_fckstyle.style.display="none";
        T_num.style.display="none";

      break;

      case "textarea":
        T1.style.display="none";
        T_length.style.display="none";
        T2.style.display="";
        T3.style.display="";
        T4.style.display="none";
        T5.style.display="none";
        T6.style.display="none";
        T7.style.display="";
        T_search.style.display="";
        T_collection.style.display="";
        T_sort.style.display="none";
        T_tg.style.display="";
        T_onlyitem.style.display="none";
        T_fckstyle.style.display="none";
        T_num.style.display="none";

      break;

      case "editor":
        T1.style.display="none";
        T_length.style.display="none";
        T2.style.display="";
        T3.style.display="";
        T4.style.display="none";
        T5.style.display="none";
        T6.style.display="none";
        T7.style.display="none";
        T_search.style.display="";
        T_collection.style.display="";
        T_sort.style.display="none";
        T_tg.style.display="";
        T_onlyitem.style.display="none";
        T_fckstyle.style.display="";
        T_num.style.display="none";

      break;

      case "image":
        ObjValue[0].checked=true;
        document.getElementById("span_f_value").style.display="none";

        T1.style.display="";
        T_length.style.display="";
        T2.style.display="none";
        T3.style.display="";
        T4.style.display="none";
        T5.style.display="";
        T6.style.display="";
        T7.style.display="";
        T_search.style.display="none";
        T_collection.style.display="none";
        T_sort.style.display="none";
        T_tg.style.display="";
        T_onlyitem.style.display="none";
        T_fckstyle.style.display="none";
        T_num.style.display="none";
        <%if(Field_ext==null){Response.Write("Obj_fext.value='.jpg,.jpeg,.gif,.bmp'");}%>
    
      break;

      case "images":
        T1.style.display="none";
        T_length.style.display="none";
        T2.style.display="none";
        T3.style.display="none";
        T4.style.display="none";
        T5.style.display="";
        T6.style.display="";
        T7.style.display="";
        T_search.style.display="none";
        T_collection.style.display="none";
        T_sort.style.display="none";
        T_tg.style.display="none";
        T_onlyitem.style.display="none";
        T_fckstyle.style.display="none";
        T_num.style.display="";

        <%if(Field_ext==null){Response.Write("Obj_fext.value='.jpg,.jpeg,.gif,.bmp'");}%>
      break;

      case "file":
        ObjValue[0].checked=true;
        document.getElementById("span_f_value").style.display="none";

        T1.style.display="";
        T_length.style.display="";
        T2.style.display="none";
        T3.style.display="";
        T4.style.display="none";
        T5.style.display="";
        T6.style.display="";
        T7.style.display="";
        T_search.style.display="none";
        T_collection.style.display="none";
        T_sort.style.display="none";
        T_tg.style.display="";
        T_onlyitem.style.display="none";
        T_fckstyle.style.display="none";
        T_num.style.display="none";
    
        <%if(Field_ext==null){Response.Write("Obj_fext.value='.rar,.zip'");}%>
      break;

      case "files":
        T1.style.display="none";
        T_length.style.display="none";
        T2.style.display="none";
        T3.style.display="none";
        T4.style.display="none";
        T5.style.display="";
        T6.style.display="";
        T7.style.display="";
        T_search.style.display="none";
        T_collection.style.display="none";
        T_sort.style.display="none";
        T_tg.style.display="none";
        T_onlyitem.style.display="none";
        T_fckstyle.style.display="none";
        T_num.style.display="";

        <%if(Field_ext==null){Response.Write("Obj_fext.value='.rar,.zip'");}%>
      break;

      case "checkbox":
        ObjValue[0].checked=true;
        document.getElementById("span_f_value").style.display="none";

        T1.style.display="";
        T_length.style.display="";
        T2.style.display="";
        T3.style.display="none";
        T4.style.display="";
        T5.style.display="none";
        T6.style.display="none";
        T7.style.display="";
        T_search.style.display="";
        T_collection.style.display="";
        T_sort.style.display="";
        T_tg.style.display="";
        T_onlyitem.style.display="none";
        T_fckstyle.style.display="none";
        T_num.style.display="none";

      break;


      case "select":
        T1.style.display="";
        T_length.style.display="";
        T2.style.display="";
        T3.style.display="none";
        T4.style.display="";
        T5.style.display="none";
        T6.style.display="none";
        T7.style.display="";
        T_search.style.display="";
        T_collection.style.display="";
        T_sort.style.display="";
        T_tg.style.display="";
        T_onlyitem.style.display="";
        T_fckstyle.style.display="none";
        T_num.style.display="none";
        if(TheTable!="pa_member")
         {
          T_RelationTable.style.display="";
         }
      break;

      case "radio":
        T1.style.display="";
        T_length.style.display="";
        T2.style.display="";
        T3.style.display="none";
        T4.style.display="";
        T5.style.display="none";
        T6.style.display="none";
        T7.style.display="";
        T_search.style.display="";
        T_collection.style.display="";
        T_sort.style.display="";
        T_tg.style.display="";
        T_onlyitem.style.display="";
        T_fckstyle.style.display="none";
        T_num.style.display="none";

      break;

      default:
        T2.style.display="none";
        T3.style.display="none";
        T4.style.display="";
        T_length.style.display="";
        T5.style.display="none";
        T6.style.display="none";
        T7.style.display="";
        T_search.style.display="";
        T_collection.style.display="";
        T_sort.style.display="";
        T_tg.style.display="";
        T_onlyitem.style.display="none";
        T_fckstyle.style.display="none";
        T_num.style.display="none";

      break;
    }
   <%if(TheTable=="pa_member")
     {
   %>
        T_search.style.display="none";
        T_collection.style.display="none";
        T_sort.style.display="none";
        T_tg.style.display="none";
   <%}%>
 }
function HideAll()
 {
  T1.style.display="none";
  T_length.style.display="none";
  T2.style.display="none";
  T3.style.display="none";
  T4.style.display="none";
  T5.style.display="none";
  T6.style.display="none";
  T_fckstyle.style.display="none";
  T_RelationTable.style.display="none";
  document.getElementById("span_f_value").style.display="";
 }

T_Change(ObJtype.value);

function CheckInput()
 {
  var Dbtype=<%=Dbtype%>;
  var Val=document.getElementById("f_name");
  var f_length=document.getElementById("f_length");
  Val.value=Trim(Val.value);
  if(Val.value=="")
   {
    alert("请填写字段名称!");
    Val.focus();
    return false;
   }
  Val=document.getElementById("f_field");
  if(Val.value=="")
   {
    alert("请填写字段!");
    Val.focus();
    return false;
   }

  if(Val.value=="pa_")
   {
    alert("请填写完整的字段,比如:pa_xingming");
    Val.focus();
    return false;
   }
  if(Val.value.length<2)
   {
    alert("字段名至少为2个字符！");
    Val.focus();
    return false;
   }
   var keys=new Array("index","order","by","select","top","asc","desc","count","sum","link","update","insert","to","values","where");
   if(IsContains(Val.value,keys))
     {
      alert("请更换一个字段名，"+Val.value+"为sql保留关键词！");
      Val.focus();
      return false;
     }
  if(T_length.style.display=="")
   {
      if(isNaN(f_length.value) || f_length.value=="0" || Trim(f_length.value)=="")
       {
        alert("请填写正确的字段值长度。");
        f_length.focus();
        return false;
       }
    var val_length=parseInt(f_length.value);
    if(Dbtype==0)
     {
      if(val_length<1 || val_length>250)
       {
        alert("您正使用Access数据库，字符串类型字段长度必须控制在1-250之间!");
        f_length.focus();
        return false;
       }
     }
    else
     {
      if(val_length<1 || val_length>4000)
       {
        alert("字符串类型字段长度必须控制在1-4000之间!");
        f_length.focus();
        return false;
       }
     }
   }
  if(Trim(Val.value)=="pa_")
   {
    alert("请填写完整的字段,比如:pa_xingming");
    Val.focus();
    return false;
   }

  if(ObJtype.value=="select" ||  ObJtype.value=="radio" || ObJtype.value=="checkbox")
   {
      if(Trim(ObJItem.value)=="")
       {
         //alert("请填写选项列表!");
         //ObJItem.focus();
         //return false;
       }
      else
       {
         if(ObJItem.value.indexOf("|")>=0)
          {
            alert("选项列表不能带'|'字符!");
            ObJItem.focus();
            return false;
          }
         var Items=Trim(ObJItem.value).replace(/\n/ig,"|");
         var AItems=Items.split('|');
         for(i=0;i<AItems.length;i++)
          {
            if(AItems[i].indexOf(",")<=0)
             {
                //alert("选项列表第"+(i+1)+"行格式错误,格式为：列表值,列表文本!");
                //ObJItem.focus();
                //return false;
             }
          }
       }
   }
  if(ObJtype.value=="image" ||  ObJtype.value=="images" || ObJtype.value=="file" || ObJtype.value=="files")
   {
     if(Obj_fext.value=="")
      {
       alert("请正确填写允许的扩展名!");
       Obj_fext.focus();
       return false;
     }
   }
  InsertFormCode();//插入关联表代码
  startpost();
 }

function Trim(str)  //去除空格 
 { 
  var Astr=str.split('');
  var str1="";
  for(i=0;i<Astr.length;i++)
   {
    str1+=Astr[i].replace(" ","");
   }
  return str1;
 }

var cxuhao=0,closewinrefresh=0;
function postover(ptype)
 {
   if(ptype=="add")
    {
      alert("增加成功!");
      closewinrefresh=1;
      cxuhao=document.forms["f"].f_xuhao.value;
      document.forms["f"].reset();
      T_Change("text");
      if(IsDigit(cxuhao))
       {
        document.forms["f"].f_xuhao.value=parseInt(cxuhao)+1;
       }
    }
   else if(ptype=="edit")
    {
      alert("提交成功!");
      closewinrefresh=1;
    }
   else
    {
      alert(ptype);
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

function UpdateFormCode()
 {
 if(confirm("是否确定重新生成关联代码，这将导致当前的表单自定义代码被全部替换。"))
  {
  Id("master_form_add").value="";
  Id("master_form_edit").value="";
  Id("member_form_add").value="";
  Id("member_form_edit").value="";
  Id("f_attribute").value="";
  Id("f_submit_js").value="";
  InsertFormCode();
  }
 }

function InsertFormCode()
 {
   var field=Id("f_field").value;
   var table=Id("f_RelationTable").value;
   var f_relation_choicetype_1=Id("f_relation_choicetype_1"); //单选或多选
   var f_relation_sortchoicetype_1=Id("f_relation_sortchoicetype_1");
   var f_relation_sortchoicetype_2=Id("f_relation_sortchoicetype_2");
   var SortChoiceType=0;
   var IsMultipl=0;
   var tit="选择关联信息";
   var loadjs_fun="load_ajaxdata(\""+table+"\",\"<"+"%=r(\""+field+"\")%"+">\",\""+field+"\")";
   if(f_relation_sortchoicetype_1.checked)
    {
      SortChoiceType=1;
      if(f_relation_sortchoicetype_2.checked)
      {
       SortChoiceType=2;
      }
      tit="选择关联分类";
     loadjs_fun="load_ajaxdata(\"pa_sort\",\"<"+"%=r(\""+field+"\")%"+">\",\""+field+"\")";
    }
   var f_type=Id("f_type").value;
   if(f_type!="select"){return;}
   if(f_relation_choicetype_1.checked)
    {
     IsMultipl=1;
    }
  if(field==""){return;}
  if(table==""){return;}
  var f_attribute=Id("f_attribute");
  var f_submit_js=Id("f_submit_js");
  var f_attribute_value=f_attribute.value;
  var f_submit_js_value=f_submit_js.value;
  if(IsMultipl==1 && f_attribute_value.indexOf("multiple")<0)
   {
    f_attribute_value+="\r\nmultiple";
    if(f_attribute_value.indexOf("size=")<0)
     {
      f_attribute_value+="\r\nsize=\"10\"";
     }
    f_attribute_value+="\r\ntitle=\"双击删除\"";
   }
  else if(IsMultipl==0)
   {
    f_attribute_value=f_attribute_value.replace("multiple","");
   }
  if(f_attribute_value.indexOf("clear_select(")<0)
   {
    f_attribute_value+="\r\nondblclick=\"clear_select('"+field+"');\"";
   }
  if(f_attribute_value.indexOf("style=")<0)
   {
    f_attribute_value+="\r\nstyle=\"width:300px;\"";
   }
  f_attribute.value=Trim(f_attribute_value);
  if(f_submit_js_value.indexOf("Set_Selected(")<0 && IsMultipl==1)
   {
   f_submit_js_value+="\r\nSet_Selected(\"select-all\",\""+field+"\");";
   }
  if(IsMultipl==0)
   {
     f_submit_js_value=f_submit_js_value.replace("Set_Selected(\"select-all\",\""+field+"\");","");
   }
   f_submit_js.value=Trim(f_submit_js_value);

  var master_form_add=Id("master_form_add");
  var master_form_edit=Id("master_form_edit");
  var member_form_add=Id("member_form_add");
  var member_form_edit=Id("member_form_edit");
  var add_form,edit_form
  if(SortChoiceType>0) //选择分类
   {
    add_form="<!--add-->\r\n<br><input type=\"button\" value=\""+tit+"\" class=\"f_bt\" onclick='Sort_Select(\""+tit+"\",\"0\",Current_SiteId,\""+table+"\",Tg_Table,\""+field+"\","+IsMultipl+","+SortChoiceType+",true,800,450)'>";
    edit_form="<!--add-->\r\n<s"+"cript type=\"text/javascript\">"+loadjs_fun+"</s"+"cript><br><input type=\"button\" value=\""+tit+"\" class=\"f_bt\" onclick='Sort_Select(\""+tit+"\",\"0\",Current_SiteId,\""+table+"\",Tg_Table,\""+field+"\","+IsMultipl+","+SortChoiceType+",true,800,450)'>";
   }
  else //选择数据
   {
    add_form="<!--add-->\r\n<br><input type=\"button\" value=\""+tit+"\" class=\"f_bt\" onclick='Data_Select(\""+tit+"\",\"0\",Current_SiteId,\""+table+"\",Tg_Table,\""+field+"\","+IsMultipl+",true,800,450)'>";
    edit_form="<!--add-->\r\n<s"+"cript type=\"text/javascript\">"+loadjs_fun+"</s"+"cript><br><input type=\"button\" value=\""+tit+"\" class=\"f_bt\" onclick='Data_Select(\""+tit+"\",\"0\",Current_SiteId,\""+table+"\",Tg_Table,\""+field+"\","+IsMultipl+",true,800,450)'>";
   }
  if(Trim(master_form_add.value)=="")
  {
   master_form_add.value=add_form;
  }
  if(Trim(member_form_edit.value)=="")
  {
   master_form_edit.value=edit_form;
  }
  if(Trim(member_form_add.value)=="")
  {
   member_form_add.value=add_form;
  }
  if(Trim(member_form_edit.value)=="")
  {
   member_form_edit.value=edit_form;
  }
}
</script>
</body>
</html> 