<% @ Page Language="C#" Inherits="PageAdmin.member_type"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="member_type" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload()" title="点击刷新"><b>会员类别设置</b></a></td></tr>
 <tr><td height=10 ></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95%>
 <tr>
<td valign=top align="left">
<form runat="server" >
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
     <table border=0 cellpadding=0 cellspacing=0 width=95%  class=tablestyle align=center id="tb_list">
       <tr>
                  <td height=25 align=center width=20%  class=white >会员类别</td>
                  <td height=25 align=center width=10%  class=white >作用站点</td>
                  <td height=25 align=center width=10%  class=white >注册权限</td>
                  <td height=25 align=center width=10%  class=white >注册审核</td>
                  <td height=25 align=center width=10%  class=white >允许删除会员</td>
                  <td height=25 align=center width=10%  class=white >初始积分</td>
                  <td height=25 align=center width=10%  class=white >说明</td>
                   <td height=25 align=center width=5%  class=white >序号</td>
                  <td height=25 align=center width=15%  class=white >操作</td>
        </tr>
       <asp:Repeater id="List1" runat="server" OnItemDataBound="Data_Bound">  
            <ItemTemplate>
                <tr class="listitem">
                  <td height=25 align=left class="tdstyle"><input type="checkbox" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>"> <asp:TextBox id="Tb_type" Text='<%#DataBinder.Eval(Container.DataItem,"name")%>'  size="15" Runat="server" Maxlength="50"/></td>
                  <td height=25 align=center class="tdstyle">
                    <asp:DropDownList id="DL_Site" runat="server">
                     <asp:listItem value="0">不限</asp:ListItem>
                    </asp:DropDownList>
                  </td>
                  <td height=25 align=center class="tdstyle">
                    <asp:DropDownList id="DL_Reg" runat="server" >
                     <asp:listItem value="1" >开放注册</asp:ListItem>
                     <asp:listItem value="0" style="color:#ff0000">禁止注册</asp:ListItem>
                    </asp:DropDownList>
                  </td>

                  <td height=25 align=center class="tdstyle">
                    <asp:DropDownList id="DL_Check" runat="server" >
                     <asp:listItem value="2" >人工审核</asp:ListItem>
                     <asp:listItem value="1" >邮件验证</asp:ListItem>
                     <asp:listItem value="0" style="color:#0066FF">无需审核</asp:ListItem>
                    </asp:DropDownList>
                  </td>

                  <td height=25 align=center class="tdstyle">
                    <asp:DropDownList id="DL_Delete" runat="server" >
                     <asp:listItem value="0" style="color:#009933">否</asp:ListItem>
                     <asp:listItem value="1">是</asp:ListItem>
                    </asp:DropDownList>
                  </td>

                  <td height=25 align=center class="tdstyle"><asp:TextBox id="Tb_dpoint" Text='<%#DataBinder.Eval(Container.DataItem,"default_point")%>' Runat="server" size="5" maxlength="10" /></td>
                  <td height=25 align=center class="tdstyle"><asp:TextBox id="Tb_beizhu" Text='<%#DataBinder.Eval(Container.DataItem,"beizhu")%>'  Runat="server"  size="10" maxlength="50" /></td>
                  <td height=25 align=center class="tdstyle"><asp:TextBox id="Tb_xuhao" Text='<%#DataBinder.Eval(Container.DataItem,"xuhao")%>'  Runat="server" size="3" maxlength="5"/></td>
                  <td height=25 align=center class="tdstyle">
                   <asp:Label id="Lb_Group" Text='<%#DataBinder.Eval(Container.DataItem,"m_group")%>' Runat="server" Visible="false" />
                   <asp:Label id="Lb_siteid" Text='<%#DataBinder.Eval(Container.DataItem,"site_id")%>' Runat="server" Visible="false" />
                   <asp:Label id="Lb_id" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' Runat="server" Visible="false" />
                   <asp:Label id="Lb_reg" Text='<%#DataBinder.Eval(Container.DataItem,"m_reg")%>' Runat="server" Visible="false" />
                   <asp:Label id="Lb_check" Text='<%#DataBinder.Eval(Container.DataItem,"m_check")%>' Runat="server" Visible="false" />
                   <asp:Label id="Lb_delete" Text='<%#DataBinder.Eval(Container.DataItem,"m_delete")%>' Runat="server" Visible="false" />
                   <a href="javascript:MSet('<%#DataBinder.Eval(Container.DataItem,"name")%>','<%#DataBinder.Eval(Container.DataItem,"id")%>')">会员功能设置              
                   <asp:LinkButton id="Delete" CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' CommandArgument='<%#DataBinder.Eval(Container.DataItem,"name")%>' OnCommand="Data_Delete" runat="server" Text="删除"  />
                  </td>
                </tr>
            </ItemTemplate>
       </asp:Repeater>
 <tr>
 <td colspan="9" align="left" class="tdstyle">
