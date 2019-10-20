<% @ Page Language="C#" Inherits="PageAdmin.task_add"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="basic_task"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95%>
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b><%=Request.QueryString["id"]==null?"增加计划任务":"编辑计划任务"%></b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top  align="left">
<iframe name="post_iframe" id="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form  method="post" target="post_iframe">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
<table border=0 cellpadding=2 cellspacing=0 width=98% align=center>
 </tr>
  <tr>
  <td height=22 width=100px>任务名称</td>
  <td><input name="name" id="name" type="text" maxlength="50" size="30" value="<%=Name%>"></td>
  </tr>

  <tr>
  <td height=22 width=100px>任务类型</td>
  <td><select name="task_type" id="task_type" onchange="type_Change()">
        <option value='0'>自定义文件</option>
        <%if(Is_Static=="1"){%><option value='1'>刷新栏目静态页</option>
        <option value='2'>刷新专题静态页</option><%}%>
        <option value='3'>刷新幻灯片Js文件</option>
        <option value='4'>刷新站内广告Js文件</option>
      </select>
  </td>
  </tr>

 <tr id="tr_ids" style="display:none">
  <td height=25 width=100px>刷新列表<br><input type="button" value=" 选择 " class="f_bt" onclick="Data_Select()"></td>
  <td>
     <div style="clear:both;overflow:hidden">
     <div style="float:left;margin-right:10px">
      <div id="text_1">栏目列表</div>
      <select name="build_ids" id="build_ids" style="min-width:200px;height:200px" multiple ondblclick="clear_select('build_ids')">
      </select>
      </div>
     <div style="float:left;display:none" id="div_build_ids_1">
      <div id="text_2">子栏目列表</div>
      <select name="build_ids_1" id="build_ids_1" size="10" style="min-width:200px;height:200px" multiple ondblclick="clear_select('build_ids_1')">
      </select>
     </div>
      </div>
     <span style="color:#666">双击可以删除选中的项目</span>
 </td>
 </tr>


<tr id="tr_fileurl" style="display:none">
  <td height=25 width=100px>执行文件名</td>
  <td><input name="fileurl" id="fileurl" type="text" maxlength="50" size="35" value="<%=FileUrl%>"> <span style="color:#666666">如：task.aspx，不填写路径则默认/e/task目录下的文件。</td>
 </tr>

 <tr id="tr_description" style="display:none">
  <td height=25 width=100px>任务描述</td>
  <td><textarea name="description" id="description" cols="40" rows="3"><%=Description%></textarea></td>
 </tr>

 <tr>
  <td height=22 width=100px>任务启用</td>
  <td><input name="isopen" id="isopen" type="radio" value=1 checked>启用 &nbsp;<input name="isopen" id="isopen" type="radio" value=0 <%=IsOpen=="0"?"checked":""%>>关闭</td>
 </tr>

 <tr>
  <td height=22 width=100px>是否循环</td>
  <td><input name="isloop" id="isloop" type="radio" value=1 checked>循环执行 &nbsp;<input name="isloop" id="isloop"  type="radio" value=0 <%=IsLoop=="0"?"checked":""%>>仅执行一次<span style="color:#666666">(执行后自动关闭任务)</span></td>
 </tr>

 <tr>
  <td height=25 width=100px>执行周期</td>
  <td><input name="do_cycle" id="do_cycle" type="radio" value="month" checked>每月 &nbsp;<input name="do_cycle" id="do_cycle"  type="radio" value="week" <%=Do_Cycle=="week"?"checked":""%>>每周 &nbsp;<input name="do_cycle" id="do_cycle"  type="radio" value="day" <%=Do_Cycle=="day"?"checked":""%>>每天</td>
 </tr>

 <tr>
  <td height=25 width=100px>每月几号执行</td>
  <td><select name="do_day" id="do_day" style="width:100px;" size="10" multiple>
      <option value='1'>1</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option><option value='16'>16</option><option value='17'>17</option><option value='18'>18</option><option value='19'>19</option><option value='20'>20</option><option value='21'>21</option><option value='22'>22</option><option value='23'>23</option><option value='24'>24</option><option value='25'>25</option><option value='26'>26</option><option value='27'>27</option><option value='28'>28</option><option value='29'>29</option><option value='30'>30</option><option value='31'>31</option>
      </select>
      <br><span style="color:#666666">执行周期为”每月“时有效，选择多个可以按住CTRL键选择，不选择则默认每月1号执行</span>
  </td>
 </tr>

  <tr>
  <td height=25 width=100px>每周星期几执行</td>
  <td>
      <select name="do_week" id="do_week" style="width:100px;" size="5" multiple>
          <option value="1">星期一</option>
          <option value="2">星期二</option>
          <option value="3">星期三</option>
          <option value="4">星期四</option>
          <option value="5">星期五</option>
          <option value="6">星期六</option>
          <option value="7">星期日</option>
       </select><br>
      <span style="color:#666666">执行周期为”每周“时有效，选择多个可以按住CTRL键选择，不选择则默认星期一执行</span>
   </td>
  </tr>

  <tr>
  <td height=25 width=100px>每天几点执行</td>
  <td>
      <select name="do_hour" id="do_hour" style="width:100px;" size="10" multiple>
       <option value='0'>0</option><option value='1'>1</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option><option value='16'>16</option><option value='17'>17</option><option value='18'>18</option><option value='19'>19</option><option value='20'>20</option><option value='21'>21</option><option value='22'>22</option><option value='23'>23</option>
     </select><br>
