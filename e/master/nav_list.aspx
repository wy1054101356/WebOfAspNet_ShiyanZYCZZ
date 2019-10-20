<% @ Page Language="C#" Inherits="PageAdmin.nav_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="lanmu_nav"/>
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload(true)" title="点击刷新"><b>导航管理</b></a></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">

<form runat="server" >
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>

<table border=0 cellpadding=0 cellspacing=0 width=95% align=center>
<tr>
  <td  colspan=2 height=25><b>当前位置：</b><a href=<%if(IsZt==1){%>zt_list.aspx<%}else{%>lanmu_list.aspx<%}%>><%if(IsZt==1){%>专题管理<%}else{%>栏目管理<%}%>(<%=Request.QueryString["lanmuname"]%>)</a> &gt; 导航管理</td>
 </tr>
</table>

    <table border=0 cellpadding=0 cellspacing=0 width=95% align=center>
      <tr>
        <td height=25>  

             <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle id="tb_navlist">
                 <tr>
                      <td align=center class=white height=20>导航栏名称</td>
                      <td align=center class=white>导航栏类型</td>
                      <td align=center class=white>导航栏位置</td>
                      <td align=center class=white>序号</td>
                      <td align=center class=white>显示</td>
                      <td align=center class=white>管理</td>
                    </tr>
                 <asp:Repeater id="Navlist" runat="server" OnItemDataBound="Data_Bound"> 
                 <ItemTemplate>
                      <tr class="listitem">
                      <td align=left  class=tdstyle height=20 nowrap>
                       <input type="checkbox" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>">
                      <asp:TextBox id="tb_name" runat="server"  size="20" maxlength="100" Text='<%#DataBinder.Eval(Container.DataItem,"name")%>'/></td>
                      <td align=center class=tdstyle nowrap>
                     <asp:DropDownList id="DL_Type" runat="server" >
                       <asp:listItem value="sublanmu">子栏目</asp:ListItem>
                       <asp:listItem value="zdy">自定义内容</asp:ListItem>
                     </asp:DropDownList>
                      </td>
                   <td align=center class=tdstyle nowrap>
                     <asp:DropDownList id="DL_Layout" runat="server" >
                     <asp:listItem value="0" >页面左侧</asp:ListItem>
                     <asp:listItem value="1" style="color:#ff0000">页面右侧</asp:ListItem>
                     </asp:DropDownList>
                      </td>

                      <td align=center class=tdstyle nowrap><asp:TextBox id="tb_xuhao" runat="server" size="3" maxlength="5" Text='<%#DataBinder.Eval(Container.DataItem,"xuhao")%>'/></td>
                      <td align=center class=tdstyle nowrap>
                     <asp:DropDownList id="DL_Show" runat="server" >
                     <asp:listItem value="1">显示</asp:ListItem>
                     <asp:listItem value="0" style="color:#ff0000">隐藏</asp:ListItem>
                     </asp:DropDownList>
                     </td>
                      <td align=left class=tdstyle nowrap>
                         <asp:Label id="Id"  runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' Visible="false" />
                         <asp:Label id="Lb_type"  runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"thetable")%>' Visible="false" />
                         <asp:Label id="Lb_show"  runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"show")%>' Visible="false" />
                         <asp:Label id="Lb_layout"  runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"layout")%>' Visible="false" />
                         <asp:Hyperlink id="subLanmu_set" runat="server" Text="子栏目管理" visible="false" NavigateUrl='<%#"sublanmu_list.aspx?iszt="+IsZt+"&lanmuid="+Request.QueryString["lanmuid"]+"&navid="+DataBinder.Eval(Container.DataItem,"id")+"&lanmuname="+Server.UrlEncode(Request.QueryString["lanmuname"])+"&navname="+Server.UrlEncode(DataBinder.Eval(Container.DataItem,"name").ToString())%>' />
                         <asp:Hyperlink id="subLanmu_style" runat="server" Text="参数设置" visible="false" NavigateUrl='<%#"javascript:nav_set(\""+DataBinder.Eval(Container.DataItem,"id")+"\",\""+DataBinder.Eval(Container.DataItem,"thetable")+"\")"%>' />
                         <asp:Hyperlink id="nav_set" runat="server" Text="内容设置" visible="false"  NavigateUrl='<%#"javascript:nav_set(\""+DataBinder.Eval(Container.DataItem,"id")+"\",\""+DataBinder.Eval(Container.DataItem,"thetable")+"\")"%>' />
                         <a href="javascript:del('<%#DataBinder.Eval(Container.DataItem,"id")%>','<%#DataBinder.Eval(Container.DataItem,"name")%>')">删除</a>
                      </td>
                    </tr>                 
                    </ItemTemplate>
                    </asp:Repeater>
    <tr style="display:<%=NavCounts==0?"none":""%>">
      <td colspan="8" align="left" class="tdstyle">
