<% @ Page Language="C#" Inherits="PageAdmin.sublanmu_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="basic_task"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top  align="left">
<form method="post">

<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>

<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr>
  <td  colspan=2 height=25><b>当前位置：</b><a href=<%if(IsZt==1){%>task_zt_list.aspx<%}else{%>task_lanmu_list.aspx<%}%>><%if(IsZt==1){%>专题管理<%}else{%>栏目管理<%}%>(<%=Request.QueryString["lanmuname"]%>)</a> &gt; 子栏目列表</td>
 </tr>
</table>

    <table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
      <tr>
        <td  colspan=2 height=25>
            <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle id="tb_sublanmulist">
                <tr>
                  <td align=center width=5% class=white  height=20>选择</td>
                  <td align=center width=95% class=white  height=20>名称</td>
                </tr>
                  <%=Str_List_1%>
                <tr>
                  <td colspan="2" align="left" class="tdstyle"><input type="button" class="button" value="反选" onclick="CheckBox_Inverse('CK')"/> 
<input type="button" class="button" value="选择" onclick="Get_Select()"/>
</td>
               </tr>
              </table>

        <div align=center style="padding:10px 0 5px 0">
<input type="hidden" value=""  name="ids" id="ids">
<input type="hidden" value="0"  name="delid" id="delid">
<input type="hidden" value="" name="act" id="act">
<input type="button" class=button  value="返回"  onclick="back()">&nbsp;
<input type="button" value="关闭" class="button" id="sbt" onclick="parent.CloseDialog()"/>            
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
var parentobj=parent.document.getElementById("build_ids_1");
var parentids="";
for(i=0;i<parentobj.length;i++)
 {
   parentids+=parentobj[i].value+",";
 }
Set_Disabled(parentids,"CK");
function Get_Select()
 {
  var Ids=Get_Checked("CK");
  var txt;
  if(Ids=="")
   {
     alert("请选择要刷新的子栏目!");
     return;
   }
  parent.AddSelect(Ids,"sublanmu");
 }

function Set_Disabled(ckvalue,objname)
 {
  var obj=document.getElementsByName(objname);
  var Ackvalue=ckvalue.split(',');
  for(i=0;i<Ackvalue.length;i++)
   {
     for(k=0;k<obj.length;k++)
      {
        if(obj[k].value==Ackvalue[i])
         {
          obj[k].disabled=true;
         }
      }
   }
}


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


function back()
 {
  var curl="task_nav_list.aspx?iszt=<%=Request.QueryString["iszt"]%>&lanmuid=<%=Request.QueryString["lanmuid"]%>&lanmuname=<%=Server.UrlEncode(Request.QueryString["lanmuname"])%>";
  location.href=curl;
 }
</script>
</html>  