<span style="color:#666666">选择多个可以按住CTRL键选择，不选择则默认1点执行（耗时任务请选择访问人数比较少的时段运行）</span>
  </td>
  </tr>

  <tr>
  <td height=25 width=100px>任务截止日期</td>
  <td><input name="enddate" id="enddate" type="text" maxlength="10" value="<%=EndDate%>"><a href="javascript:open_calendar('enddate')"><img src=images/calendar_bnt.gif border=0 height=20 hspace=2 align=absbottom></a>  <span style="color:#666666">到期后自动关闭</span></td>
  </tr>

  <tr id="tr_parameter" style="display:none">
  <td height=25 width=100px>get参数</td>
  <td><textarea name="parameter" id="parameter" cols="60" rows="5"><%=Parameter%></textarea><br><span style="color:#666666">格式如：id=5 ，多个参数用"&"连接</span></td>
  </tr>

</table>
</td>
</tr>
</table>

<br>
<div align=center>
<input type="hidden" name="tijiao" value="yes">
<span id="post_area">
<input type="submit" class=button id="Bt_Submit" value="提交" onclick="return C_Form()">
<input type="button" class=button value="关闭"  onclick="closewin()">
</span>  
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>  
</div>
<br>
</form>
</td>
</tr>
</table>
</center>
</body>
<script type="text/javascript">
 var do_day="<%=Do_Day%>";
 var do_week="<%=Do_Week%>";
 var do_hour="<%=Do_Hour%>";
 var objday=document.getElementById("do_day");
 var objweek=document.getElementById("do_week");
 var objhour=document.getElementById("do_hour");
 var task_type=document.getElementById("task_type");
 var parameter=document.getElementById("parameter");
 Set_Selected(do_day,"do_day")
 Set_Selected(do_week,"do_week")
 Set_Selected(do_hour,"do_hour")
 task_type.value="<%=Task_Type%>";

 
