<% @ Page Language="C#" Inherits="PageAdmin.letter_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="bs_letter"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload(true)" title="点击刷新"><b>信息回复</b></a></td></tr>
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
<select id="s_type" onchange="Go()">
<option value="">所有信息</option>
<option value="noreply">未回复</option>
<option value="replyed">已回复</option>
</select>
<select id="s_order" onchange="Go()">
<option value="id desc">按提交时间↓</option>
<option value="id asc">按提交时间↑</option>
</select>
按日期
<input name="StartDate" id="StartDate" Maxlength="10" size="10" value="<%=Start_Date_Text%>" ><a href="javascript:open_calendar('StartDate')"><img src=images/calendar_bnt.gif border=0 height=20 hspace=2 align=absbottom></a> 
到 
<input name="EndDate" id="EndDate" Maxlength="10" size="10" value="<%=End_Date_Text%>" ><a href="javascript:open_calendar('EndDate')"><img src=images/calendar_bnt.gif border=0 height=20 hspace=2 align=absbottom></a> 

<input type="button" value="确定" class="button" onclick="Go()">
 </td>
 </tr>
</table>

<table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
      <tr>
        <td  align="left">
            <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle id="tb_list">
                <tr>
                  <td align=center width=45% class=white>标题</td>
                  <td align=center width=10% class=white>所属表</td>
                  <td align=center width=10% class=white height=20>发布人</td>
                  <td align=center width=15% class=white height=20>提交时间</td>
                  <td align=center width=10% class=white height=20>状态</td>
                  <td align=center width=10% class=white>操作</td>
                </tr>
          <asp:Repeater id="P1" runat="server" OnItemDataBound="Data_Bound">         
             <ItemTemplate>
                 <tr class="listitem">
                  <td align=left class="tdstyle"><asp:Label id="Lb_Title" runat="server"/></td>
                  <td align=center class=tdstyle><asp:Label id="Lb_Table" runat="server" text='<%#DataBinder.Eval(Container.DataItem,"thetable")%>'/></td>
                  <td align=center class=tdstyle><asp:Label id="Lb_UserName" runat="server"/></td>
                  <td align=center class="tdstyle" title="<%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd HH:mm:ss}")%>"><%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd}")%></td>
                  <td align=center class=tdstyle><%#GetReplayState(DataBinder.Eval(Container.DataItem,"reply_state").ToString())%></td>
                  <td align=center class="tdstyle">
                    <a href='data_reply_1.aspx?detailid=<%#DataBinder.Eval(Container.DataItem,"detail_id")%>&table=<%#DataBinder.Eval(Container.DataItem,"thetable")%>'>回复</a>
                  </td>
                </tr>
                <asp:Label id="Lb_DetailId" runat="server" text='<%#DataBinder.Eval(Container.DataItem,"detail_id")%>' Visible="false"/>
             </ItemTemplate>
          </asp:Repeater>
</table>
</td></tr></table> 

<table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
      <tr>
        <td  align="left">
共<asp:Label id="Lblrecordcount"  Text=0 runat="server" />条信息 
&nbsp;当前页次: <asp:Label id="Lblcurrentpage"  runat="server" />/<asp:Label id="LblpageCount"  runat="server" />&nbsp;
<asp:Button  text="上一页"  id="LblPrev"  cssclass="button"  runat="server"  CommandName="Prev"   OnCommand="Bt_Click" />&nbsp;
<asp:Button  text="下一页"  id="LblNext"  cssclass="button"  runat="server"  CommandName="Next"   OnCommand="Bt_Click" />&nbsp;
转到:&nbsp;<asp:DropDownList id="DLpage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Page_Changed"  /> 页&nbsp;
</td></tr></table>

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
 var obj_pagesize=document.getElementById("Tb_pagesize");
 var obj_type=document.getElementById("s_type");
 var obj_order=document.getElementById("s_order");
 var obj_date1=document.getElementById("StartDate");
 var obj_date2=document.getElementById("EndDate");

 var Type="<%=Request.QueryString["type"]%>";
 var Order="<%=Request.QueryString["order"]%>";
 var StartDate="<%=Request.QueryString["startdate"]%>";
 var EndDate="<%=Request.QueryString["enddate"]%>";

 if(obj_order!=null && Order!=""){obj_order.value=Order;}
 if(obj_type!=null){obj_type.value=Type;}
 if(obj_date1!=null){obj_date1.value=StartDate;}
 if(obj_date2!=null){obj_date2.value=EndDate;}

 function Go()
  { 
   location.href="?type="+obj_type.value+"&order="+obj_order.value+"&startdate="+escape(obj_date1.value)+"&enddate="+escape(obj_date2.value)+"&pagesize="+obj_pagesize.value;
  }
</script>
</body>
</html>  
