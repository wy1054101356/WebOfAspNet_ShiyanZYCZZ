<% @ Page Language="C#" Inherits="PageAdmin.finance_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="bs_finance" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload(true)" title="点击刷新"><b>财务记录</b></a></td></tr>
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
<select name="siteid" id="siteid" style="display:<%=TheMaster=="admin"?"":"none"%>" onchange="Go()"><option value="0">所有站点</option><%=Site_List%></select>
<select id="s_type" onchange="Go()">
<option value="">所有记录</option>
<option value="c">入款记录</option>
<option value="k">扣款记录</option>
<option value="f">返款记录</option>
</select>
<select id="s_order" onchange="Go()">
<option value="id desc">按ID↓</option>
<option value="id asc">按ID↑</option>
<option value="thedate desc">按时间↓</option>
<option value="thedate asc">按时间↑</option>
</select>
按日期
<input name="StartDate" id="StartDate" Maxlength="10" size="6" ><a href="javascript:open_calendar('StartDate')"><img src=images/calendar_bnt.gif border=0 height=20 hspace=2 align=absbottom></a> 
到 
<input name="EndDate" id="EndDate" Maxlength="10" size="6"><a href="javascript:open_calendar('EndDate')"><img src=images/calendar_bnt.gif border=0 height=20 hspace=2 align=absbottom></a> 
搜索<input text="text" id="s_keyword" style="width:80px" title="需要精确搜索在关键词前面加=号，如：=关键词"><select id="s_field">
<option value="username">按会员名</option>
<option value="operator">按操作人</option>
<option value="detail">按说明</option>
<option value="beizhu">按备注</option>
</select>
<input type="button" value="确定" class="button" onclick="Go()">
 </td>
 </tr>
</table>

    <table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
      <tr>
        <td  colspan=2 align="left">
            <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle style="table-layout:fixed;" id="tb_list">
                <tr>
                  <td align=center width=8% class=white height=20>事项</td>
                  <td align=center width=9% class=white>金额</td>
                  <td align=center width=5% class=white>成本</td>
                  <td align=center width=10% class=white>用户</td>
                  <td align=center width=15% class=white>说明</td>
                  <td align=center width=20% class=white>备注</td>
                  <td align=center width=15% class=white>时间</td>
                  <td align=center width=10% class=white>操作人</td>
                  <td align=center width=8% class=white>管理</td>
                </tr>
          <asp:Repeater id="P1" runat="server" OnItemDataBound="Data_Bound">         
             <ItemTemplate>
                 <tr class="listitem">
                  <td align=left class=tdstyle height=20><input type="checkbox" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>"><%#Get_Type(DataBinder.Eval(Container.DataItem,"act").ToString())%></td>
                  <td align=center class=tdstyle><b><%#Get_Symbol(DataBinder.Eval(Container.DataItem,"act").ToString())%><%#DataBinder.Eval(Container.DataItem,"amount")%></b></td>
                  <td align=center class=tdstyle><asp:Label Id="Lb_cost" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"cost")%>'/></td>
                  <td align=center class=tdstyle><a href='member_info.aspx?username=<%#Server.UrlEncode(DataBinder.Eval(Container.DataItem,"username").ToString())%>'><%#DataBinder.Eval(Container.DataItem,"username")%></a></td>
                  <td align=center class=tdstyle><%#DataBinder.Eval(Container.DataItem,"detail")%></td>
                  <td class=tdstyle><%#DataBinder.Eval(Container.DataItem,"beizhu")%></td>
                  <td align=center class=tdstyle><%#DataBinder.Eval(Container.DataItem,"thedate")%></td>
                  <td align=center class=tdstyle><a href='member_info.aspx?username=<%#Server.UrlEncode(DataBinder.Eval(Container.DataItem,"operator").ToString())%>'><%#DataBinder.Eval(Container.DataItem,"operator")%></a></td>
                 <td align=center class=tdstyle>
                    <asp:Label Id="Lb_type" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"act")%>' visible="false" />
                    <asp:Label Id="Lb_amount" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"amount")%>' visible="false" />
                    <asp:LinkButton Id="Delete" runat="server" Text="删除" CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' OnCommand="Data_Delete" />
                  </td>
                </tr>
             </ItemTemplate>
          </asp:Repeater>
           </table> 
<br>
 <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle style="table-layout:fixed;">
                <tr>
                  <td align=center width=13% class=tdstyle height=20>入款总额</td>
                  <td align=center width=12% class=tdstyle><%=rk_total%></td>
                  <td align=center width=13% class=tdstyle>扣款总额</td>
                  <td align=center width=12% class=tdstyle><%=xf_total%></td>
                  <td align=center width=13% class=tdstyle>成本总额</td>
                  <td align=center width=12% class=tdstyle><%=cb_total%></td>
                  <td align=center width=13% class=tdstyle>返款总额</td>
                  <td align=center width=12% class=tdstyle><%=fk_total%></td>
                </tr>
              </table> 
<br>
<input type="hidden" name="act" id="act" value="">
<input type="hidden" name="ids" id="ids" value="">
<input type="button" class="button" value="反选" onclick="CheckBox_Inverse('CK')"/>
<input type="button" class="button" value="删除" onclick="set('delete')"/>
&nbsp;共<asp:Label id="Lblrecordcount"  Text=0 runat="server" />条记录 
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
<br>
<asp:Label Id="Lbl_info"   runat="server" visible="false" />
</form>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
 MouseoverColor("tb_list");
 var obj_site=document.getElementById("siteid");
 var obj_pagesize=document.getElementById("Tb_pagesize");

 var obj_type=document.getElementById("s_type");
 var obj_order=document.getElementById("s_order");

 var obj_date1=document.getElementById("StartDate");
 var obj_date2=document.getElementById("EndDate");

 var obj_field=document.getElementById("s_field");
 var obj_keyword=document.getElementById("s_keyword");

 var Sitetid="<%=Request.QueryString["siteid"]%>";
 var Type="<%=Request.QueryString["type"]%>";
 var Order="<%=Request.QueryString["order"]%>";
 var StartDate="<%=Request.QueryString["startdate"]%>";
 var EndDate="<%=Request.QueryString["enddate"]%>";
 var Field="<%=Request.QueryString["field"]%>";
 var Keyword="<%=Request.QueryString["keyword"]%>";

 if(obj_site!=null && Sitetid!=""){obj_site.value=Sitetid;}
 if(obj_type!=null){obj_type.value=Type;}
 if(obj_order!=null && Order!=""){obj_order.value=Order;}
 if(obj_date1!=null){obj_date1.value=StartDate;}
 if(obj_date2!=null){obj_date2.value=EndDate;}

 if(obj_field!=null && Field!=""){obj_field.value=Field;}
 if(obj_keyword!=null){obj_keyword.value=Keyword;}

 function Go()
  { 
   location.href="?siteid="+obj_site.value+"&type="+obj_type.value+"&field="+obj_field.value+"&order="+obj_order.value+"&keyword="+escape(obj_keyword.value)+"&startdate="+escape(obj_date1.value)+"&enddate="+escape(obj_date2.value)+"&pagesize="+obj_pagesize.value;
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



