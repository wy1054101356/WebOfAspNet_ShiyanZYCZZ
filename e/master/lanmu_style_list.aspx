<% @ Page Language="C#" Inherits="PageAdmin.lanmu_style_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="lanmu_style"/>
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload()" title="点击刷新"><b><%=TypeName%>自定义样式</b></a></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<form runat="server" >
<div id="tabdiv">
<ul>
<li id="tab" name="tab" onclick="location.href='?type=nav'">导航样式</li>
<li id="tab" name="tab" onclick="location.href='?type=module'">模块样式</li>
</ul>
</div>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">

<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr>
  <td  colspan=2 height=25><b><%=TypeName%>样式管理</b></td>
 </tr>
</table>

    <table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
      <tr>
        <td colspan=2 height=25>
          <table border=0 cellpadding=3 cellspacing=0 width=100% class=tablestyle id="tb_list">
                <tr>
                  <td align=center width=25% class=white height=25px>样式标识</td>
                  <td align=center width=15% class=white>序号</td>
                  <td align=center width=40% class=white height=25px>应用</td>
                  <td align=center width=20% class=white>管理</td>
                </tr>
          <asp:Repeater id="DL_1" runat="server" OnItemDataBound="Data_Bound">           
             <ItemTemplate>
                <tr class="listitem">
                  <td align=left  class=tdstyle>
                    <input type="checkbox" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>">
                    <asp:TextBox  id="Tb_name"  Text='<%#DataBinder.Eval(Container.DataItem,"name")%>' runat="server" /></td>
                  <td align=center width=15%  class=tdstyle>
                    <asp:TextBox Id="Tb_xuhao" Text='<%#DataBinder.Eval(Container.DataItem,"xuhao")%>' runat="server" size="5" MaxLength="5"/>
                   </td>
                  <td align=center  class=tdstyle>
                    <asp:DropDownList id="Used_Nav" DataTextField="name" runat="server" />
                   </td>
                  <td align=center class=tdstyle>
                   <asp:Label id="Lb_id" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' runat="server" visible="false"/>
                   <a href="javascript:style_set('lanmu_style_set.aspx?id=<%#DataBinder.Eval(Container.DataItem,"id")%>&type=<%=Thetype%>&name=<%#DataBinder.Eval(Container.DataItem,"name")%>')">设置</a>
                   <a href="lanmu_style_set.aspx?id=<%#DataBinder.Eval(Container.DataItem,"id")%>&type=<%=Thetype%>&act=add&name=<%#Server.UrlEncode(DataBinder.Eval(Container.DataItem,"name").ToString())%>">复制</a>
                   <a href="javascript:del('<%#DataBinder.Eval(Container.DataItem,"id")%>','<%#DataBinder.Eval(Container.DataItem,"name").ToString()%>')">删除</a>
                  </td>
                </tr>
             </ItemTemplate>
         </asp:Repeater>
         <tr>
          <td colspan="4" align="left" class="tdstyle" style="display:<%=ListCount==0?"none":""%>">
<input type="button" class="button" value="反选" onclick="CheckBox_Inverse('CK')"/>
<input type="hidden" value="" name="ids" id="ids">
<input type="hidden" value="" name="act" id="act">
<input type="hidden" value="" name="delname" id="delname">
<input type="button" value="更新" class="button" id="sbt" onclick="set('update')"/>
[<a href="javascript:set('pdelete')">删除</a>]
          </td>
         </tr>
         </table>
       </td>
    </tr>
   </table>
    <br>
  </td>
  <tr>
 </table>
<br>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
    <table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
    <tr><td  colspan=3 height=25><b>新增<%=TypeName%>样式</b></td>
    </tr>
      <tr>
        <td  height=25>样式标识：<asp:TextBox id="Add_Name" maxlength=40 size=20  runat="server" />
                    
          序号：<asp:TextBox id="Add_xuhao" Text="0" maxlength=5 size=5 runat="server" />
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
 function Load_Tab(num)
  {
    var Obj1=document.getElementsByName("tab");
    var k=0;
     for(k=0;k<Obj1.length;k++)
      {
       Obj1[k].style.fontWeight="normal";
      }
     Obj1[num].style.fontWeight="bold";
  }

var thetype="<%=Request.QueryString["type"]%>";
switch(thetype)
 {
   case "nav":
    Load_Tab(0);
   break;

   case "module":
    Load_Tab(1);
   break;

   default:
    Load_Tab(0);
   break;
 }

function del(did,dname)
 {
   if(confirm("确定删除吗?"))
   {
     document.getElementById("delname").value=dname;
     document.getElementById("ids").value=did;
     document.getElementById("act").value="del";
     document.forms[0].submit();
   }
 }

function set(act)
 {
   var Ids=Get_Checked("CK");
   var A_Ids=Ids.split(",");
   if(Ids=="")
    {
      alert("请选择要操作的记录!");
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
    }
  document.getElementById("act").value=act;
  document.getElementById("ids").value=Ids;
  document.forms[0].submit();
 }

function style_set(url)
 {
  General_Set("样式设置",url);
 }
function style_copy(url)
 {
  General_Set("样式复制",url);
 }
</script>
</body>
</html>