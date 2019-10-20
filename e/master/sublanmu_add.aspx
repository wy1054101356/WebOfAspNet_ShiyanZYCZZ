<% @ Page Language="C#" Inherits="PageAdmin.sublanmu_add"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" type="lanmu_nav"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<script src="pinyin.js" type="text/javascript"></script>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>增加子栏目</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top  align="left">
<iframe name="post_iframe" id="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form method="post" name="f1" target="post_iframe">
<div id="tabdiv">
<ul>
<li id="tab" name="tab" onclick="location.href='sublanmu_list.aspx?iszt=<%=Request.QueryString["iszt"]%>&lanmuid=<%=Request.QueryString["lanmuid"]%>&navid=<%=Request.QueryString["navid"]%>&lanmuname=<%=Server.UrlEncode(Request.QueryString["lanmuname"])%>&navname=<%=Server.UrlEncode(Request.QueryString["navname"])%>'">子栏目管理</li>
<li id="tab" name="tab" style="font-weight:bold">增加子栏目</li>
</ul>
</div>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
  <table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
  <tr><td height=25><b>当前位置：</b><%=Request.QueryString["lanmuname"]%> &gt; <%=Request.QueryString["navname"]%> &gt; 增加子栏目</td></tr>
 </table>

<div name="tabcontent" id="tabcontent">
<table border=0 cellpadding=5 cellspacing=0 width=95% align=center>
  <tr>
  <td  height=25>父属子栏目</td>
  <td> <select size="10" name="Parent_SubLanmu" id="Parent_SubLanmu" style="width:500px;">
	<option value="0|0|0|"'>一级子栏目</option>
        <%=Parent_List%>
       </select>
  </td>
 </tr>

  <tr>
  <td height=25 width=100px>子栏目名称</td>
  <td><input name="SubLanmu_Name"  id="SubLanmu_Name" type="text" maxlength="50" size="45" onblur="getpy('SubLanmu_Name','SubLanmu_Dir')"></td>
  </tr>

  <tr>
  <td  height=25 width=100px>是否最终子栏目</td>
  <td><input  type="radio" name="IsFinal"  id="IsFinal_1" checked value="1" onclick="Change_Final()">是 &nbsp;<input  type="radio" name="IsFinal" id="IsFinal_0" value="0" onclick="Change_Final()">否&nbsp;&nbsp;注：最终栏目下不能继续增加子栏目</td>
 </tr>

  <tr id="tr_type">
  <td  height=25 width=100px>子栏目类型</td>
  <td><select name="SubLanmu_Type" id="SubLanmu_Type">
        <option value="zdy">自定义内容</option>
        <%=Table_List%>
       </select> 
 </td>
 </tr>


 <tr id="Tr_Dir">
  <td  height=25 width=100px>静态文件生成目录</td>
  <td title="必填项，只能由字母、数字或下划线组成"> <select name="Lanmu_Dir" id="Lanmu_Dir">
   <option value="/">请选择父目录</option>
   <option value="<%=Lanmu_Dir%>" selected><%=Lanmu_Dir%></option>
   <option value="">空</option></select>/<input name="SubLanmu_Dir" type="text" maxlength="40" id="SubLanmu_Dir" size="15" ><input name="SubLanmu_File" type="hidden" id="SubLanmu_File" value="index.html"> 注：只能由字母，数字和下划线组成，如需减少目录层次，父目录可设置为空</td>
 </tr>

  <tr id="Tr_Url">
  <td  height=25 width=100px>自定义url</td>
  <td><input name="SubLanmu_Url" id="SubLanmu_Url" type="text" maxlength="50" size="45" > 如：http://bbs.pageadmin.net</td>
  </tr>

  <tr>
  <td  height=25 width=100px>链接目标</td>
  <td><select name="SubLanmu_Target" id="SubLanmu_Target"><option value="_self">本窗口</option><option value="_blank">新窗口</option></select></td>
  </tr>

  <tr>
  <td  height=25 width=100px>是否显示</td>
  <td><select name="SubLanmu_Show" id="SubLanmu_Show"><option value="1">显示</option><option value="0">隐藏</option></select></td>
  </tr>

  <tr>
  <td  height=25 width=100px>序号</td>
    <td><input name="Xuhao" id="Xuhao" type="text" maxlength="5"  size="4" value="1" onkeyup="if(isNaN(value))execCommand('undo')"></td>
 </tr>
