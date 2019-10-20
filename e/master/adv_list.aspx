<% @ Page Language="C#" Inherits="PageAdmin.adv_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="js_adv" />
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>广告管理</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">

<form runat="server" >
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
 <table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
      <tr>
        <td  colspan=2 height=25>
                <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle id="tb_list">
                <tr>
                  <td align=center width=35% class=white height=25px>名称</td>
                  <td align=center width=15% class=white>广告类型</td>
                  <td align=center width=15% class=white>结束日期</td>
                  <td align=center width=15% class=white>创建人</td>
                  <td align=center width=25% class=white>管理</td>
                </tr>
          <asp:Repeater id="DL_1" runat="server" OnItemDataBound="Data_Bound">         
             <ItemTemplate>
                <tr class="listitem">
                  <td align=left class=tdstyle><input type="checkbox" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>"><asp:Label id="Lb_Name" Text='<%#DataBinder.Eval(Container.DataItem,"name")%>' Runat="server"/></td>
                  <td align=center class=tdstyle><%#GetType(DataBinder.Eval(Container.DataItem,"adv_type").ToString())%></td>
                  <td align=center class=tdstyle><%#DataBinder.Eval(Container.DataItem,"enddate","{0:yyyy-MM-dd}")%></td>
                  <td align=center class=tdstyle><%#DataBinder.Eval(Container.DataItem,"username")%></td>
                  <td align=center  class=tdstyle>
                   <asp:Label id="Lb_id" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' runat="server" visible="false"/>
                   <a href="javascript:AdvSet('<%#DataBinder.Eval(Container.DataItem,"name")%>','adv_set.aspx?id=<%#DataBinder.Eval(Container.DataItem,"id")%>&name=<%#DataBinder.Eval(Container.DataItem,"name")%>')">内容设置</a>
                    <a href="javascript:Js_Code('<%#DataBinder.Eval(Container.DataItem,"id")%>','0','adv')">获取调用代码</a>
                    <a href="javascript:del('<%#DataBinder.Eval(Container.DataItem,"id")%>','<%#DataBinder.Eval(Container.DataItem,"name")%>')">删除</a>
                  </td>
                </tr>
             </ItemTemplate>
         </asp:Repeater>
       <tr style="display:<%=ListCounts==0?"none":""%>">
          <td colspan="5" align="left" class="tdstyle">
          <input type="hidden" value="" name="ids" id="ids">
          <input type="hidden" value="" name="act" id="act">
          <input type="hidden" value="" name="delname" id="delname">
          <input type="button" class="button" value="反选" onclick="CheckBox_Inverse('CK')"/>
           [<a href="javascript:set('pdelete')">删除</a>]
          </td>
        </tr>
        </table>
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
<br>

<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
    <table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
    <tr><td  colspan=3 height=25><b>增加广告</b></td>
    </tr>
      <tr>
        <td  height=25>
名称：<asp:TextBox id="Add_Name" maxlength=40 size=20  runat="server" />
类型：<asp:DropDownlist id="Adv_Type" Runat="server">
     <asp:ListItem value="1">弹出窗口广告</asp:ListItem>
     <asp:ListItem value="2">漂浮广告</asp:ListItem>
     <asp:ListItem value="3">对联广告</asp:ListItem>
     <asp:ListItem value="4">自定义Js</asp:ListItem>
    </asp:DropDownlist>
结束日期：<asp:TextBox id="EndDate" maxlength=10 size=10 runat="server" /><a href="javascript:open_calendar('EndDate')"><img src=images/calendar_bnt.gif border=0 height=20 hspace=2 align=absbottom></a>
<asp:button  CssClass="button"  Text="增加" runat="server" OnClick="Data_Add" onclientclick="return addck()"/>
        </td>
    </tr>
   </table>
</td>
</tr>
</table>
<br>
<asp:Label id="LblErr" runat="server" />
</form>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
MouseoverColor("tb_list");
function del(id,dname)
 {
   if(confirm("确定删除吗?"))
   {
     document.getElementById("delname").value=dname;
     document.getElementById("ids").value=id;
     document.getElementById("act").value="delete";
     document.forms[0].submit();
   }
 }

function AdvSet(name,url)
  {
   IDialog(name,url,"90%",600);
  } 


function set(act)
 {
   var Ids=Get_Checked("CK");
   if(Ids=="")
    {
      alert("请选择要操作的记录!");
      return;
    }
   if(act=="pdelete")
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

function addck()
 {
  var Add_Name=document.getElementById("Add_Name");
  if(Add_Name.value=="")
    {
      alert("请填写广告名称!");
      Add_Name.focus();
      return false;
    }
      return true;
 }
</script>
</body>
</html> 