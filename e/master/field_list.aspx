<% @ Page Language="C#" Inherits="PageAdmin.field_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="field_list" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload()" title="点击刷新"><b>字段管理</b></a></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<form runat="server" >
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center class=table_style2>
<tr>
  <td valign=top align=center>
<table border=0 cellpadding=0 cellspacing=0 width=95% align=center>
<tr>
  <td height=25 align=left><b>当前位置</b>：字段管理(<%=Request.QueryString["tablename"]%>)</td>
   <td align="right">[<a href='javascript:Field_Dialog("增加新字段","field_add.aspx?&table=<%=Request.QueryString["table"]%>&tablename="+encodeURI("<%=Request.QueryString["tablename"]%>")+"&act=add")'>增加新字段</a>]</td>
 </tr>
</table>
       <table border=0 cellpadding=0 cellspacing=0 width=95% class=tablestyle id="tb_list" align=center>
          <asp:Repeater id="DL_1" runat="server" OnItemDataBound="Data_Bound" >
             <HeaderTemplate>
                <tr>
                  <td nowrap><input type="checkbox" onclick="CheckBox_Inverse('CK')" title="反选"/></td>
                  <td align=center class=white height=25px nowrap width=15>字段名</td>
                  <td align=center class=white height=25px nowrap>字段</td>
                  <td align=center class=white height=25px nowrap>字段类型</td>
                  <td align=center class=white height=25px nowrap>必填项</td>
                  <td align=center class=white height=25px nowrap>后台发布</td>
                  <td align=center class=white height=25px nowrap>会员发布</td>
                  <td align=center class=white height=25px nowrap>可增加</td>
                  <td align=center class=white height=25px nowrap>可修改</td>
                  <%if(TheTable!="pa_member")
                   {
                  %>
                  <td align=center class=white height=25px nowrap>匿名投稿</td>
                  <td align=center class=white height=25px nowrap>采集项</td>
                  <td align=center  class=white height=25px nowrap>排序项</td>
                  <!--<td align=center  class=white height=25px nowrap>搜索</td>-->
                  <%}%>
                  <td align=center class=white height=25px nowrap>序号</td>
                  <td align=center class=white nowrap>管理</td>
                </tr>
             </HeaderTemplate>            
             <ItemTemplate>
                <tr class="listitem">
                  <td nowrap style="width:10px" class=tdstyle><input type="checkbox" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>"></td>
                  <td align=center nowrap class=tdstyle><asp:TextBox id="Tb_Title" Text='<%#DataBinder.Eval(Container.DataItem,"field_name")%>' runat="server" style="width:120px" maxlength=20/></td>
                  <td align=center nowrap class=tdstyle><asp:Label id="Lb_Field" Text='<%#DataBinder.Eval(Container.DataItem,"field")%>' runat="server"/></td>
                  <td align=center nowrap  class=tdstyle><%#Get_Field_type(DataBinder.Eval(Container.DataItem,"field_type").ToString())%>(<%#DataBinder.Eval(Container.DataItem,"value_type")%>)</td>
                  <td align=center nowrap  class=tdstyle><asp:CheckBox id="Dl_mustitem" runat="server"/></td>
                  <td align=center nowrap class=tdstyle title="是否是后台发布项"><asp:CheckBox id="Dl_masteritem" runat="server"/></td>
                  <td align=center nowrap  class=tdstyle title="是否是会员发布项"><asp:CheckBox id="Dl_memberitem" runat="server"/></td>
                  <td align=center nowrap  class=tdstyle title="只对会员有效"><asp:CheckBox id="Dl_additem" runat="server"/></td>   
                  <td align=center nowrap  class=tdstyle title="只对会员有效"><asp:CheckBox id="Dl_edititem" runat="server"/></td>  
                  <%if(TheTable!="pa_member")
                   {
                  %>
                  <td align=center nowrap  class=tdstyle title="是否在发布表单代码中生成此字段代码"><asp:CheckBox id="Dl_tgitem" runat="server" /></td>     
                  <td align=center nowrap  class=tdstyle><asp:CheckBox id="Dl_collectionitem" runat="server" /></td> 
                  <td align=center nowrap  class=tdstyle><asp:CheckBox id="Dl_sortitem" runat="server"/></td>
                  <!--<td align=center nowrap class=tdstyle><%#Get_SearchType(DataBinder.Eval(Container.DataItem,"searchitem").ToString())%></td>-->
                 <%}%>

                  <td align=center nowrap class=tdstyle><asp:TextBox id="Tb_Xuaho" Text='<%#DataBinder.Eval(Container.DataItem,"xuhao")%>' runat="server" size=2 maxlength=3/></td>
                  <td align=center class=tdstyle>

                   <asp:Label id="Lb_mustitem" Text='<%#DataBinder.Eval(Container.DataItem,"mustitem")%>' runat="server" visible="false"/>
                   <asp:Label id="Lb_tgitem" Text='<%#DataBinder.Eval(Container.DataItem,"tgitem")%>' runat="server" visible="false"/>
                   <asp:Label id="Lb_memberitem" Text='<%#DataBinder.Eval(Container.DataItem,"memberitem")%>' runat="server" visible="false"/>
                   <asp:Label id="Lb_masteritem" Text='<%#DataBinder.Eval(Container.DataItem,"masteritem")%>' runat="server" visible="false"/>

                   <asp:Label id="Lb_additem" Text='<%#DataBinder.Eval(Container.DataItem,"additem")%>' runat="server" visible="false"/>
                   <asp:Label id="Lb_edititem" Text='<%#DataBinder.Eval(Container.DataItem,"edititem")%>' runat="server" visible="false"/>

                   <asp:Label id="Lb_collectionitem" Text='<%#DataBinder.Eval(Container.DataItem,"collectionitem")%>' runat="server" visible="false"/>
                   <asp:Label id="Lb_sortitem" Text='<%#DataBinder.Eval(Container.DataItem,"sortitem")%>' runat="server" visible="false"/>
                   <asp:Label id="Lb_type" Text='<%#DataBinder.Eval(Container.DataItem,"field_type")%>' runat="server" visible="false"/>
                   <asp:Label id="Lb_sysfield" Text='<%#DataBinder.Eval(Container.DataItem,"sys_field")%>' runat="server" visible="false"/>
                   <asp:Label id="Lb_id" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' runat="server" visible="false"/>
                   <a href='javascript:Field_Dialog("修改字段","field_add.aspx?id=<%#DataBinder.Eval(Container.DataItem,"id")%>&table=<%=Request.QueryString["table"]%>&tablename="+encodeURI("<%=Request.QueryString["tablename"]%>")+"&act=edit")'>编辑</a>
                   <asp:LinkButton id="Delete" CommandName='<%#DataBinder.Eval(Container.DataItem,"field")%>' CommandArgument='<%#DataBinder.Eval(Container.DataItem,"id")%>' OnCommand="Data_Delete" runat="server" Text="删除"  />
                  </td>
                </tr>
             </ItemTemplate>
         </asp:Repeater>
     <tr><td colspan="14" align="left" class="tdstyle">
       <input type="hidden" value="" name="ids" id="ids">
       <input type="button" class="button" value="反选" onclick="CheckBox_Inverse('CK')"/>
       [<a href="javascript:set('pset')">批设属性</a>]<!--[<a href="javascript:set('pdelete')">删除</a>]-->
    </td></tr>
   </table>
    <br>
  <div align="center">
