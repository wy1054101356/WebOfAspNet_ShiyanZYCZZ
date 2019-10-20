<% @ Page Language="C#" Inherits="PageAdmin.lanmu_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="lanmu_admin"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload(true)" title="点击刷新"><b>栏目管理</b></a></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<div id="tabdiv">
<ul>
<li id="tab" name="tab" style="font-weight:bold">栏目管理</li>
<li id="tab" name="tab" onclick="location.href='lanmu_add.aspx'">增加栏目</li>
</ul>
</div>
<form Runat="server">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
<table border=0 cellpadding=0 cellspacing=0 width=95% align=center>
<tr>
  <td  height=25><b>栏目管理</b></td>
 </tr>
</table>
    <table border=0 cellpadding=0 cellspacing=0 width=95% align=center>
      <tr>
        <td colspan=2 align="left">
            <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle align=center id="tb_lanmulist">
               <tr>
                  <td align=center class=white height=20>栏目名称</td>
                  <td align=center class=white height=20>类型</td>
                  <td align=center class=white height=20>目录</td>
                  <td align=center class=white>目标</td>
                  <td align=center class=white>显示</td>
                  <td align=center class=white>序号</td>
                  <td align=center class=white>栏目管理</td>
                </tr>
          <asp:Repeater id="lanmulist" runat="server" OnItemDataBound="PageAdmin_Data_Bound">           
             <ItemTemplate>
                <tr class="listitem">
                  <td align=left  class=tdstyle nowrap><input type="checkbox" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>"> <asp:TextBox id="Tb_Lanmu" Text='<%#DataBinder.Eval(Container.DataItem,"name")%>' runat="server" size="20" maxlength="50"/>
<a href="<%#Get_Url(DataBinder.Eval(Container.DataItem,"id").ToString(),DataBinder.Eval(Container.DataItem,"thetype").ToString(),DataBinder.Eval(Container.DataItem,"lanmu_dir").ToString(),DataBinder.Eval(Container.DataItem,"zdy_url").ToString())%>" target=_blank><img src=images/sign_detail.gif border=0 title="预览" align="absmiddle"></a>
                  </td>

                    <td align=center  class=tdstyle nowrap>
                    <select style="width:80px" disabled><option><asp:Literal id="Lb_Type" Text='<%#DataBinder.Eval(Container.DataItem,"thetype")%>' runat="server"/></option></select>
                    </td>
                  <td align=left  class=tdstyle><%#DataBinder.Eval(Container.DataItem,"site_dir").ToString()==""?"/":"/"+DataBinder.Eval(Container.DataItem,"site_dir").ToString()+"/"%><asp:TextBox id="Tb_lanmudir" Text='<%#DataBinder.Eval(Container.DataItem,"lanmu_dir")%>' runat="server" size=10 maxlength="40" /></td>

                  <td align=center class=tdstyle nowrap>
                     <asp:DropDownList id="DL_Target" runat="server" >
                     <asp:listItem value="_self">本窗口</asp:ListItem>
                     <asp:listItem value="_blank" style="color:#ff0000">新窗口</asp:ListItem>
                     </asp:DropDownList>
                   </td>

                  <td align=center  class=tdstyle nowrap>
                     <asp:DropDownList id="DL_Show" runat="server" >
                     <asp:listItem value="1">显示</asp:ListItem>
                     <asp:listItem value="0" style="color:#ff0000">隐藏</asp:ListItem>
                     </asp:DropDownList>
                   </td>

                <td align=center class=tdstyle nowrap>
                    <asp:TextBox id="Xuhao" Text='<%#DataBinder.Eval(Container.DataItem,"xuhao")%>' runat="server" size="2" maxlength="3" />
                </td>

                  <td align=left class=tdstyle nowrap>
                    <asp:Label id="Id" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' runat="server" visible="false" />
                    <asp:Label id="Lb_LanmuShow" Text='<%#DataBinder.Eval(Container.DataItem,"show")%>' runat="server" visible="false" />
                    <asp:Label id="Lb_Target" Text='<%#DataBinder.Eval(Container.DataItem,"target")%>' runat="server" visible="false" />
                   <asp:Hyperlink id="Nav_Set" runat="server" Text="导航管理"   NavigateUrl='<%#"nav_list.aspx?lanmuid="+DataBinder.Eval(Container.DataItem,"id")+"&lanmuname="+Server.UrlEncode(DataBinder.Eval(Container.DataItem,"name").ToString())%>' />
                   <asp:Hyperlink id="Module_Set" runat="server" Text="模块管理"  visible="true" NavigateUrl='<%#"module_list.aspx?lanmuid="+DataBinder.Eval(Container.DataItem,"id")+"&lanmuname="+Server.UrlEncode(DataBinder.Eval(Container.DataItem,"name").ToString())%>' />
                   <asp:Hyperlink id="Lanmu_Set"  runat="server"  NavigateUrl='<%#"javascript:Lanmu_Set(\"lanmu_set.aspx?&id="+DataBinder.Eval(Container.DataItem,"id")+"\",\""+DataBinder.Eval(Container.DataItem,"name").ToString()+"\")"%>'  Text="栏目设置" />
                   <%if(Can_Del=="1"){%><a href="javascript:del('<%#DataBinder.Eval(Container.DataItem,"id")%>','<%#DataBinder.Eval(Container.DataItem,"name").ToString()%>')">删除</a><%}%>
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
          <input type="button" value="更新" class="button" id="sbt" onclick="set('update')"/>