function C_Form()
  {
     Set_Selected("select-all","build_ids");
     Set_Selected("select-all","build_ids_1");
     var obj=document.getElementById("name");
     if(obj.value=="")
     {
       alert("请填写任务名称!");
       obj.focus();
       return false;
     }
     obj=document.getElementById("fileurl");
     if(task_type.value!="0")
      {
       obj.value="build_html.aspx";
      }
     if(obj.value=="")
     {
       alert("请填写要执行的文件名!");
       obj.focus();
       return false;
     }
     var str_parameter="";
     if(task_type.value=="1" || task_type.value=="2")
      {
        str_parameter="lanmuids="+Get_Selected("build_ids")+"&sublanmuids="+Get_Selected("build_ids_1");
      }
     else if(task_type.value=="3")
      {
        str_parameter="slideids="+Get_Selected("build_ids");
      }
     else if(task_type.value=="4")
      {
        str_parameter="advids="+Get_Selected("build_ids");
      }
    if(task_type.value!="0")
     {
       parameter.value=str_parameter;
     }
   startpost();
  }

var closewinrefresh=0;
function task_postover(ptype)
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

function type_Change()
 {
   var task_type=document.getElementById("task_type").value;
   var build_ids=document.getElementById("build_ids");
   build_ids.options.length=0;
   var build_ids_1=document.getElementById("build_ids_1");
   build_ids_1.options.length=0;
   if(task_type=="0")
    {
       document.getElementById("tr_ids").style.display="none";
       document.getElementById("tr_fileurl").style.display="";
       document.getElementById("tr_parameter").style.display="";
   }
  else
    {
      if(task_type=="1" || task_type=="2")
       {
        document.getElementById("div_build_ids_1").style.display="";
       }
     else
       {
        document.getElementById("div_build_ids_1").style.display="none";
       }
      document.getElementById("tr_ids").style.display="";
      document.getElementById("tr_fileurl").style.display="none";
      document.getElementById("tr_parameter").style.display="none";
      var text_1=document.getElementById("text_1");
      var text_2=document.getElementById("text_2");
      if(task_type=="1")
       {
        text_1.innerHTML="栏目列表";
        text_2.innerHTML="子栏目列表";
       }
      else if(task_type=="2")
       {
        text_1.innerHTML="专题栏目列表";
        text_2.innerHTML="专题子栏目列表";
       }
      else if(task_type=="3")
       {
        text_1.innerHTML="幻灯片列表";
       }
      else
       {
        text_1.innerHTML="Js广告列表";
       }
    }
 }
type_Change();

function AddSelect(ids,type)
 {
    var obj;
    if(type=="sublanmu")
     {
      obj=document.getElementById("build_ids_1");
     }
    else
     {
      obj=document.getElementById("build_ids");
     }
   var backstr="";
   var x=new PAAjax();
   x.setarg("get",false);
   x.send("get_taskids.aspx","ids="+ids+"&type="+type,function(v){backstr=v;});
   Abackstr=backstr.split("{|}");
   var AAbackstr;
   for(var i=0;i<Abackstr.length;i++)
    {
     if(Abackstr[i]==""){continue}
     AAbackstr=Abackstr[i].split("{,}");
     if(AAbackstr.length==2 && !CheckRepeat(obj,AAbackstr[0]))
      {
       obj.options.add(new Option(AAbackstr[1],AAbackstr[0]));
      }
    }
 }

var Task_Type="<%=Task_Type%>";
var Parameter="<%=Parameter%>";
switch(Task_Type)
 {

   case "4":
     AddSelect(Request("advids",Parameter),"adv");
   break;

   case "3":
     AddSelect(Request("slideids",Parameter),"slide");
   break;

   default:
   if(Task_Type=="1" || Task_Type=="2")
    {
     AddSelect(Request("lanmuids",Parameter),"lanmu");
     AddSelect(Request("sublanmuids",Parameter),"sublanmu");
    }
   break;

 }

function CheckRepeat(op_obj,id)
 {
   for(i=0;i<op_obj.length;i++)
     {
       if(op_obj[i].value==id)
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

function Data_Select()
 {
   var task_type=document.getElementById("task_type").value;
   var url="task_lanmu_list.aspx";
   switch(task_type)
    {
      case "2":
        url="task_zt_list.aspx";
      break;
      case "3":
        url="task_slide_list.aspx";
      break;
      case "4":
        url="task_adv_list.aspx";
      break;
    }
   IDialog("刷新列表选择界面",url,"85%","85%");
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