<input type="button" class="button" value="反选" onclick="CheckBox_Inverse('CK')"/>
<input type="button" value="更新" class="button" id="sbt" onclick="set('update')"/>
[<a href="javascript:set('pset')">批设功能</a>]
<input type="hidden" value=""  name="ids" id="ids">
<input type="hidden" value="" name="act" id="act">
</td>
</tr>
    </table>

  </td>
  <tr>
 </table>

<br>

<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">

    <table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
    <tr>
    <td height=25><b>增加会员类别</b></td>
   </tr>
    </table>
    <table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
    <tr>
    <td height=25>
   类别：<asp:TextBox  id="Add_Type" maxlength="50" size="15"  runat="server" />
   作用站点：<asp:DropDownList id="Add_Site" runat="server" ><asp:listItem value="0">不限</asp:ListItem></asp:DropDownList>
   注册：        <asp:DropDownList id="Add_Reg" runat="server" >
                     <asp:listItem value="1" >开放注册</asp:ListItem>
                     <asp:listItem value="0">禁止注册</asp:ListItem>
                    </asp:DropDownList>
   审核： <asp:DropDownList id="Add_Check" runat="server" >
                     <asp:listItem value="2">人工审核</asp:ListItem>
                     <asp:listItem value="1">邮件验证</asp:ListItem>
                     <asp:listItem value="0">无需审核</asp:ListItem>
                    </asp:DropDownList>
   可删除： <asp:DropDownList id="Add_Delete" runat="server" >
                     <asp:listItem value="1">是</asp:ListItem>
                     <asp:listItem value="0">否</asp:ListItem>
               </asp:DropDownList>
   初始积分：<asp:TextBox id="Add_Point" Text="0" maxlength="5" size="3" runat="server" />
   序号：<asp:TextBox  id="Add_Xuhao" Text="0" maxlength="5" size="3"  runat="server" />
   <asp:button  CssClass="button"  Text="增加"  runat="server" OnClick="Data_Add" />
    </td>
   </tr>
    </table>
  </td>
  <tr>
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
function MSet(name,Id,type)
 {
  General_Set("会员中心设置["+name+"]","member_center_set.aspx?thetype=membertype&id="+Id);
 }
function Mtype_Set(name,url)
 {
  General_Set(name,url);
 }

function set(act)
 {
   var Ids=Get_Checked("CK");
   var A_Ids=Ids.split(",");
   if(Ids=="")
    {
      alert("请选择要操作的会员类别!");
      return;
    }
   switch(act)
    {

    case "pdelete":
     if(!confirm("此操作将导致部门下的所有用户的部门属性被重置，确定删除吗?"))
      {
        return;
      }
    break;

    case "pset":
      General_Set("用户功能批量设置","member_center_set.aspx?act=pset&thetype=membertype&id="+Ids);
      return;
    break;
    }
  document.getElementById("act").value=act;
  document.getElementById("ids").value=Ids;
  document.forms[0].submit();
 }
</script>
</body>
</html>  