<%if(Is_Static=="1")
 {
%>
         <select name="htmltype" id="htmltype">
         <option value="0">生成栏目封面静态页</option>
         <option value="1">生成子栏目静态页</option>
         </select>&nbsp;<input type="button" class="button" value="生成" onclick="html()">
<%}%>
          [<a href="javascript:set('pset')">批设属性</a>] [<a href="javascript:set('pdelete')">删除</a>]
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

</td>
</tr>
</table>
</center>
<script type="text/javascript">
MouseoverColor("tb_lanmulist");
var htmltype=document.getElementById("htmltype");
function html()
 {
  var Ids=Get_Checked("CK");
  if(Ids=="")
     {
      alert("请选择要生成的栏目!");
      return;
     }
  else
     {
      if(htmltype.value=="0")
       {
         htm_panel("栏目封面页","pa_lanmu",Ids);
       }
      else
       {
         htm_panel("子栏目","pa_sublanmu",Ids);
       }
     }

 }

function del(did,dname)
 {
  <%if(Can_Del=="0"){%>
      alert("对不起，您没有删除栏目的权限");
      return;
  <%}%>
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
      alert("请选择要操作的栏目!");
      return;
    }
   switch(act)
    {
     case "pdelete":
     <%if(Can_Del=="0"){%>
      alert("对不起，您没有删除栏目的权限");
      return;
     <%}%>
     if(!confirm("是否确定删除?"))
      {
        return;
      }
     break;

    case "pset":
     <%if(Can_Edit=="0"){%>
      alert("对不起，您没有修改栏目的权限");
      return;
     <%}%>
      document.getElementById("ids").value=Ids;
      Lanmu_PSet();
     return;
    break;

    case "update":
     <%if(Can_Edit=="0"){%>
      alert("对不起，您没有修改栏目的权限");
      return;
     <%}%>
    break;

    }

  document.getElementById("act").value=act;
  document.getElementById("ids").value=Ids;
  document.forms[0].submit();
 }

function Lanmu_PSet()
 {
   IDialog("栏目批设置","lanmu_pset.aspx",800,550);
 }


function Lanmu_Set(url,name)
 {
   IDialog("栏目设置",url+"&lanmu="+encodeURI(name),"95%","90%");
 }

function htm_panel(Name,Table,Ids)
 {
  var Width=400;
  var Height=180;
  if(Table=="pa_sublanmu")
   {
    IDialog("子栏目页静态生成","static_panel.aspx?table="+Table+"&lanmuids="+Ids,Width,Height);
   }
  else
   {
    IDialog("栏目页静态生成","static_panel.aspx?table="+Table+"&lanmuids="+Ids,Width,Height);   }
 }

SetCookie("tab","0");
SetCookie("currentnode","");
SetCookie("currentnodes","");
</script>
</body>
</html>  



