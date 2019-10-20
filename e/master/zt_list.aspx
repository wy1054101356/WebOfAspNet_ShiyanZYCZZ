<% @ Page Language="C#" Inherits="PageAdmin.zt_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="lanmu_ztlist"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload()" title="点击刷新"><b>专题管理</b></a></td></tr>
 <tr><td height=10 ></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<div id="tabdiv">
<ul>
<li id="tab" name="tab" style="font-weight:bold">专题管理</li>
<li id="tab" name="tab" onclick="location.href='zt_add.aspx'">增加专题</li>
</ul>
</div>
<form runat="server">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
<table border=0 cellpadding=0 cellspacing=0 width=95%  style="table-layout:fixed;" align=center>
<tr>
<td align="left" width="110px">
每页<asp:TextBox id="Tb_pagesize" style="width:30px" maxlength="10"  Runat="server"/>条记录
</td>
<td align="right">
<select id="s_order" onchange="Go()">
<option value="id desc">按ID↓</option>
<option value="id">按ID↑</option>
</select>

按日期
<input name="StartDate" id="StartDate" Maxlength="10" size="6"><a href="javascript:open_calendar('StartDate')"><img src=images/calendar_bnt.gif border=0 height=20 hspace=2 align=absbottom></a> 
到 
<input name="EndDate" id="EndDate" Maxlength="10" size="6"><a href="javascript:open_calendar('EndDate')"><img src=images/calendar_bnt.gif border=0 height=20 hspace=2 align=absbottom></a> 

关键字<input text="text" id="s_keyword" style="width:80px">
<select id="s_field">
<option value="name">标题</option>
<option value="username">用户名</option>
</select>
<input type="button" value="确定" class="button" onclick="Go()">
 </td>
 </tr>
</table>

<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
      <tr>
        <td  align="left">
            <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle  id="tb_list">
                <tr>
                  <td align=center class=white width=40%>专题名</td>
                  <td align=center class=white>ID</td>
                  <td align=center class=white height=20>提交时间</td>
                  <td align=center class=white height=20>发布人</td>
                  <td align=center class=white height=20>信息</td>
                  <td align=center class=white>管理</td>
                </tr>
          <asp:Repeater id="P1" runat="server" OnItemDataBound="Data_Bound">         
             <ItemTemplate>
                 <tr class="listitem">
                  <td align=left class="tdstyle" noWrap><input type="checkbox" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>"><a href="<%#Get_Url(DataBinder.Eval(Container.DataItem,"id").ToString(),DataBinder.Eval(Container.DataItem,"thetype").ToString(),DataBinder.Eval(Container.DataItem,"lanmu_dir").ToString(),DataBinder.Eval(Container.DataItem,"zdy_url").ToString())%>" target=_blank><span style="color:<%#DataBinder.Eval(Container.DataItem,"show").ToString()=="1"?"#333":"#999"%>"><%#Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"name").ToString())%></span></a></td>
                  <td align=center class=tdstyle noWrap><%#DataBinder.Eval(Container.DataItem,"id")%></td>
                  <td align=center class="tdstyle" noWrap title="<%#DataBinder.Eval(Container.DataItem,"thedate")%>"><%#DataBinder.Eval(Container.DataItem,"thedate")%></td>
                  <td align=center class=tdstyle noWrap><a href='member_info.aspx?username=<%#Server.UrlEncode(DataBinder.Eval(Container.DataItem,"username").ToString())%>'><%#DataBinder.Eval(Container.DataItem,"username")%></a></td>
                  <td align=center class=tdstyle noWrap><a href="javascript:View_Data(<%#DataBinder.Eval(Container.DataItem,"id")%>,'<%#Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"name").ToString())%>')">查看</a></td>
                  <td align=center class="tdstyle" noWrap>
                   <asp:Hyperlink id="Nav_Set" runat="server" Text="导航管理"   NavigateUrl='<%#"nav_list.aspx?iszt=1&lanmuid="+DataBinder.Eval(Container.DataItem,"id")+"&lanmuname="+Server.UrlEncode(DataBinder.Eval(Container.DataItem,"name").ToString())%>' />
                   <asp:Hyperlink id="Module_Set" runat="server" Text="模块管理"  visible="true" NavigateUrl='<%#"module_list.aspx?iszt=1&lanmuid="+DataBinder.Eval(Container.DataItem,"id")+"&lanmuname="+Server.UrlEncode(DataBinder.Eval(Container.DataItem,"name").ToString())%>' />
                   <asp:Hyperlink id="Lanmu_Set"  runat="server"  NavigateUrl='<%#"javascript:Lanmu_Set(\"lanmu_set.aspx?&id="+DataBinder.Eval(Container.DataItem,"id")+"\",\""+DataBinder.Eval(Container.DataItem,"name").ToString()+"\")"%>'  Text="专题设置" />
                   <a href="javascript:del('<%#DataBinder.Eval(Container.DataItem,"id")%>','<%#DataBinder.Eval(Container.DataItem,"name").ToString()%>')">删除</a>
                  </td>
                </tr>
             </ItemTemplate>
          </asp:Repeater>
