<% @ Page Language="C#" Inherits="PageAdmin.sort_add"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="sort_list" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>增加类别</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top  align="left">
<iframe name="post_iframe" id="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form method="post" target="post_iframe" >
<div id="tabdiv">
<ul>
<li id="tab" name="tab" onclick="location.href='sort_list.aspx?table=<%=Request.QueryString["table"]%>&tid=<%=Request.QueryString["tid"]%>&name=<%=Server.UrlEncode(Request.QueryString["name"])%>'">类别管理</li>
<li id="tab" name="tab" style="font-weight:bold">增加新类别</li>
</ul>
</div>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center class=table_style2>
  <tr>
  <td valign=top>

  <table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
  <tr><td  height=25 ><b>所属表</b>：<%=Request.QueryString["name"]%></td></tr>
  </table>

<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
 </tr>
  <tr>
  <td  height=25 width=100px>类别名称</td>
  <td><input name="Sort_Name" id="Sort_Name" type="text"  id="Sort_Name" size="45" ></td>
 </tr>

  <tr>
  <td  height=25>父属类别</td>
  <td> <select size="20" name="Parent_Sort" id="Parent_Sort" style="width:500px;">
	<option value="0|0|0|" <%=ZtDisplay=="none"?"selected":""%>>根类别</option>
        <%=Parent_Sort_List%>
       </select>
  </td>
 </tr>

  <tr title="最终类别可以发布信息，不能再分子类别,非最终类别可以分子类，但是不可以发布信息" style="display:<%=ZtDisplay%>">
  <td  height=25 width=100px>是否最终类别</td>
  <td><input id="type_1" type="radio" name="Sort_type"  checked value="1" >是 &nbsp;<input id="type_2" type="radio" name="Sort_type" value="0">否&nbsp;&nbsp;</td>
 </tr>

  <tr>
  <td  height=25 width=100px>序号</td>
    <td><input name="Xuhao" id="Xuhao" type="text" maxlength="5"  size="4" value="1" onkeyup="if(isNaN(value))execCommand('undo')"></td>
 </tr>
</table>
</td>
</tr>
</table>

<br>
<div align=center>
<input type="hidden" name="tijiao"   value="yes">
<span id="post_area">
<input type="submit" class=button   value="提交" onclick="return C_Form()">
<input type="button" class=button  value="返回"  onclick="location.href='sort_list.aspx?table=<%=Request.QueryString["table"]%>&tid=<%=Request.QueryString["tid"]%>&name=<%=Server.UrlEncode(Request.QueryString["name"])%>'"> 
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>
</div>
</form>
</td>
</tr>
</table><br>
</center>
</body>
<script type="text/javascript">
 var Prev_Xuaho="<%=Request.QueryString["xuhao"]%>";
 var IsFinal="<%=Request.QueryString["isfinal"]%>";
 if(Prev_Xuaho!="")
  {
    document.getElementById("Xuhao").value=parseInt(Prev_Xuaho)+1;
    document.getElementById("Parent_Sort").value="<%=Request.QueryString["parentsort"]%>";
    if(IsFinal=="0")
     {
      document.getElementById("type_2").click();
     }
  }

 function C_Form()
  {
     var obj=document.getElementById("Sort_Name");
     if(obj.value=="")
     {
       alert("请填写类别名称!");
       obj.focus();
       return false;
     }

    obj=document.getElementById("Parent_Sort")
    if(obj.selectedIndex==-1)
     {
       alert("请选择父属类别!");

       return false;
     }
    if(obj.options[obj.selectedIndex].value=="")
     {
       alert("父属类别不能选择最终类别!");
       obj.selectedIndex=-1;
       return false;
     }
   startpost();
  }
SetCookie("currentnode","");
SetCookie("currentnodes","");
</script>
</html>  



