<% @ Page Language="C#" Inherits="PageAdmin.sublanmu_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" type="lanmu_nav"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload(true)" title="点击刷新"><b>子栏目管理</b></a></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top  align="left">

<form method="post">
<div id="tabdiv">
<ul>
<li id="tab" name="tab" style="font-weight:bold">子栏目管理</li>
<li id="tab" name="tab" onclick="location.href='sublanmu_add.aspx?iszt=<%=Request.QueryString["iszt"]%>&lanmuid=<%=Request.QueryString["lanmuid"]%>&navid=<%=Request.QueryString["navid"]%>&lanmuname=<%=Server.UrlEncode(Request.QueryString["lanmuname"])%>&navname=<%=Server.UrlEncode(Request.QueryString["navname"])%>'">增加子栏目</li>
</ul>
</div>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>

<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr>
  <td  colspan=2 height=25><b>当前位置：</b><a href=<%if(IsZt==1){%>zt_list.aspx<%}else{%>lanmu_list.aspx<%}%>><%if(IsZt==1){%>专题管理<%}else{%>栏目管理<%}%>(<%=Request.QueryString["lanmuname"]%>)</a> &gt; 子栏目管理</td>
 </tr>
</table>

    <table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
      <tr>
        <td  colspan=2 height=25>
            <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle id="tb_sublanmulist">
                <tr>
                  <td align=center width=5% class=white  height=20>选择</td>
                  <td align=center width=35% class=white  height=20>名称</td>
                  <td align=center width=10% class=white  height=20>类型</td>
                  <td align=center width=5% class=white  height=20>目录</td>
                  <td align=center width=10% class=white  height=20>目标</td>
                  <td align=center width=10% class=white  height=20>显示</td>
                  <td align=center width=5% class=white>序号</td>
                  <td align=center width=20% class=white>管理</td>
                </tr>
                  <%=Str_List%>
              <%if(Options_List!=null){%>
                <tr>
                  <td colspan="9" align="left" class="tdstyle">
<input type="button" class="button" value="反选" onclick="CheckBox_Inverse('CK')"/>
<input type="button" value="更新" id="sbt" class="button" onclick="set('update')">
<%if(Is_Static=="1"){%><input type="button" class="button" value="生成" onclick="build_htm()" title="生成静态文件"><%}%>
[<a href="javascript:set('pset')">批设属性</a>]
[<a href="javascript:set('pdelete')">删除</a>]
<select name="t_final" id="t_final"><option value="">最终子栏目属性转换</option><option value="1">转为最终子栏目</option><option value="0">转为非最终子栏目</option></select>
<input type="button" class="button" value="转换" onclick="set('final')"/>

<select name="toid" id="toid"><option value="0">一级子栏目</option><%=Options_List%></select>
<input type="button" class="button" value="转移" onclick="set('transfer')"/></td>
               </tr><%}%>
              </table>

        <div align=center style="padding:10px 0 5px 0">
<input type="hidden" value=""  name="ids" id="ids">
<input type="hidden" value="0"  name="delid" id="delid">
<input type="hidden" value="" name="act" id="act">
<input type="button" class=button  value="返回"  onclick="back()">                 
        </div>
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
MouseoverColor("tb_sublanmulist");
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

function Module_Set(Id)
 {
  var sublanmuname=document.getElementsByName("Name$"+Id)[0].value;
  location.href="module_list.aspx?iszt=<%=Request.QueryString["iszt"]%>&lanmuid=<%=Request.QueryString["lanmuid"]%>&lanmuname=<%=Server.UrlEncode(Request.QueryString["lanmuname"])%>&navid=<%=Request.QueryString["navid"]%>&navname=<%=Server.UrlEncode(Request.QueryString["navname"])%>&sublanmuid="+Id;
 }

function Set(Id,thetable)
 {
  var url="sublanmu_set.aspx?id="+Id+"&table="+thetable+"&lanmuid=<%=Request.QueryString["lanmuid"]%>&navid=<%=Request.QueryString["navid"]%>";
  IDialog("子栏目设置",url,"95%","90%");
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

function set(act)
 {

   var Ids=Get_Checked("CK");
   var A_Ids=Ids.split(",");
   var obj_isfinal;
   if(Ids=="")
    {
      alert("请选择要操作的子栏目!");
      return;
    }
   switch(act)
    {

     case "transfer":
      if(document.getElementById("toid").value=="")
      {
        alert("转移目标不能选择最终子栏目!");
        document.getElementById("toid").focus();
        return ;
      }
      for(i=0;i<A_Ids.length;i++)
       {  
          obj_isfinal=document.getElementById("isfinal_"+A_Ids[i]);
          if(obj_isfinal.value=="0")
          {
            alert("只能对最终子栏目进行转移!");
            return;   
          }
       }

      if(!confirm("是否确定?"))
       {
         return;
       }
     break;

     case "final":
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
            alert("只能对非最终子栏目进行转换!");
            return;   
           }
          }

          if(!confirm("要转换为最终子栏目，对应子栏目下不能包含子栏目，否则将不进行转换。\r是否确定转换!"))
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
            alert("只能对最终子栏目进行转换!");
            return;   
           }
          }

          if(!confirm("是否确定转换为非最终子栏目!"))
          {
           return;
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
     Sublanmu_PSet("<%=Request.QueryString["navname"]%>");
     document.getElementById("ids").value=Ids;
     return;
    break;
    }

  document.getElementById("act").value=act;
  document.getElementById("ids").value=Ids;
  document.forms[0].submit();
 }

function Sublanmu_PSet(name)
 {
   IDialog("子栏目批设置",'sublanmu_pset.aspx?lanmuid=<%=Request.QueryString["lanmuid"]%>&name='+encodeURI(name),800,500);
 }

function build_htm()
 {
  var Ids=Get_Checked("CK");
  if(Ids=="")
   {
     alert("请选择要生成的子栏目!");
     return;
   }
  var Width=400;
  var Height=180;
  IDialog("子栏目页静态生成","static_panel.aspx?table=pa_sublanmu&lanmuids=<%=Lanmu_Id%>&sublanmuids="+Ids,Width,Height);
 }

function back()
 {
  var curl="nav_list.aspx?iszt=<%=Request.QueryString["iszt"]%>&lanmuid=<%=Request.QueryString["lanmuid"]%>&lanmuname=<%=Server.UrlEncode(Request.QueryString["lanmuname"])%>";
  location.href=curl;
 }
</script>
</html>  