<tr>
<td colspan="6" class=tdstyle>
<input type="hidden" value="" name="ids" id="ids">
<input type="hidden" value="" name="act" id="act">
<input type="hidden" value="" name="delname" id="delname">
<input type="button" class="button" value="反选" onclick="CheckBox_Inverse('CK')"/>
<%if(Is_Static=="1")
 {
%>
         <select name="htmltype" id="htmltype">
         <option value="0">生成专题封面静态页</option>
         <option value="1">生成专题子栏目静态页</option>
         </select>&nbsp;<input type="button" class="button" value="生成" onclick="html()">
<%}%>
[<a href="javascript:set('pset')">批设属性</a>] [<a href="javascript:set('pdelete')">删除</a>]
          </td>
         </tr>
</td></tr></table> 
<br>
共<asp:Label id="Lblrecordcount"  Text=0 runat="server" />条记录 
&nbsp;当前页次: <asp:Label id="Lblcurrentpage"  runat="server" />/<asp:Label id="LblpageCount"  runat="server" />&nbsp;
<asp:Button  text="上一页"  id="LblPrev"  cssclass="button"  runat="server"  CommandName="Prev"   OnCommand="Bt_Click" />&nbsp;
<asp:Button  text="下一页"  id="LblNext"  cssclass="button"  runat="server"  CommandName="Next"   OnCommand="Bt_Click" />&nbsp;
转到:&nbsp;<asp:DropDownList id="DLpage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Page_Changed"  /> 页&nbsp;

       </td>
    </tr>
   </table>
  </td>
  <tr>
 </table>
</form>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
 MouseoverColor("tb_list");
 var obj_field=document.getElementById("s_field");
 var obj_order=document.getElementById("s_order");
 var obj_keyword=document.getElementById("s_keyword");
 var obj_pagesize=document.getElementById("Tb_pagesize");
 var obj_date1=document.getElementById("StartDate");
 var obj_date2=document.getElementById("EndDate");

 var Table="pa_zt";
 var tablename="专题列表";

 var Field="<%=Request.QueryString["field"]%>";
 var Order="<%=Request.QueryString["order"]%>";
 var Keyword="<%=Request.QueryString["keyword"]%>";
 var StartDate="<%=Request.QueryString["startdate"]%>";
 var EndDate="<%=Request.QueryString["enddate"]%>";

 if(obj_field!=null && Field!=""){obj_field.value=Field;}
 if(obj_order!=null && Order!=""){obj_order.value=Order;}
 if(obj_date1!=null){obj_date1.value=StartDate;}
 if(obj_date2!=null){obj_date2.value=EndDate;}

 if(obj_keyword!=null){obj_keyword.value=Keyword;}

 function Go()
  { 
   location.href="?table="+Table+"&name="+escape(tablename)+"&field="+obj_field.value+"&order="+obj_order.value+"&keyword="+escape(obj_keyword.value)+"&startdate="+escape(obj_date1.value)+"&enddate="+escape(obj_date2.value)+"&pagesize="+obj_pagesize.value;
  }

function del(did,dname)
 {
   if(confirm("确定删除吗?"))
   {
     document.getElementById("delname").value=dname;
     document.getElementById("ids").value=did;
     document.getElementById("act").value="delete";
     document.forms[0].submit();
   }
 }

function set(act)
 {
   var Ids=Get_Checked("CK");
   var A_Ids=Ids.split(",");
   if(Ids=="")
    {
      alert("请选择要操作的专题栏目!");
      return;
    }
   switch(act)
    {
     case "pdelete":
     if(!confirm("是否确定删除?"))
      {
        return;
      }
     break;

    case "pset":
      document.getElementById("ids").value=Ids;
      Lanmu_PSet();
     return;
    break;

    case "update":

    break;

    }

  document.getElementById("act").value=act;
  document.getElementById("ids").value=Ids;
  document.forms[0].submit();
 }

function Lanmu_PSet()
 {
   IDialog("专题栏目批设置","lanmu_pset.aspx?zt=1",800,550);
 }

function Lanmu_Set(url,name)
 {
   IDialog("专题栏目设置",url+"&lanmu="+encodeURI(name),"95%","90%");
 }

function View_Data(id,title)
 {
   IDialog(title,"zt_data.aspx?id="+id,"90%",600);
 }

function html()
 {
  var Ids=Get_Checked("CK");
  if(Ids=="")
    {
     if(!confirm("请选择要生成的专题页面！\r\n如果不选择将生成所有的专题,是否确定全部生成？"))
      {
        return;
      }
    }
   var htmltype=document.getElementById("htmltype");
   if(htmltype.value=="0")
     {
      htm_panel("专题封面页","pa_zt",Ids);
     }
   else
     {
      htm_panel("专题子栏目","pa_zt_sublanmu",Ids);
     }
 }


function htm_panel(Name,Table,Ids)
 {
  var Width=400;
  var Height=180;
  var b_date=document.getElementById("StartDate");
  var e_date=document.getElementById("EndDatee");
  var datexz="";
  if(b_date.value.length==10 && e_date.value.length==10)
   {
     datexz="&d1="+b_date.value+"&d2="+e_date.value;
   }
  if(Table=="pa_zt")
   {
    IDialog("专题栏目页静态生成","static_panel.aspx?table="+Table+"&lanmuids="+Ids+datexz,Width,Height);   
   }
  else
   {
    IDialog("专题子栏目页静态生成","static_panel.aspx?table="+Table+"&lanmuids="+Ids,Width,Height);
   }
 }
SetCookie("tab","0");
</script>
</body>
</html>  



