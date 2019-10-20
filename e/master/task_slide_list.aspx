<% @ Page Language="C#" Inherits="PageAdmin.slide_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="basic_task"/>
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
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
                  <td align=center width=80% class=white height=25px >幻灯片名称</td>
                  <td align=center width=15% class=white style="display:none">序号</td>
                  <td align=center width=20% class=white>创建人</td>
                  <td align=center width=35% class=white style="display:none">管理</td>
                </tr>
          <asp:Repeater id="DL_1" runat="server" OnItemDataBound="Data_Bound">          
             <ItemTemplate>
                <tr class="listitem">
                  <td align=left class=tdstyle>
                   <input type="checkbox" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>"><asp:TextBox id="Tb_name"  maxlength="50"  Text='<%#DataBinder.Eval(Container.DataItem,"name")%>' runat="server" VisIble="false"/><%#DataBinder.Eval(Container.DataItem,"name")%></td>

                  <td align=center class=tdstyle  style="display:none">
                    <asp:TextBox Id="Tb_xuhao" Text='<%#DataBinder.Eval(Container.DataItem,"xuhao")%>' runat="server" size="5" MaxLength="5"/>
                   </td>
                   <td align=center  class=tdstyle><%#DataBinder.Eval(Container.DataItem,"username")%></td>
                  <td align=center class=tdstyle  style="display:none">
                   <asp:Label id="Lb_id" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' runat="server" visible="false"/>
                   <asp:Label id="Lb_style" Text='<%#DataBinder.Eval(Container.DataItem,"style")%>' runat="server" visible="false"/>
                  </td>
                </tr>
             </ItemTemplate>
         </asp:Repeater>
       <tr>
          <td colspan="2" align="left" class="tdstyle">
          <input type="hidden" value="" name="ids" id="ids">
          <input type="hidden" value="" name="act" id="act">
          <input type="hidden" value="" name="delname" id="delname">
          <input type="button" class="button" value="反选" onclick="CheckBox_Inverse('CK')"/>
          <input type="button" value="选择" class="button" id="sbt" onclick="Get_Select()"/>
          </td>
        </tr>
        </table>
       </td>
    </tr>
   </table>
  </td>
  <tr>
 </table>
<div align=center style="padding-top:10px"><input type="button" value="关闭" class="button" id="sbt" onclick="parent.CloseDialog()"/></div>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2 style="display:none">
<tr>
  <td valign=top>
    <table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
    <tr><td  colspan=3 height=25><b>增加幻灯片调用</b></td>
    </tr>
      <tr>
        <td  height=25>幻灯片名称：<asp:TextBox id="Add_Name" maxlength=40 size=20  runat="server" />
                      序号：<asp:TextBox id="Add_xuhao" Text="1" maxlength=5 size=5 runat="server" />
                      <asp:button  CssClass="button"  Text="增加" runat="server" OnClick="Data_Add" />
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
     alert("请选择要刷新的幻灯片!");
     return;
   }
  parent.AddSelect(Ids,"slide");
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