<asp:Button Text="更新" onclick="Data_Update" runat="server" cssclass=button/>
                  <%if(TheTable!="pa_member")
                   {
                  %>
<input type="button" class=button  value="返回"  onclick="location.href='table_list.aspx'">
                  <%}%>
</div>
  </td>
  </tr>
 </table>
</form>
<br>
注：修改或增加字段必须点"更新"才能更新表单文件。
</td>
</tr>
</table>
</center>
<script type="text/javascript">
MouseoverColor("tb_list");
function Field_Dialog(title,url)
 {
  General_Set(title,url);
 }

function set(act)
 {
   var Ids=Get_Checked("CK");
   var A_Ids=Ids.split(",");
   if(Ids=="")
    {
      alert("请选择要操作的字段!");
      return;
    }
   switch(act)
    {
     case "pdelete":
     if(!confirm("是否确定删除?"))
      {
        return;
      }
     break;

    case "pset":
      document.getElementById("ids").value=Ids;
      Field_PSet();
     return;
    break;
    }
   
  document.getElementById("act").value=act;
  document.getElementById("ids").value=Ids;
  document.forms[0].submit();
 }

function Field_PSet()
 {
   IDialog("字段属性批设置","field_pset.aspx?table=<%=Request.QueryString["table"]%>","90%","90%");
 }
</script>
</body>
</html>
