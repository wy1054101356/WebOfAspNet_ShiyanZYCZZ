<% @ Page Language="C#" Inherits="PageAdmin.zt_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="basic_task"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10 ></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
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
<select id="s_order" onchange="Go()" style="display:none">
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
                  <td align=center class=white width=70% height=20>专题名</td>
                  <td align=center class=white style="display:none">ID</td>
                  <td align=center class=white height=20 style="display:none">提交时间</td>
                  <td align=center class=white height=20 style="display:none">发布人</td>
                  <td align=center class=white height=20 style="display:none">信息</td>
                  <td align=center class=white>二级导航</td>
                </tr>
          <asp:Repeater id="P1" runat="server" OnItemDataBound="Data_Bound">         
             <ItemTemplate>
                 <tr class="listitem">
                  <td align=left class="tdstyle" noWrap><input type="checkbox" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>"><a href="<%#Get_Url(DataBinder.Eval(Container.DataItem,"id").ToString(),DataBinder.Eval(Container.DataItem,"thetype").ToString(),DataBinder.Eval(Container.DataItem,"lanmu_dir").ToString(),DataBinder.Eval(Container.DataItem,"zdy_url").ToString())%>" target=_blank><span style="color:<%#DataBinder.Eval(Container.DataItem,"show").ToString()=="1"?"#333":"#999"%>"><%#Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"name").ToString())%></span></a></td>
                  <td align=center class=tdstyle noWrap style="display:none"><%#DataBinder.Eval(Container.DataItem,"id")%></td>
                  <td align=center class="tdstyle" noWrap style="display:none"><%#DataBinder.Eval(Container.DataItem,"thedate")%></td>
                  <td align=center class=tdstyle noWrap style="display:none"><a href='member_info.aspx?username=<%#Server.UrlEncode(DataBinder.Eval(Container.DataItem,"username").ToString())%>'><%#DataBinder.Eval(Container.DataItem,"username")%></a></td>
                  <td align=center class=tdstyle noWrap style="display:none"><a href="javascript:View_Data(<%#DataBinder.Eval(Container.DataItem,"id")%>,'<%#Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"name").ToString())%>')">查看</a></td>
                  <td align=center class="tdstyle" noWrap>
                   <asp:Hyperlink id="Nav_Set" runat="server" Text="导航管理"   NavigateUrl='<%#"task_nav_list.aspx?iszt=1&lanmuid="+DataBinder.Eval(Container.DataItem,"id")+"&lanmuname="+Server.UrlEncode(DataBinder.Eval(Container.DataItem,"name").ToString())%>' />
                   <asp:Hyperlink id="Module_Set" visible="false" runat="server" Text="模块管理"   NavigateUrl='<%#"module_list.aspx?iszt=1&lanmuid="+DataBinder.Eval(Container.DataItem,"id")+"&lanmuname="+Server.UrlEncode(DataBinder.Eval(Container.DataItem,"name").ToString())%>' />
                   <asp:Hyperlink id="Lanmu_Set"  visible="false" runat="server"  NavigateUrl='<%#"javascript:Lanmu_Set(\"lanmu_set.aspx?&id="+DataBinder.Eval(Container.DataItem,"id")+"\",\""+DataBinder.Eval(Container.DataItem,"name").ToString()+"\")"%>'  Text="专题设置" />
                  </td>
                </tr>
             </ItemTemplate>
          </asp:Repeater>
<tr>
<td colspan="2" class=tdstyle>
<input type="hidden" value="" name="ids" id="ids">
<input type="hidden" value="" name="act" id="act">
<input type="hidden" value="" name="delname" id="delname">
<input type="button" class="button" value="反选" onclick="CheckBox_Inverse('CK')"/>
<input type="button" value="选择" class="button" id="sbt" onclick="Get_Select()"/>

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
<div align=center style="padding-top:10px"><input type="button" value="关闭" class="button" id="sbt" onclick="parent.CloseDialog()"/></div>
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

var parentobj=parent.document.getElementById("build_ids");
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
     alert("请选择要刷新的栏目!");
     return;
   }
  parent.AddSelect(Ids,"zt");
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
</script>
</body>
</html>  



