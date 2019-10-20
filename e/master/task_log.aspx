<% @ Page Language="C#" Inherits="PageAdmin.log_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="basic_task" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>计划任务运行日志</b></td></tr>
 <tr><td height=10 ></td></tr>
</table>
<table border=0 cellpadding=10 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<form runat="server">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
<table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
<tr>
  <td height=10><b><span id="log_type"></span></b></td>
 </tr>
</table>

<table border=0 cellpadding=0 cellspacing=0 width=95%  style="table-layout:fixed;" align=center>
<tr>
<td align="left" width="150px">
每页<asp:TextBox id="Tb_pagesize" size="3" maxlength="10"  Runat="server"/>条记录
</td>
<td align="right">
按日期
<input name="StartDate" id="StartDate" Maxlength="10" size="8" value="<%=Start_Date_Text%>" ><a href="javascript:open_calendar('StartDate')"><img src=images/calendar_bnt.gif border=0 height=20 hspace=2 align=absbottom></a> 
到 
<input name="EndDate" id="EndDate" Maxlength="10" size="8" value="<%=End_Date_Text%>" ><a href="javascript:open_calendar('EndDate')"><img src=images/calendar_bnt.gif border=0 height=20 hspace=2 align=absbottom></a> 
搜索<input text="text" id="s_keyword" size="10">
<select id="s_field" style="display:none">
<option value="description">按描述</option>
</select>
<input type="button" value="确定" class="button" onclick="Go()">
 </td>
 </tr>
</table>

    <table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
      <tr>
        <td  colspan=2  align="left">
            <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle style="table-layout:fixed;">
                <tr>
                  <td align=center width=60% class=white height=20>描述</td>
                  <td align=center width=20% class=white>时间</td>
                  <td align=center width=10% class=white>状态</td>
                  <td align=center width=10% class=white>管理</td>
                </tr>
          <asp:Repeater id="P1" runat="server" OnItemDataBound="Data_Bound">        
             <ItemTemplate>
                 <tr>
                 <td class=tdstyle height=20><input type="checkbox" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>"> <%#DataBinder.Eval(Container.DataItem,"description")%></td>
                 <td align=center class=tdstyle><%#DataBinder.Eval(Container.DataItem,"thedate")%></td>
                 <td class=tdstyle><%#DataBinder.Eval(Container.DataItem,"state").ToString()=="1"?"成功":"<font color=red>失败</font>"%></td>
                 <td align=center  class=tdstyle>
                    <asp:LinkButton Id="Delete" runat="server" Text="删除" CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' OnCommand="Data_Delete" />
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
    </tr>
   </table>
  </td>
  <tr>
 </table>
<br>
<asp:Label Id="Lbl_info"   runat="server" visible="false" />
</form>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
var IsMaster="<%=Request.QueryString["ismaster"]%>";
if(IsMaster=="0")
 {
  showtab(1);
 }
else
 {
  showtab(0);
 }

 var obj_pagesize=document.getElementById("Tb_pagesize");

 var obj_date1=document.getElementById("StartDate");
 var obj_date2=document.getElementById("EndDate");

 var obj_field=document.getElementById("s_field");
 var obj_keyword=document.getElementById("s_keyword");

 var StartDate="<%=Request.QueryString["startdate"]%>";
 var EndDate="<%=Request.QueryString["enddate"]%>";
 var Field="<%=Request.QueryString["field"]%>";
 var Keyword="<%=Request.QueryString["keyword"]%>";

 if(obj_date1!=null){obj_date1.value=StartDate;}
 if(obj_date2!=null){obj_date2.value=EndDate;}
 if(obj_field!=null && Field!=""){obj_field.value=Field;}
 if(obj_keyword!=null){obj_keyword.value=Keyword;}

 function Go()
  { 
   location.href="?istask=<%=Request.QueryString["istask"]%>&field="+obj_field.value+"&keyword="+escape(obj_keyword.value)+"&startdate="+escape(obj_date1.value)+"&enddate="+escape(obj_date2.value)+"&pagesize="+obj_pagesize.value;
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