<% @ Page Language="C#" Inherits="PageAdmin.lanmu_list"%>
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
<form Runat="server">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
<table border=0 cellpadding=0 cellspacing=0 width=95% align=center>
<tr>
  <td  height=25><b>栏目列表</b></td>
 </tr>
</table>
    <table border=0 cellpadding=0 cellspacing=0 width=95% align=center>
      <tr>
        <td colspan=2 align="left">
            <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle align=center id="tb_lanmulist">
               <tr>
                  <td align=center class=white height=20  width=70%>栏目名称</td>
                  <td align=center class=white height=20 >栏目类型</td>
                  <td align=center class=white height=20 style="display:none">目录</td>
                  <td align=center class=white style="display:none">目标</td>
                  <td align=center class=white style="display:none">显示</td>
                  <td align=center class=white style="display:none">序号</td>
                  <td align=center class=white>二级导航</td>
                </tr>
          <asp:Repeater id="lanmulist" runat="server" OnItemDataBound="PageAdmin_Data_Bound">           
             <ItemTemplate>
                <tr class="listitem">
                  <td align=left  class=tdstyle nowrap><input type="checkbox" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>"><asp:TextBox id="Tb_Lanmu" Visible="false" Text='<%#DataBinder.Eval(Container.DataItem,"name")%>' runat="server" size="20" maxlength="50"/>
<a href="<%#Get_Url(DataBinder.Eval(Container.DataItem,"id").ToString(),DataBinder.Eval(Container.DataItem,"thetype").ToString(),DataBinder.Eval(Container.DataItem,"lanmu_dir").ToString(),DataBinder.Eval(Container.DataItem,"zdy_url").ToString())%>" target=_blank><%#DataBinder.Eval(Container.DataItem,"name")%></a>
                  </td>

                    <td align=center  class=tdstyle nowrap>
                    <select style="width:80px" disabled><option><asp:Literal id="Lb_Type" Text='<%#DataBinder.Eval(Container.DataItem,"thetype")%>' runat="server"/></option></select>
                    </td>
                  <td align=left  class=tdstyle style="display:none"><%#DataBinder.Eval(Container.DataItem,"site_dir").ToString()==""?"/":"/"+DataBinder.Eval(Container.DataItem,"site_dir").ToString()+"/"%><asp:TextBox id="Tb_lanmudir" Text='<%#DataBinder.Eval(Container.DataItem,"lanmu_dir")%>' runat="server" size=10 maxlength="40" /></td>

                  <td align=center class=tdstyle nowrap style="display:none">
                     <asp:DropDownList id="DL_Target" runat="server" >
                     <asp:listItem value="_self">本窗口</asp:ListItem>
                     <asp:listItem value="_blank" style="color:#ff0000">新窗口</asp:ListItem>
                     </asp:DropDownList>
                   </td>

                  <td align=center  class=tdstyle nowrap style="display:none">
                     <asp:DropDownList id="DL_Show" runat="server" >
                     <asp:listItem value="1">显示</asp:ListItem>
                     <asp:listItem value="0" style="color:#ff0000">隐藏</asp:ListItem>
                     </asp:DropDownList>
                   </td>

                <td align=center class=tdstyle nowrap style="display:none">
                    <asp:TextBox id="Xuhao" Text='<%#DataBinder.Eval(Container.DataItem,"xuhao")%>' runat="server" size="2" maxlength="3" />
                </td>

                  <td align=center class=tdstyle nowrap>
                    <asp:Label id="Id" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' runat="server" visible="false" />
                    <asp:Label id="Lb_LanmuShow" Text='<%#DataBinder.Eval(Container.DataItem,"show")%>' runat="server" visible="false" />
                    <asp:Label id="Lb_Target" Text='<%#DataBinder.Eval(Container.DataItem,"target")%>' runat="server" visible="false" />
                   <asp:Hyperlink id="Nav_Set" runat="server" Text="进入导航界面"   NavigateUrl='<%#"task_nav_list.aspx?lanmuid="+DataBinder.Eval(Container.DataItem,"id")+"&lanmuname="+Server.UrlEncode(DataBinder.Eval(Container.DataItem,"name").ToString())%>' />
                   <asp:Hyperlink visible="false"  id="Module_Set" runat="server" Text="模块管理"  NavigateUrl='<%#"module_list.aspx?lanmuid="+DataBinder.Eval(Container.DataItem,"id")+"&lanmuname="+Server.UrlEncode(DataBinder.Eval(Container.DataItem,"name").ToString())%>' />
                   <asp:Hyperlink visible="false"  id="Lanmu_Set"  runat="server"  NavigateUrl='<%#"javascript:Lanmu_Set(\"lanmu_set.aspx?&id="+DataBinder.Eval(Container.DataItem,"id")+"\",\""+DataBinder.Eval(Container.DataItem,"name").ToString()+"\")"%>'  Text="栏目设置" />
                   
                </td>
                </tr>
             </ItemTemplate>
             <FooterTemplate>
         <tr>
          <td colspan="7" align="left" class="tdstyle" style="display:<%=LanmuCounts==0?"none":""%>">
          <input type="hidden" value="" name="ids" id="ids">
          <input type="hidden" value="" name="act" id="act">
          <input type="hidden" value="" name="delname" id="delname">
          <input type="button" class="button" value="反选" onclick="CheckBox_Inverse('CK')"/>
          <input type="button" value="选择" class="button" id="sbt" onclick="Get_Select()"/>
          </td>
         </tr>
   </FooterTemplate>
  </asp:Repeater>
        </table><br>
       </td>
    </tr>
   </table>
  </td>
  <tr>
 </table>
</form>
<div align=center style="padding-top:10px"><input type="button" value="关闭" class="button" id="sbt" onclick="parent.CloseDialog()"/></div>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
MouseoverColor("tb_lanmulist");
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
     alert("请选择要刷新的栏目!");
     return;
   }
  parent.AddSelect(Ids,"lanmu");
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



