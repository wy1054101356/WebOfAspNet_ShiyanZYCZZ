<% @ Page Language="C#" Inherits="PageAdmin.lanmu_add"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="lanmu_ztlist"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<script src="pinyin.js" type="text/javascript"></script>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>增加专题</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top  align="left">
<iframe name="post_iframe" id="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form method="post" name="f1" target="post_iframe">
<div id="tabdiv">
<ul>
<li id="tab" name="tab" onclick="location.href='zt_list.aspx'">专题管理</li>
<li id="tab" name="tab" style="font-weight:bold">增加专题</li>
</ul>
</div>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
  <table border=0 cellpadding=0 cellspacing=0 width=95% align=center>
  <tr><td  height=25><b>当前操作</b>：增加专题</td></tr>
 </table>
<table border=0 cellpadding=5 cellspacing=0 width=95% align=center>
 </tr>
  <tr>
  <td height=25 width=100px>专题名称</td>
  <td><input name="Lanmu_Name" id="Lanmu_Name" type="text" maxlength="99" size="50" onblur="getpy('Lanmu_Name','Lanmu_Dir')"></td>
 </tr>

  <tr>
  <td height=25 width=100px>栏目类型</td>
  <td><input type="radio" name="Lanmu_Type" value="home" onclick="Change_Type(this.value)" style="display:none"><input type="radio" name="Lanmu_Type" value="normal" checked  onclick="Change_Type(this.value)">专题栏目  <input type="radio" name="Lanmu_Type" value="external"  onclick="Change_Type(this.value)" style="display:none"></td>
  </tr>


  <tr id="Tr_Dir">
  <td  height=25 width=100px>静态生成目录</td>
  <td>
  <table border=0 cellspacing=0>
  <tr><td  height=15  align=center>父目录</td><td align=center id="td_dir1">栏目目录</td><td align=left id="td_dir2" style="display:none">栏目文件名</td></tr>
  <tr><td  height=20>/<%=Parent_Dir%></td>
  <td id="td_dir3" title="只能由字母、数字或下划线组成,可留空"><input name="Lanmu_Dir" type="text" maxlength="50" id="Lanmu_Dir" size="30" ></td>
  <td id="td_dir4" style="display:none" title="必填项，只能由字母、数字或下划线组成">/<input name="Lanmu_File" type="text" maxlength="30" id="Lanmu_File" size="15" value="index"><select name="Lanmu_File_Suffix"><option value=".html" checked>.html</option><option value=".htm">.htm</option><option value=".shtml">.shtml</option></select> 注：填写后不可修改</td></tr>
  </table>
</td>
  </tr>

  <tr id="Tr_Url" style="display:none">
  <td  height=25 width=100px>自定义url</td>
  <td><input name="Lanmu_Url" type="text" maxlength="50" id="Lanmu_Url" size="40" > 如：http://bbs.pageadmin.net</td>
  </tr>

  <tr style="display:none">
  <td  height=25 width=100px>链接目标</td>
  <td><select name="Lanmu_Target" id="Lanmu_Target"><option value="_self">本窗口</option><option value="_blank">新窗口</option></select></td>
  </tr>

  <tr style="display:none">
  <td  height=25 width=100px>是否显示</td>
  <td><select name="Lanmu_Show" id="Lanmu_Show"><option value="1">显示</option><option value="0">隐藏</option></select></td>
  </tr>

  <tr style="display:none">
  <td  height=25 width=100px>序号</td>
    <td><input name="Xuhao" id="Xuhao" type="text" maxlength="5"  size="4" value="1" onkeyup="if(isNaN(value))execCommand('undo')"></td>
  </tr>

  <tr>
   <td  height=25 width=100px>专题时间</td>
   <td><input name="thedate" id="thedate" type="text" maxlength="20"  size="18" value="<%=DateTime.Now.ToString()%>"></td>
  </tr>
</table>
</td>
</tr>
</table>

<br>
<div align=center>
<input type="hidden" name="iszt" value="1">
<input type="hidden" name="tijiao"   value="yes">
<span id="post_area">
<input type="submit" class=button  value="提交" onclick="return C_Form()" id="Bt_Submit">
<input type="button" class=button  value="返回"  onclick="location.href='zt_list.aspx'">
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
 var Prev_Xuaho="<%=Request.QueryString["xuhao"]%>";
 if(Prev_Xuaho!="")
  {
   document.getElementById("Xuhao").value=parseInt(Prev_Xuaho)+1;
  }

 function C_Form()
  {
     var obj=document.getElementById("Lanmu_Name");
     if(obj.value=="")
     {
       alert("请填写专题名称!");
       obj.focus();
       return false;
     }
    var Ltype=document.f1.Lanmu_Type;

    obj=document.getElementById("Lanmu_Url")
    if(Ltype[2].checked && obj.value=="")
     {
       alert("请填写自定义url!");
       obj.focus();
       return false;
     }

    obj=document.getElementById("Lanmu_Dir")
    if(Ltype[1].checked)
     {
      if(obj.value=="")
       {
        alert("栏目目录必须填写!");
        obj.focus();
        return false;
       }
      else if(!IsStr(ReplaceAll(obj.value,"/","")))
         {
          alert("栏目目录只能由字母、数字和下划线组成");
          obj.focus();
          return false;
         }
      else if(obj.value.length>50)
         {
          alert("栏目目录长度请控制在50个字符以内");
          obj.focus();
          return false;
         }
       obj=document.getElementById("Lanmu_File")
      if(obj.value=="")
       {
       alert("栏目文件必须填写!");
       obj.focus();
       return false;
       }
      else if(!IsStr(obj.value))
       {
        alert("栏目文件名称只能由字母、数字和下划线组成");
        obj.focus();
        return false;
       }

     }
   startpost();
  }

function Change_Type(type)
 {
  var objurl=document.getElementById("Tr_Url");
  var objdir=document.getElementById("Lanmu_Dir")
  var objtrdir=document.getElementById("Tr_Dir");
  var objtddir1=document.getElementById("td_dir1");
  var objtddir3=document.getElementById("td_dir3");
   switch(type)
    {
     case "external":
        objdir.value="";
        objurl.style.display="";
        objtrdir.style.display="none";
     break;

     case "normal":
        objurl.style.display="none";
        objtrdir.style.display="";
        objtddir1.style.display="";
        objtddir3.style.display="";
     break;
 
     case "home":
        objdir.value="";
        objurl.style.display="none";
        objtrdir.style.display="";
        objtddir1.style.display="none";
        objtddir3.style.display="none";
     break;
 
    }
 }
obj= document.getElementsByName("Lanmu_Type");
for(i=0;i<obj.length;i++)
{
 if(obj[i].checked)
  {
   Change_Type(obj[i].value);
   break;
  }
}


function getpy(id,tid)
{
  var str=Trim(document.getElementById(id).value);
  if(str == "") return;
  var arrRslt=makePy(str);
  var T= document.getElementById(tid);
  T.value="special/"+arrRslt;
}
</script>
</html>