</table>
</div>
</td>
</tr>
</table>
<br>
<div align=center>
<input type="hidden" name="Site_Dir" value="<%=Site_Dir%>">
<input type="hidden" name="LanmuDate"  value="<%=Lanmu_Date%>">
<input type="hidden" name="post" value="add">
<span id="post_area">
<input type="submit" class=button value="提交" onclick="return C_Form()" id="Bt_Submit">
<input type="button" class=button value="返回"  onclick="location.href='sublanmu_list.aspx?iszt=<%=Request.QueryString["iszt"]%>&lanmuid=<%=Request.QueryString["lanmuid"]%>&navid=<%=Request.QueryString["navid"]%>&lanmuname=<%=Server.UrlEncode(Request.QueryString["lanmuname"])%>&navname=<%=Server.UrlEncode(Request.QueryString["navname"])%>'">
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
 var Prev_Xuaho="<%=Request.QueryString["xuhao"]%>";
 var IsFinal="<%=Request.QueryString["isfinal"]%>";
 if(Prev_Xuaho!="")
  {
    if(IsFinal=="0")
     {
      document.getElementById("IsFinal_0").click();
     }
   document.getElementById("Xuhao").value=parseInt(Prev_Xuaho)+1;
   document.getElementById("Parent_SubLanmu").value="<%=Request.QueryString["parentlanmu"]%>";
   if("<%=Request.QueryString["thetype"]%>"!="")
    {
      document.getElementById("SubLanmu_Type").value="<%=Request.QueryString["thetype"]%>";
    }
  }

 function C_Form()
  {
    var obj=document.getElementById("Parent_SubLanmu")
    if(obj.selectedIndex==-1)
     {
       alert("请选择父属子栏目!");
       return false;
     }
    if(obj.options[obj.selectedIndex].value=="")
     {
       alert("父属栏目不能选择最终子栏目!");
       obj.selectedIndex=-1;
       return false;
     }

     obj=document.getElementById("SubLanmu_Name");
     if(obj.value=="")
     {
       alert("请填写子栏目名称!");
       obj.focus();
       return false;
     }
     obj=document.getElementById("Lanmu_Dir");
     if(obj.value=="/")
     {
       alert("请选择父目录");
       obj.focus();
       return false;
     }
     obj=document.getElementById("SubLanmu_Dir")
      if(obj.value=="")
       {
       alert("静态文件生成目录必须填写!");
       obj.focus();
       return false;
       }
      else if(!IsStr(obj.value))
       {
        alert("目录名称只能由字母、数字和下划线组成");
        obj.focus();
        return false;
       }
    startpost();
  }

function Change_Final()
 {
  var objSelect=document.getElementById("SubLanmu_Type");
  var obj1=document.getElementById("IsFinal_1");
  var obj2=document.getElementById("IsFinal_2");
  var tr_type=document.getElementById("tr_type");
  if(obj1.checked)
   {
     for(var i=0;i<objSelect.options.length;i++)
         {
           if(objSelect.options[i].value =="")
             {
               objSelect.remove(i);
               break;
             }
         }  
   }
  else
   {
     var item=new Option("节点页","");
     objSelect.options.add(item,0);
     objSelect.options[0].style.color="#ff0000";
     objSelect.selectedIndex=0;
   }
 }



function getpy(id,tid)
{
  var str=Trim(document.getElementById(id).value);
  if(str == "") return;
  var arrRslt=makePy(str);
  var T= document.getElementById(tid);
  T.value=arrRslt;
}
SetCookie("currentnode","");
SetCookie("currentnodes","");
</script>
</html>  