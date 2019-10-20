<% @ Page Language="C#" Inherits="PageAdmin.sort_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="sort_list" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>分类管理</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top  align="left">
<form method="post" name="f">
<div id="tabdiv">
<ul>
<li id="tab" name="tab"  style="font-weight:bold">类别管理</li>
<li id="tab" name="tab" onclick="location.href='sort_add.aspx?table=<%=Request.QueryString["table"]%>&tid=<%=Request.QueryString["tid"]%>&name=<%=Server.UrlEncode(Request.QueryString["name"])%>'">增加新类别</li>
</ul>
</div>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>

<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr>
  <td  colspan=2 height=25><b>所属表：</b><%=Request.QueryString["name"]%></td>
 </tr>
</table>

    <table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
      <tr>
        <td  colspan=2 height=25>
            <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle id="tb_sortlist">
                <tr>
                  <td align=center width=10% class=white  height=20>ID</td>
                  <td align=center width=55% class=white height=20>类别</td>
                  <td align=center width=10% class=white>序号</td>
                  <td align=center width=25% class=white>管理</td>
                </tr>
                <%=Str_Sort_List%>
                <tr  style="display:<%=Sort_List==null?"none":""%>">
                  <td colspan="4" align="left" class="tdstyle">
<input type="button" class="button" value="反选" onclick="CheckBox_Inverse('CK')"/>
<input type="button" value="更新" class="button" id="sbt" onclick="set('update')"/>
<%if(The_table!="pa_zt"){%>[<a href="javascript:set('pset')">批设属性</a>]<%}%>
[<a href="javascript:set('pdelete')">删除</a>]
<%if(The_table!="pa_zt"){%>
<select name="t_final" id="t_final"><option value="">最终类别属性转换</option><option value="1">转为最终类别</option><option value="0">转为非最终类别</option></select>
<input type="button" class="button" value="转换" onclick="set('final')"/>
<select name="tosortid" id="tosortid"><option value="">最终类别转移</option><option value="0">根类别</option><%=Sort_List%></select>
<input type="button" class="button" value="转移" onclick="set('transfer')"/>
<%}%>
</td>
</tr>
</table>
<input type="hidden" value=""  name="ids" id="ids">
<input type="hidden" value="0" name="delid" id="delid">
<input type="hidden" value="update" name="act" id="act">
       </td>
    </tr>
   </table>
  </td>
  <tr>
 </table>
<br>注：点击<Img src=images/folder_close.gif height=16px align=absmiddle>图标可以展开下属子类。
</form>

</td>
</tr>
</table>
</center>
</body>
<script type="text/javascript">
MouseoverColor("tb_sortlist");
var RootIds="<%=RootIds%>";
var ChildIds="<%=ChirldIds%>";
function HideAll()
 {
    var obj;
    var AIds=RootIds.split(',');
    for(i=0;i<AIds.length;i++)
     {
      obj=document.getElementById("span_"+AIds[i])
      if(obj!=null)
      obj.className="folder_2";
     }

    AIds=ChildIds.split(',');
    for(i=0;i<AIds.length;i++)
     {
       if(AIds[i]!="")
       {
        obj=document.getElementById("tr_"+AIds[i]);
        if(obj==null)continue;
        obj.style.display="none";
        obj=document.getElementById("span_"+AIds[i]);
        if(obj!=null)
         {
          if(obj.className!="file"){obj.className="folder_2"}
         }
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


HideAll();

if(GetCookie("currentnode")!="")
 {
   ShowByCookie();
 }

function Del(did)
 {
   if(confirm("确定删除吗?"))
   {
     document.getElementById("delid").value=did;
     document.getElementById("act").value="del";
     document.forms[0].submit();
   }
 }

function List(id)
 {
   var TheTable="<%=The_table%>";
   var TableType="<%=TableType%>"
   location.href="data_list.aspx?table="+TheTable+"&name=<%=Server.UrlEncode(Request.QueryString["name"])%>&sortid="+id;
 }

function set(act)
 {
   var Ids=Get_Checked("CK");
   var A_Ids=Ids.split(",");
   var obj_isfinal;
   if(Ids=="")
    {
      alert("请选择要操作的类别!");
      return;
    }
   switch(act)
    {
     case "transfer":
       if(document.getElementById("tosortid").value=="")
       {
         alert("请选中要转移目录类别!");
         document.getElementById("tosortid").focus();
         return;
       }

      for(i=0;i<A_Ids.length;i++)
       {  
          obj_isfinal=document.getElementById("isfinal_"+A_Ids[i]);
          if(obj_isfinal.value=="0")
          {
            alert("只能对最终类别进行转移!");
            return;   
          }
       }

      if(!confirm("是否确定?"))
       {
         return;
       }
     break;

    case "final":
     {
       if(document.getElementById("t_final").value=="")
       {
         alert("请选中要转换的最终属性!");
         document.getElementById("t_final").focus();
         return;
       }
       if(document.getElementById("t_final").value=="1")
        {
          for(i=0;i<A_Ids.length;i++)
          {  
            obj_isfinal=document.getElementById("isfinal_"+A_Ids[i]);
            if(obj_isfinal.value=="1")
            {
             alert("只能对非最终类别进行转换!");
             return;   
            }
          }
         if(!confirm("要转换为最终类别，对应类别下不能有子类别，否则将不进行转换。\r是否确定转换!"))
         {
           return;
         }
        }
      else
        {
          for(i=0;i<A_Ids.length;i++)
          {  
            obj_isfinal=document.getElementById("isfinal_"+A_Ids[i]);
            if(obj_isfinal.value=="0")
            {
             alert("只能对最终类别进行转换!");
             return;   
            }
          }
         if(!confirm("如果转换为非最终类别，对应类别下的信息分类id将丢失。\r是否确定转换!"))
         {
           return;
         }
        }

     }
     break;

    case "pdelete":
     if(!confirm("是否确定删除?"))
      {
        return;
      }
    break;

    case "pset":
     Sort_Set("","<%=The_table%>");
     document.getElementById("ids").value=Ids;
     return;
    break;

    }

  document.getElementById("act").value=act;
  document.getElementById("ids").value=Ids;
  document.forms[0].submit();
 }
</script>
</html>  



