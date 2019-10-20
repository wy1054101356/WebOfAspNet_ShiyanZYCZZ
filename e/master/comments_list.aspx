<% @ Page Language="C#" Inherits="PageAdmin.comments_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server"  Type="comment_list"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload()" title="点击刷新"><b>评论管理</b></a></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">

<form runat="server" >
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr>
  <td  height=25><b>所属表</b>：<%=Request.QueryString["name"]%></td>
 </tr>
</table>

<table border=0 cellpadding=0 cellspacing=0 width=95%  style="table-layout:fixed;" align=center>
<tr>
<td align="left" width="110px">
每页<asp:TextBox id="Tb_pagesize" style="width:30px" maxlength="10"  Runat="server"/>条记录
</td>
<td align="right">
<select id="s_type" onchange="Go()">
<option value="">任何属性</option>
<option value="unchecked">未审核</option>
<option value="checked">审核</option>
</select>
<select id="s_order" onchange="Go()">
<option value="id desc">按发布时间↓</option>
<option value="id asc">按发布时间↑</option>
</select>
关键字<input text="text" style="width:80px" size="15">
<input type="button" value="搜索" class="button" onclick="Go()"></td>
 </tr>
</table>

<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
      <tr>
        <td colspan=2 height=25>
           <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle id="tb_list">
                <tr>
                  <td height=25 align=center width=65%  class=white >评论</td>
                  <td height=25 align=center width=10%  class=white >用户</td>
                  <td height=25 align=center width=10%  class=white >状态</td>
                  <td height=25 align=center width=15%  class=white >操作</td>
                </tr>
      <asp:Repeater id="List" runat="server" OnItemDataBound="Data_Bound">
             <ItemTemplate>
               <tr class="listitem">
                  <td height=25 class=tdstyle style="padding:5px 5px 10px 5px">
<input type="checkbox" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>"> 主题：<%#Get_Title(DataBinder.Eval(Container.DataItem,"detail_id").ToString())%><br>
<div class="comments_content"><%#DataBinder.Eval(Container.DataItem,"quote")%><%#ubb(DataBinder.Eval(Container.DataItem,"content").ToString())%></div>
<div class="comments_footer">
时间：<%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd HH:mm:ss}")%> IP:<%#DataBinder.Eval(Container.DataItem,"ip")%></div>
<div class="comments_reply">
<asp:TextBox id="tb_reply" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"reply")%>' TextMode="multiLine" columns="60" rows="2" style="border:1px solid #cccccc;overflow:auto"/>
<asp:Button Text=" 更新回复 " OnCommand="Data_Reply" CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' CommandArgument="<%#Container.ItemIndex%>"  runat="server" class="bt"/>
</div>
</td>

<td height=25 align=center class=tdstyle><%#GetUserName(DataBinder.Eval(Container.DataItem,"username").ToString(),DataBinder.Eval(Container.DataItem,"ismember").ToString())%></td>
<td height=25 align=center class=tdstyle><%#Get_state(DataBinder.Eval(Container.DataItem,"checked").ToString())%></td>

<td height=25  width=15%  align=left class=tdstyle>&nbsp;
<asp:Label id="Lb_id" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' runat="server" visible="false"/>
<asp:LinkButton Text="审核"  OnCommand="Data_Checked" CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' runat="server"  visible='<%#(DataBinder.Eval(Container.DataItem,"checked").ToString())=="0"?true:false%>'/>
<asp:LinkButton Text="删除" id="Delete"  OnCommand="Data_Delete"  CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' runat="server" />
</td>         
                  <td>
                </tr>
             </ItemTemplate>
     </asp:Repeater>

<tr>
<td colspan="4" class=tdstyle>
<table border=0 width=100%>
 <tr><td>
<input type="hidden" name="act" id="act" value="">
<input type="hidden" name="ids" id="ids" value="">
<input type="button" class="button" value="反选" onclick="CheckBox_Inverse('CK')"/>
<a href="javascript:set('checked')">[审核]</a><a href="javascript:set('unchecked')">[取消审核]</a>
<a href="javascript:set('delete')">[删除]</a>
</td>
</table>
</td></tr></table> 
<br>

        共<asp:Label id="Lblrecordcount"  Text=0 runat="server" />条记录 
&nbsp;当前页次: <asp:Label id="Lblcurrentpage"  runat="server" />/<asp:Label id="LblpageCount"  runat="server" />&nbsp;
<asp:Button  text="上一页"  id="LblPrev"  cssclass="button"  runat="server"  CommandName="Prev"   OnCommand="Bt_Click" />&nbsp;
<asp:Button  text="下一页"  id="LblNext"  cssclass="button"  runat="server"  CommandName="Next"   OnCommand="Bt_Click" />&nbsp;
转到:&nbsp;<asp:DropDownList id="DLpage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Page_Changed"  /> 页&nbsp;
</td>
  <tr>
 </table>
 </td>
 <tr>
</table>
<br>
</form>
</td>
</tr>
</table><br>
</center>
<script type="text/javascript">
MouseoverColor("tb_list");
 var obj_type=document.getElementById("s_type");
 var obj_order=document.getElementById("s_order");
 var obj_keyword=document.getElementById("s_keyword");
 var obj_pagesize=document.getElementById("Tb_pagesize");

 var Table="<%=Request.QueryString["table"]%>";
 var Tname="<%=Request.QueryString["name"]%>";
 var detailid="<%=Request.QueryString["detailid"]%>";

 var Type="<%=Request.QueryString["type"]%>";
 var Order="<%=Request.QueryString["order"]%>";
 var Keyword="<%=Request.QueryString["keyword"]%>";

 if(obj_type!=null){obj_type.value=Type;}
 if(obj_order!=null && Order!=""){obj_order.value=Order;}
 if(obj_keyword!=null){obj_keyword.value=Keyword;}

 function Go()
  { 
    location.href="?table="+Table+"&name="+escape(Tname)+"&detailid="+detailid+"&type="+obj_type.value+"&order="+obj_order.value+"&keyword="+escape(obj_keyword.value)+"&pagesize="+obj_pagesize.value;
  }

function set(act)
 {
   var Ids=Get_Checked("CK");
   if(Ids=="")
    {
      alert("请选择要操作的评论!");
      return;
    }

   if(act=="delete")
    {
      if(!confirm("确定删除吗?"))
       {
         return;
       }
    }
  document.getElementById("act").value=act;
   document.getElementById("ids").value=Ids;
  document.forms[0].submit();
 }
</script>
</body>
</html>  