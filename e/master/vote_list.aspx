<% @ Page Language="C#" Inherits="PageAdmin.vote_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="js_vote" />
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1 align="left"><b>问卷管理</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top  align="left">

<form runat="server" >
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top  align="left">
 <table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
      <tr>
        <td  colspan=2 height=25>
                 <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle id="tb_list">
                <tr>
                  <td align=center width=35% class=white height=25px>标题</td>
                  <td align=center width=15% class=white>投票设置</td>
                  <td align=center width=15% class=white>结束日期</td>
                  <td align=center width=10% class=white>创建人</td>
                  <td align=center width=25% class=white>管理</td>
                </tr> 
          <asp:Repeater id="DL_1" runat="server"  OnItemDataBound="Data_Bound">       
             <ItemTemplate>
                <tr class="listitem">
                  <td align=left class=tdstyle>
<input type="checkbox" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>"><asp:TextBox id="Tb_Title" maxlength="45" size="40" runat="server" Text='<%#Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"title").ToString())%>'/></td>

                  <td align=center class=tdstyle>
<asp:DropDownlist id="D_VoteSet" Runat="server">
<asp:ListItem Value="1">每IP限投一票</asp:ListItem>
<asp:ListItem Value="0">无限制</asp:ListItem>
</asp:DropDownlist>
                  </td>

                  <td align=center class=tdstyle><asp:TextBox id="Tb_EndDate" maxlength="10" size=10  runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"EndDate","{0:yyyy-MM-dd}")%>'/></td>
                  <td align=center  class=tdstyle><%#DataBinder.Eval(Container.DataItem,"username")%></td>
                  <td align=center class=tdstyle>
                   <asp:Label id="Lb_id" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' runat="server" visible="false"/>
                   <asp:Label id="Lb_voteset" Text='<%#DataBinder.Eval(Container.DataItem,"voteset")%>' runat="server" visible="false"/>
                   <a href="vote_quesion.aspx?id=<%#DataBinder.Eval(Container.DataItem,"id")%>&title=<%#Server.UrlEncode(DataBinder.Eval(Container.DataItem,"title").ToString())%>">问卷设置</a>
                    <a href="javascript:Js_Code('<%#DataBinder.Eval(Container.DataItem,"id")%>','0','vote')">获取代码</a>
                    <a href="javascript:vote_view('/e/vote/voteview.aspx?id=<%#DataBinder.Eval(Container.DataItem,"id")%>')">查看</a>
                   <a href="javascript:del('<%#DataBinder.Eval(Container.DataItem,"id")%>','<%#DataBinder.Eval(Container.DataItem,"title")%>')">删除</a>
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
          <input type="submit" value="更新" class="button" id="sbt" onclick="return set('update')"/>
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
<asp:Label id="LblInfo" runat="server" style="color:#ff0000"/>
<br>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
    <table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
    <tr><td  colspan=3 height=25><b>增加问卷</b></td>
    </tr>
      <tr>
        <td  height=25 align="left">
问卷名称：<asp:TextBox id="Vote_Title" maxlength="45" size="35"  runat="server" />
投票设置：
<asp:DropDownlist id="VoteSet" Runat="server">
<asp:ListItem Value="1">每IP限投一票</asp:ListItem>
<asp:ListItem Value="0">无限制</asp:ListItem>
</asp:DropDownlist>
结束日期：<asp:TextBox id="EndDate" maxlength=10 size=10 runat="server" /><a href="javascript:open_calendar('EndDate')"><img src=images/calendar_bnt.gif border=0 height=20 hspace=2 align=absbottom></a>
<asp:button  CssClass="button" Text="增加" runat="server" OnClick="Data_Add" onclientclick="return addck()"/>
        </td>
    </tr>
   </table>
</td>
</tr>
</table>
<br>
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

function set(act)
 {
   var Ids=Get_Checked("CK");
   if(Ids=="")
    {
      alert("请选择要操作的记录!");
      if(act=="update"){return false;}
      else{return;}
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

 function vote_view(voteurl)
  {
   var Width=850;
   var Height=500;
   var Left=(window.screen.availWidth-10-Width)/2;
   var Top=(window.screen.availHeight-30-Height)/2;
   var v=window.open(voteurl,"v","width="+Width+",height="+Height+",top="+Top+",left="+Left+",toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=no");
  }

function addck()
 {
  var Add_Name=document.getElementById("Vote_Title");
  if(Add_Name.value=="")
    {
      alert("请填写问卷名称!");
      Add_Name.focus();
      return false;
    }
      return true;
 }
</script>
</body>
</html>