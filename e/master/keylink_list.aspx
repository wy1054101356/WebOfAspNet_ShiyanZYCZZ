<% @ Page Language="C#" Inherits="PageAdmin.keylink_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="basic_keylinklist" />
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.href=location.href" title="点击刷新"><b>关键词管理</b></a></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">

<form runat="server" >
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
<table border=0 cellpadding=0 cellspacing=0 width=95%  style="table-layout:fixed;" align=center>
<tr>
<td align="left" width="110px">
每页<asp:TextBox id="Tb_pagesize" style="width:30px" maxlength="10"  Runat="server" Text="20" />条记录
</td>
<td align="right">
关键字<input text="text" id="s_keyword" style="width:80px">
<select id="s_field">
<option value="key">关键词</option>
<option value="link">关键词链接</option>
</select>
<input type="button" value="确定" class="button" onclick="Go()">
 </td>
 </tr>
</table>

 <table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
      <tr>
        <td  colspan=2 height=25>
                <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle id="tb_list">
                <tr>
                  <td align=center width=20% class=white height=25px>关键词</td>
                  <td align=center width=50% class=white>链接</td>
                  <td align=center width=30% class=white>管理</td>
                </tr>
          <asp:Repeater id="DL_1" runat="server" OnItemDataBound="Data_Bound">         
             <ItemTemplate>
                <tr class="listitem">
                  <td align=left class=tdstyle><input type="checkbox" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>"><asp:Label id="Lb_Name" Text='<%#DataBinder.Eval(Container.DataItem,"key")%>' Runat="server"/></td>
                  <td align=center class=tdstyle><%#DataBinder.Eval(Container.DataItem,"link")%></td>
                  <td align=center  class=tdstyle>
                   <asp:Label id="Lb_id" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' runat="server" visible="false"/>
                   <a href="javascript:modify(<%#DataBinder.Eval(Container.DataItem,"id")%>)">修改</a>

                   <a href="javascript:del('<%#DataBinder.Eval(Container.DataItem,"id")%>','<%#DataBinder.Eval(Container.DataItem,"key")%>')">删除</a>
                  </td>
                </tr>
             </ItemTemplate>
         </asp:Repeater>
       <tr style="display:<%=ListCounts==0?"none":""%>">
          <td colspan="3" align="left" class="tdstyle">
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
    <tr><td  colspan=3 height=25><b>增加关键词链接</b></td>
    </tr>
      <tr>
        <td  height=25>
关键词：<asp:TextBox id="Add_Key" maxlength=40 size=20  runat="server" />
链接：<asp:TextBox id="Add_Link" maxlength=40 size=40  runat="server" />

<asp:button  CssClass="button"  Text="增加" runat="server" OnClick="Data_Add" onclientclick="return ck()" />
        </td>
    </tr>
   </table>
</td>
</tr>
</table>
<br><asp:Label id="LblErr" runat="server"  Text="<span style='color:#ff0000'>出错：</span>关键词已经存在，请更换一个关键词重新增加！" Visible="false"/>
</form>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
MouseoverColor("tb_list");

var obj_pagesize=document.getElementById("Tb_pagesize");
var obj_field=document.getElementById("s_field");
var obj_keyword=document.getElementById("s_keyword");

var Field="<%=Request.QueryString["field"]%>";
var Keyword="<%=Request.QueryString["keyword"]%>";
if(obj_field!=null && Field!=""){obj_field.value=Field;}
if(obj_keyword!=null){obj_keyword.value=Keyword;}

function Go()
 { 
  location.href="?field="+obj_field.value+"&keyword="+escape(obj_keyword.value)+"&pagesize="+obj_pagesize.value;
 }

function modify(id)
 {
  IDialog("关键词链接修改","keylink_set.aspx?id="+id,600,150);
 }

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

function ck()
 {
   var Add_Key=document.getElementById("Add_Key");
   var Add_Link=document.getElementById("Add_Link");
   if(Trim(Add_Key.value)=="")
    {
      alert("请填写关键词!");
      Add_Key.focus();
      return false;
    }
   if(Trim(Add_Link.value)=="")
    {
      alert("请填写关键词链接地址!");
      Add_Link.focus();
      return false;
    }
   return true;
 }
</script>
</body>
</html> 