<% @ Page Language="C#" Inherits="PageAdmin.department_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="member_department" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>部门管理</b></td></tr>
 <tr><td height=10 ></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<form runat="server">

<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
     <table border=0 cellpadding=0 cellspacing=0 width=95%  class=tablestyle align=center id="tb_list">
       <tr>
          <td height=25 align=center width=5% style="max-width:50px"class=white>部门ID</td>
          <td height=25 align=center width=55% class=white>部门名称</td>
          <td height=25 align=center width=20%  class=white>序号</td>
          <td height=25 align=center width=20%  class=white>操作</td>
        </tr>
        <%=Str_DepartmentList%>
 <tr  style="display:<%=Str_DepartmentList==""?"none":""%>">
 <td colspan="4" align="left" class="tdstyle">
<input type="button" class="button" value="反选" onclick="CheckBox_Inverse('CK')"/>
<input type="button" value="更新" class="button" id="sbt" onclick="set('update')"/>
[<a href="javascript:set('pdelete')">删除</a>]
[<a href="javascript:set('pset')">批设功能</a>]
<select name="todepartmentid" id="todepartmentid"><option value="0">一级部门</option><%=DepartmentList%></select>
<input type="button" class="button" value="转移" onclick="set('transfer')"/>
</td>
</tr>
    </table>
<input type="hidden" value=""  name="ids" id="ids">
<input type="hidden" value="0" name="delid" id="delid">
<input type="hidden" value="" name="act" id="act">
  </td>
  <tr>
 </table>
<div style="padding:5px 0 10px 0">
注：部门设置优先于会员类别设置。
</div>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">

    <table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
    <tr>
    <td height=25><b>增加部门</b></td>
   </tr>
    </table>
    <table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
    <tr>
    <td height=25>
   上级部门：<select name="Add_ParentId"><option value="0">一级部门</option><%=DepartmentList%></select>
   名称：<asp:TextBox  id="Add_Name" maxlength="50" size="30"  runat="server" />
   序号：<asp:TextBox  id="Add_Xuhao" Text="1"  maxlength="5" size="3"  runat="server" />
   <asp:button  CssClass="button" Text="增加"  runat="server" OnClick="Data_Add" OnclientClick="return AddCheck()"/>
    </td>
   </tr>
    </table>
  </td>
  <tr>
 </table>

<br>
<asp:Label id="LblErr" runat="server" />
</form>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
MouseoverColor("tb_list");
function Set(name,Id,type)
 {
  General_Set(name,"member_center_set.aspx?thetype=department&id="+Id);
 }

function Del(did)
 {
   if(confirm("此操作将导致部门下的所有用户的部门属性被重置，确定删除吗?"))
   {
     document.getElementById("delid").value=did;
     document.getElementById("act").value="del";
     document.forms[0].submit();
   }
 }

function AddCheck()
 {
  Add_Name=document.getElementById("Add_Name");
  if(Add_Name=="")
   {
    alert("请填写部门名称!");
    return false;
   }
  SetCookie("currentnode","");
  SetCookie("currentnodes","");
  return true;
 }

function set(act)
 {
   var Ids=Get_Checked("CK");
   var A_Ids=Ids.split(",");
   if(Ids=="")
    {
      alert("请选择要操作的部门!");
      return;
    }
   switch(act)
    {
     case "transfer":
      var todepartmentid=document.getElementById("todepartmentid").value;
      var ckobj;
      for(i=0;i<A_Ids.length;i++)
       {  
          if(A_Ids[i]==""){continue;}
          if(todepartmentid==A_Ids[i])
          {
            alert("要转移的部门不能包含目标部门!");
            return;   
          }
         ckobj=document.getElementById("ck_"+A_Ids[i])
         if(ckobj.value=="1")
          {
            alert("要转移的部门不能包含有下级部门!");
            return;   
          } 
       }

      if(!confirm("是否确定转移?"))
       {
         return;
       }
     break;

    case "pdelete":
     if(!confirm("此操作将导致部门下的所有用户的部门属性被重置，确定删除吗?"))
      {
        return;
      }
    break;

    case "pset":
      General_Set("用户功能批量设置","member_center_set.aspx?act=pset&thetype=department&id="+Ids);
      return;
    break;

    }
  document.getElementById("act").value=act;
  document.getElementById("ids").value=Ids;
  document.forms[0].submit();
 }


function ShowObjs(Ids,SubIds,id)
 {
    var currentnode=GetCookie("currentnode");
    var currentnodes=GetCookie("currentnodes");
    var Show="";
    var obj;
    var AIds=SubIds.split(',');
    obj=document.getElementById("span_"+id);
    if(obj==null){return}
   if(obj.className=="folder_1")
    {
     obj.className="folder_2";
     Show="none";
     currentnode=ReplaceAll(currentnode,","+id+",",",");
     SetCookie("currentnode",currentnode);
    }
   else
    {
     obj.className="folder_1";
     Show="";
     if(currentnode=="")
      {
       SetCookie("currentnode",","+id+",");
       SetCookie("currentnodes",","+SubIds+",");
      }
     else
      {
       SetCookie("currentnode",currentnode+id+",");
      }

    }
    for(i=0;i<AIds.length;i++)
     {
       if(AIds[i]!="")
       {
        currentnodes=GetCookie("currentnodes");
        obj=document.getElementById("tr_"+AIds[i]);
        if(obj==null){continue;}
        obj.style.display=Show;
        obj=document.getElementById("span_"+AIds[i]);
         if(Show=="")
          {
            //if(obj.className!="file"){obj.className="folder_1"}
            SetCookie("currentnodes",currentnodes+AIds[i]+",");
          }
         else
          {
            if(obj.className!="file"){obj.className="folder_2"}
            currentnodes=ReplaceAll(currentnodes,","+AIds[i]+",",",");
            SetCookie("currentnodes",currentnodes);
          }
       }
    }
   if(Show==""){return}
   AIds=Ids.split(',');
    for(i=0;i<AIds.length;i++)
     {
       if(AIds[i]!="")
       {
        currentnodes=GetCookie("currentnodes");
        obj=document.getElementById("tr_"+AIds[i]);
        if(obj==null){continue;}
        obj.style.display="none";

        obj=document.getElementById("span_"+AIds[i]);
        if(obj.className!="file"){obj.className="folder_2"}
        currentnodes=ReplaceAll(currentnodes,","+AIds[i]+",",",");
        SetCookie("currentnodes",currentnodes);
        currentnode=ReplaceAll(currentnode,","+AIds[i]+",",",");
        SetCookie("currentnode",currentnode);
       }
     }
 }
function ShowByCookie()
 {
    var obj;
    var currentnode=GetCookie("currentnode");
    var currentnodes=GetCookie("currentnodes");
    var Acurrentnode=currentnode.split(',');
    for(i=0;i<Acurrentnode.length;i++)
     {
      obj=document.getElementById("span_"+Acurrentnode[i]);
      if(obj!=null)
       {
         if(obj.className!="file"){obj.className="folder_1"}
       }
     }
   var AIds=currentnodes.split(',');
   for(i=0;i<AIds.length;i++)
     {
       if(AIds[i]!="")
       {
        obj=document.getElementById("tr_"+AIds[i]);
        if(obj!=null)
         {
          obj.style.display="";
         }
        obj=document.getElementById("span_"+AIds[i]);
        if(obj!=null)
         {
           //if(obj.className!="file"){obj.className="folder_1"}
         }
      }
    }

 }
if(GetCookie("currentnode")!="")
 {
   ShowByCookie();
 }
</script>
</body>
</html>