<input type="button" class="button" value="反选" onclick="CheckBox_Inverse('CK')"/>
<input type="button" value="更新" class="button" id="sbt" onclick="set('update')"/>
[<a href="javascript:set('pset')">批设属性</a>]  [<a href="javascript:set('pdelete')">删除</a>]
    </td>
  </tr>
   </table>
<div align="center" style="padding:10px 0 5px 0">
<input type="hidden" value="" name="ids" id="ids">
<input type="hidden" value="" name="act" id="act">
<input type="hidden" value="" name="delname" id="delname">
<input type="button" value="返回" Class="button" OnClick="location.href='<%if(IsZt==1){%>zt_list.aspx<%}else{%>lanmu_list.aspx<%}%>'">
</div>
      </td>
    </tr>
   </table>
  </td>
  <tr>
 </table>
<br>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center class=table_style2>
<tr>
  <td valign=top>
    <table border=0 cellpadding=0 cellspacing=2 width=100% align=center>
    <tr><td  colspan=3 height=25><b>增加导航栏</b></td>
    </tr>
      <tr>
        <td  height=25 align="left">
<asp:Label id="LanmuId"    runat="server"  visible="false"/>
导航栏名称：<asp:TextBox  id="Add_Name"  maxlength="100" size="25"  runat="server" />
导航栏类型：<asp:DropDownList id="Add_Type" runat="server">
                     <asp:listItem value="sublanmu">子栏目</asp:ListItem>
                     <asp:listItem value="zdy">自定义内容</asp:ListItem>
       </asp:DropDownList> 

导航栏位置：<asp:DropDownList id="Add_Layout" runat="server" >
                     <asp:listItem value="0" >页面左侧</asp:ListItem>
                     <asp:listItem value="1" style="color:#ff0000">页面右侧</asp:ListItem>
</asp:DropDownList>

序号：<asp:TextBox id="AddXuhao"  text="1" maxlength=5 size=5 runat="server" />
<asp:button  CssClass="button"  Text="增加" runat="server" OnClick="Data_Add"/>
        </td>
    </tr>
   </table>
</td>
</tr>
</table>
<div style="padding:10px 0 0 0"><asp:Label id="LblErr" runat="server" /></div>
</form>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
MouseoverColor("tb_navlist");
SetCookie("tab","0");
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
      alert("请选择要操作的导航!");
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
      Nav_PSet();
      return;
    break;
    }
  document.getElementById("act").value=act;
  document.getElementById("ids").value=Ids;
  document.forms[0].submit();
 }
    
function Nav_PSet()
 {
   IDialog("导航批设置","nav_pset.aspx?lanmuid=<%=Request.QueryString["lanmuid"]%>&lanmuname=<%=Request.QueryString["lanmuname"]%>",800,550);
 }
  
function nav_set(Id,thetable)
 {
  url="nav_set.aspx?iszt=<%=IsZt%>&lanmuid=<%=Request.QueryString["lanmuid"]%>&navid="+Id+"&table="+thetable;
  IDialog("导航设置",url,"95%","90");
}
</script>
</body>
</html>