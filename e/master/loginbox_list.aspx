<% @ Page Language="C#" Inherits="PageAdmin.loginbox_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="js_loginbox" />
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1 align="left"><b>会员登陆调用</b></td></tr>
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
                  <td align=center width=15% class=white height=25px>名称</td>
                  <td align=center width=10% class=white>显示方式</td>
                  <td align=center width=10% class=white>注册链街</td>
                  <td align=center width=10% class=white>验证码</td>
                  <td align=center width=10% class=white>按钮文本</td>
                  <td align=center width=15% class=white>转向url</td>
                  <td align=center width=10% class=white>序号</td>
                  <td align=center width=5% class=white>创建人</td>
                  <td align=center width=15% class=white>管理</td>
                </tr>
          <asp:Repeater id="DL_1" runat="server"  OnItemDataBound="Data_Bound">          
             <ItemTemplate>
                <tr class="listitem">
                  <td align=left  class=tdstyle><input type="checkbox" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>">
                    <asp:TextBox id="Tb_name" maxlength="45" size="12" Text='<%#DataBinder.Eval(Container.DataItem,"name")%>' runat="server" /></td>
                  <td align=center  class=tdstyle>
                    <asp:DropDownList id="Dl_Style" runat="server">
                      <asp:ListItem Value="0">纵向</asp:ListItem>
                      <asp:ListItem Value="1">横向</asp:ListItem>
                    </asp:DropDownList>
                   </td>

                  <td align=center  class=tdstyle>
                    <asp:DropDownList id="Dl_Reg" runat="server">
                      <asp:ListItem Value="0">关闭</asp:ListItem>
                      <asp:ListItem Value="1">开启</asp:ListItem>
                    </asp:DropDownList>
                   </td>

                  <td align=center  class=tdstyle>
                    <asp:DropDownList id="Dl_Code" runat="server">
                      <asp:ListItem Value="0">关闭</asp:ListItem>
                      <asp:ListItem Value="1">开启</asp:ListItem>
                    </asp:DropDownList>
                   </td>

                  <td align=center  class=tdstyle>
                    <asp:TextBox id="Tb_logintext" Text='<%#DataBinder.Eval(Container.DataItem,"login_text")%>' runat="server" size="6" MaxLength="20"/>
                   </td>

                  <td align=center class=tdstyle>
                    <asp:TextBox id="Tb_tourl" Text='<%#DataBinder.Eval(Container.DataItem,"tourl")%>' runat="server" size="15" MaxLength="50"/>
                   </td>

                  <td align=center  class=tdstyle>
                    <asp:TextBox id="Tb_xuhao" Text='<%#DataBinder.Eval(Container.DataItem,"xuhao")%>' runat="server" size="3" MaxLength="5"/>
                   </td>
                   <td align=center  class=tdstyle><%#DataBinder.Eval(Container.DataItem,"username")%></td>
                  <td align=center class=tdstyle>
                   <asp:Label id="Lb_id" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' runat="server" visible="false"/>
                   <asp:Label id="Lb_style" Text='<%#DataBinder.Eval(Container.DataItem,"style")%>' runat="server" visible="false"/>
                   <asp:Label id="Lb_code" Text='<%#DataBinder.Eval(Container.DataItem,"code")%>' runat="server" visible="false"/>
                   <asp:Label id="Lb_reg" Text='<%#DataBinder.Eval(Container.DataItem,"showreg")%>' runat="server" visible="false"/>
                   <a href="javascript:Js_Code('<%#DataBinder.Eval(Container.DataItem,"id")%>','0','loginbox')">获取调用代码</a>
                   <a href="javascript:del('<%#DataBinder.Eval(Container.DataItem,"id")%>','<%#DataBinder.Eval(Container.DataItem,"name")%>')">删除</a>
                  </td>
                </tr>
             </ItemTemplate>
         </asp:Repeater>
         <tr style="display:<%=ListCounts==0?"none":""%>">
          <td colspan="9" align="left" class="tdstyle">
          <input type="hidden" value="" name="ids" id="ids">
          <input type="hidden" value="" name="act" id="act">
          <input type="hidden" value="" name="delname" id="delname">
          <input type="button" class="button" value="反选" onclick="CheckBox_Inverse('CK')"/>
          <input type="submit" value="更新" class="button" id="sbt" onclick="return set('update')"/>
           [<a href="javascript:set('pdelete')">删除</a>]
          </td>
        </tr>
        </table>
       </td>
    </tr>
   </table>
  <tr>
 </table>
<br>

<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
    <table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
    <tr><td  colspan=3 height=25><b>增加会员登陆调用</b></td>
    </tr>
      <tr>
        <td  height=25 align="left">名称：<asp:TextBox id="Add_Name" maxlength="45" size=10 runat="server" />
                     显示：<asp:DropDownList id="Add_Style" runat="server">
                      <asp:ListItem Value="0">纵向</asp:ListItem>
                      <asp:ListItem Value="1">横向</asp:ListItem>
                    </asp:DropDownList>

注册链接：<asp:DropDownList id="Add_Reg" runat="server">
                      <asp:ListItem Value="0">关闭</asp:ListItem>
                      <asp:ListItem Value="1">开启</asp:ListItem>
                    </asp:DropDownList>
验证码：
<asp:DropDownList id="Add_Code" runat="server">
                      <asp:ListItem Value="0">关闭</asp:ListItem>
                      <asp:ListItem Value="1">开启</asp:ListItem>
                    </asp:DropDownList>
按钮文本：<asp:TextBox id="Add_Logintext" Text=" 登录 " maxlength=20 size=5 runat="server" />
登录url转向：<asp:TextBox id="Add_ToUrl" Text="" maxlength=50 size=10 runat="server" />
序号：<asp:TextBox id="Add_xuhao"  Text="1" maxlength=5 size=2 runat="server" />
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

function addck()
 {
  var Add_Name=document.getElementById("Add_Name");
  if(Add_Name.value=="")
    {
      alert("请填写名称!");
      Add_Name.focus();
      return false;
    }
      return true;
 }
</script>
</body>
</html>  