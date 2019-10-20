<% @ Page Language="C#" Inherits="PageAdmin.feedback_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="bs_feedback" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload(true)" title="点击刷新"><b>会员留言</b></a></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">

<form runat="server" >
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
<table border=0 cellpadding=2 cellspacing=0 width=95%  style="table-layout:fixed;" align=center>
<tr>
<td align="left" width="110px">
每页<asp:TextBox id="Tb_pagesize" style="width:30px" maxlength="10"  Runat="server"/>条记录
</td>
<td align="right">
<select name="siteid" id="siteid" style="display:<%=TheMaster=="admin"?"":"none"%>" onchange="Go()"><option value="0">所有站点</option><%=Site_List%></select>
<select id="s_type" onchange="Go()">
<option value="">所有记录</option>
<option value="noreply">未回复</option>
<option value="replyed">已回复</option>
<option value="over">已结束</option>
</select>
<select id="s_order" onchange="Go()">
<option value="id desc">按发布时间↓</option>
<option value="id asc">按发布时间↑</option>
</select>
会员名：<input text="text" id="s_username" style="width:90px">
<input type="button" value="确定" class="button" onclick="Go()">
 </td>
 </tr>
</table>

<table border=0 cellpadding=0 cellspacing=0 width=95% align=center>
      <tr>
        <td  colspan=2 height=25>
         <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle style="table-layout:fixed;" id="tb_list">
                <tr>
                  <td height=25 align=center width=50%  class=white >主题</td>
                  <td height=25 align=center width=10%  class=white >状态</td>
                  <td height=25 align=center width=15%  class=white >反馈日期</td>
                  <td height=25 align=center width=10%  class=white >会员</td>
                  <td height=25 align=center width=15%  class=white >操作</td>
                </tr>
          <asp:Repeater id="dtl1" runat="server" OnItemDataBound="Data_Bound">  
             <ItemTemplate>
               <tr class="listitem">
                  <td height=25  align=left class=tdstyle><input type="checkbox" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>">[<%#DataBinder.Eval(Container.DataItem,"type")%>]<a href='feedback_info.aspx?id=<%#DataBinder.Eval(Container.DataItem,"id")%>&username=<%=Server.UrlEncode(Request.QueryString["username"])%>&replay=<%=Request.QueryString["replay"]%>'><%#DataBinder.Eval(Container.DataItem,"title")%></a></td>
                  <td height=25  align=center class=tdstyle><%#Get_state(DataBinder.Eval(Container.DataItem,"reply_state").ToString())%></span></td></td>
                  <td height=25  align=center class=tdstyle><%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd}")%></td>
                  <td height=25  align=center  class=tdstyle ><a href='member_info.aspx?username=<%#Server.UrlEncode(DataBinder.Eval(Container.DataItem,"username").ToString())%>'><%#DataBinder.Eval(Container.DataItem,"username")%></a></td>
                  <td height=25  align=left class=tdstyle >&nbsp;&nbsp;
<a href='feedback_info.aspx?id=<%#DataBinder.Eval(Container.DataItem,"id")%>&username=<%=Server.UrlEncode(Request.QueryString["username"])%>&type=<%=Request.QueryString["type"]%>'>查看</a>
<asp:LinkButton Text="显示"  Forecolor="#ff0000"  id="Show"  OnCommand="Data_Show"    CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' runat="server" Visible="false" />
<asp:LinkButton Text="隐藏"  id="Hidden"  OnCommand="Data_Hidden"  CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' runat="server" Visible="false" />
<asp:Label id="Lb_username" Text='<%#DataBinder.Eval(Container.DataItem,"username")%>' runat="server" visible="false"/>
<asp:Label id="Lb_show" Text='<%#DataBinder.Eval(Container.DataItem,"show")%>' runat="server" visible="false"/>
<asp:LinkButton Text="删除"  id="Delete"  OnCommand="Data_Delete"  CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' runat="server" />
</td>         
                </tr>
             </ItemTemplate>
          </asp:Repeater>
          </table>
<br>
<input type="hidden" name="act" id="act" value="">
<input type="hidden" name="ids" id="ids" value="">
<input type="button" class="button" value="反选" onclick="CheckBox_Inverse('CK')"/>
<input type="button" class="button" value="删除" onclick="set('delete')"/>
&nbsp;共<asp:Label id="Lblrecordcount"  Text=0 runat="server" />条记录 
&nbsp;当前页次: <asp:Label id="Lblcurrentpage"  runat="server" />/<asp:Label id="LblpageCount"  runat="server" />&nbsp;
<asp:Button  text="上一页"  id="LblPrev" cssclass="button" runat="server" CommandName="Prev" OnCommand="Bt_Click" />&nbsp;
<asp:Button  text="下一页"  id="LblNext" cssclass="button" runat="server" CommandName="Next" OnCommand="Bt_Click" />&nbsp;
转到:&nbsp;<asp:DropDownList id="DLpage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Page_Changed"  /> 页&nbsp;
</td>
  <tr>
 </table>
 </td>
 <tr>
</table>
<br>
</form>
</center>
<script type="text/javascript">
 MouseoverColor("tb_list");
 var obj_site=document.getElementById("siteid");
 var obj_pagesize=document.getElementById("Tb_pagesize");

 var obj_type=document.getElementById("s_type");
 var obj_order=document.getElementById("s_order");

 var obj_username=document.getElementById("s_username");

 var Sitetid="<%=Request.QueryString["siteid"]%>";
 var Type="<%=Request.QueryString["type"]%>";
 var Order="<%=Request.QueryString["order"]%>";
 var UserName="<%=Request.QueryString["username"]%>";


 if(obj_site!=null && Sitetid!=""){obj_site.value=Sitetid;}
 if(obj_type!=null){obj_type.value=Type;}
 if(obj_order!=null && Order!=""){obj_order.value=Order;}
 if(obj_username!=null){obj_username.value=UserName;}

 function Go()
  { 
   location.href="?siteid="+obj_site.value+"&type="+obj_type.value+"&order="+obj_order.value+"&username="+escape(obj_username.value)+"&pagesize="+obj_pagesize.value;
  }

function set(act)
 {
   var Ids=Get_Checked("CK");
   if(Ids=="")
    {
      alert("请选择要删除的记录!");
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