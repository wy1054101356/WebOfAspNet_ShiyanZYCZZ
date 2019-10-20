<% @ Page Language="C#"  Inherits="PageAdmin.data_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="zdydata"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload()" title="点击刷新"><b>信息列表</b></a></td></tr>
 <tr><td height=10 ></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">

<form runat="server">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">

<table border=0 cellpadding=0 cellspacing=0 width=95% align=center>
<tr>
  <td height=25><b>当前表</b>:<%=Request.QueryString["name"]%></td>
 </tr>
</table>

<table border=0 cellpadding=0 cellspacing=0 width=95%  style="table-layout:fixed;" align=center>
<tr>
<td align="left">
&nbsp;<select  name="sortid" id="sortid" onchange="T()"><option  value="">所有类别</option><%=Sort_List%></select>
每页<asp:TextBox id="Tb_pagesize" size="3" maxlength="10"  Runat="server"/>条记录
</td>
<td align="right">
<select id="s_type">
<option value="">任何属性</option>
<option value="noreply">未回复</option>
<option value="unchecked">未审核</option>
<option value="istop">置顶</option>
<option value="isgood">推荐</option>
<option value="isnew">最新</option>
<option value="ishot">热门</option>
</select>
<select id="s_order">
<option value="id desc">按ID↓</option>
<option value="id">按ID↑</option>
<option value="thedate desc">按发布时间↓</option>
</select>
关键字<input text="text" id="s_keyword" size="15">
<select id="s_field">
<option value="">搜索字段</option>
<option value="title">主题</option>
<option value="username">发布人</option>
<option value="tags">Tags</option>
</select>
<input type="button" value="搜索" class="button" onclick="Go()">
 </td>
 </tr>
</table>

<table border=0 cellpadding=0 cellspacing=0 width=95% align=center>
      <tr>
        <td    align="left">
            <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle >
                <tr>
                  <td align=center width=55% class=white>主题</td>
                  <td align=center width=15% class=white height=20>提交时间</td>
                  <td align=center width=10% class=white height=20>发布人</td>
                  <td align=center width=10% class=white height=20>状态</td>
                  <td align=center width=10% class=white>管理</td>
                </tr>
              </table>
           <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle style="table-layout:fixed;">
          <asp:Repeater id="P1" runat="server" OnItemDataBound="Data_Bound">         
             <ItemTemplate>
                 <tr>
                  <td align=left width=55% class="tdstyle"><input type="checkbox" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>"><img src=images/image.gif height=20px align=absmiddle title="带标题图片" style="display:<%#(DataBinder.Eval(Container.DataItem,"titlepic").ToString())==""?"none":""%>"><a href='<%#DetailUrl(DataBinder.Eval(Container.DataItem,"static_dir").ToString(),DataBinder.Eval(Container.DataItem,"lanmu_id").ToString(),DataBinder.Eval(Container.DataItem,"subLanmu_id").ToString(),DataBinder.Eval(Container.DataItem,"id").ToString(),DataBinder.Eval(Container.DataItem,"zdy_url").ToString())%>' target="_blank"><span <asp:Literal text="style='color:#cccccc'" runat="server" visible='<%#!Get_Bool(DataBinder.Eval(Container.DataItem,"checked").ToString())%>' />><asp:Label ForeColor="#ff0000" text="[顶]"  visible='<%#Get_Bool(DataBinder.Eval(Container.DataItem,"istop").ToString())%>' runat="server"/><asp:Label ForeColor="#ff0000" text="[荐]"  visible='<%#Get_Bool(DataBinder.Eval(Container.DataItem,"isgood").ToString())%>' runat="server"/><asp:Label ForeColor="#ff0000" text="[新]"  visible='<%#Get_Bool(DataBinder.Eval(Container.DataItem,"isnew").ToString())%>' runat="server"/><asp:Label ForeColor="#ff0000" text="[热]"  visible='<%#Get_Bool(DataBinder.Eval(Container.DataItem,"ishot").ToString())%>' runat="server"/><%#Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"title").ToString())%></span></a></td>
                  <td align=center width=15% class="tdstyle" title="<%#DataBinder.Eval(Container.DataItem,"thedate")%>"><%#DataBinder.Eval(Container.DataItem,"thedate")%></td>
                  <td align=center width=10% class=tdstyle><%#GetUserName(DataBinder.Eval(Container.DataItem,"username").ToString())%></td>
                  <td align=center width=10% class=tdstyle><%#Get_ReplyState(DataBinder.Eval(Container.DataItem,"reply_state").ToString())%></td>
                  <td align=center width=10% class="tdstyle">
                    <a href='fbk_reply.aspx?id=<%#DataBinder.Eval(Container.DataItem,"id")%>&table=<%#Request.QueryString["table"]%>&name=<%#Server.UrlEncode(Request.QueryString["name"])%>'>回复</a>
                    <a href='data_add.aspx?id=<%#DataBinder.Eval(Container.DataItem,"id")%>&table=<%#Request.QueryString["table"]%>&name=<%#Server.UrlEncode(Request.QueryString["name"])%>'>查看</a>
                    <asp:LinkButton Id="Delete" runat="server" Text="删除" CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' OnCommand="BT_Delete" />
                  </td>
                </tr>
             </ItemTemplate>
          </asp:Repeater>
<tr>
<td colspan="5" class=tdstyle>

<table border=0 width=100%>
 <tr><td>
<input type="button" class="button" value="反选" onclick="CheckBox_Inverse('CK')"/>
<a href="javascript:set('checked')">[审核]</a><a href="javascript:set('unchecked')">[取消审核]</a>

<a href="javascript:set('istop')">[置顶]</a><a href="javascript:set('nottop')">[取消置顶]</a>

<a href="javascript:set('isgood')">[推荐]</a><a href="javascript:set('notgood')">[取消推荐]</a>

<a href="javascript:set('isnew')">[最新]</a><a href="javascript:set('notnew')">[取消最新]</a>

<a href="javascript:set('ishot')">[热门]</a><a href="javascript:set('nothot')">[取消热门]</a>

<a href="javascript:set('delete')">[删除]</a>

</td>
<td align=right></td></tr></table>
</td></tr></table> 

<br>
<%if(ConfigurationManager.AppSettings["Html"].ToString()=="1")
 {
%>
<select  name="htmltype" id="htmltype"><option  value="0">生成选中信息</option><option  value="1">生成所有信息</option></select>
<input type="button" class="button" value="生成静态" onclick="html()"/>
<%}%>
共<asp:Label id="Lblrecordcount"  Text=0 runat="server" />条记录 
&nbsp;当前页次: <asp:Label id="Lblcurrentpage"  runat="server" />/<asp:Label id="LblpageCount"  runat="server" />&nbsp;
<asp:Button  text="上一页"  id="LblPrev"  class=button runat="server"  CommandName="Prev"   OnCommand="Bt_Click" />&nbsp;
<asp:Button  text="下一页"  id="LblNext"  class=button runat="server"  CommandName="Next"   OnCommand="Bt_Click" />&nbsp;
转到:&nbsp;<asp:DropDownList id="DLpage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Page_Changed"  /> 页&nbsp;

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

 var obj_sort=document.getElementById("sortid");
 var obj_type=document.getElementById("s_type");
 var obj_field=document.getElementById("s_field");
 var obj_order=document.getElementById("s_order");
 var obj_keyword=document.getElementById("s_keyword");
 var obj_pagesize=document.getElementById("Tb_pagesize");

 var Table="<%=Request.QueryString["table"]%>";
 var name="<%=Request.QueryString["name"]%>";

 var Sortid="<%=Request.QueryString["sortid"]%>";
 var Type="<%=Request.QueryString["type"]%>";
 var Field="<%=Request.QueryString["field"]%>";
 var Order="<%=Request.QueryString["order"]%>";
 var Keyword="<%=Request.QueryString["keyword"]%>";

 if(obj_sort!=null && Sortid!="0"){obj_sort.value=Sortid;}
 if(obj_type!=null){obj_type.value=Type;}
 if(obj_field!=null && Field!=""){obj_field.value=Field;}
 if(obj_order!=null && Order!=""){obj_order.value=Order;}
 if(obj_keyword!=null){obj_keyword.value=Keyword;}


  function T()
  { 
   location.href="?table="+Table+"&name="+escape(name)+"&sortid="+obj_sort.value+"&pagesize="+obj_pagesize.value;
  }
 function Go()
  { 
   location.href="?table="+Table+"&name="+escape(name)+"&sortid="+obj_sort.value+"&type="+obj_type.value+"&field="+obj_field.value+"&order="+obj_order.value+"&keyword="+escape(obj_keyword.value)+"&pagesize="+obj_pagesize.value;
  }

function Get_CheckBox(Name)
 {
   var Obj=document.getElementsByName(Name);
   var ID="0";
   for(i=0;i<Obj.length;i++)
     {
      if(Obj[i].checked)
       {
         ID+=","+Obj[i].value;
       }
     }
   return ID.replace("0,","");
 }

function set(act)
 {
   var Ids=Get_CheckBox("CK");
   if(Ids=="0")
    {
      alert("请选择要操作的信息!");
      return;
    }

   if(act=="delete")
    {
      if(!confirm("确定删除吗?"))
       {
         return;
       }
    }

   if(act=="copy" || act=="transfer")
    {
      if(!confirm("是否确定?"))
       {
         return;
       }
      if(document.getElementById("tosortid").value=="0")
      {
        alert("请选择要操作的目标类别!");
        document.getElementById("tosortid").focus();
        return ;
      }
    }

  document.getElementById("act").value=act;
  document.getElementById("ids").value=Ids;
  document.forms[0].submit();
 }

function html()
 {
  var obj=document.getElementById("htmltype")
  if(obj.value=="0")
   {
     var Ids=Get_CheckBox("CK");
     if(Ids=="0")
     {
      alert("请选择要生成的记录!");
      return;
     }
     htm_panel(Table,name,Ids);
   }
  else
   {
     htm_panel(Table,name,"");
   }
 }

function htm_panel(Table,Name,Ids)
 {
  var PageSize=5;
  var Width=400;
  var Height=220;
  var Top=(window.screen.availHeight-30-Width)/2;
  var Left=(window.screen.availWidth-10-Height)/2
  var Val=window.open("static_panel.aspx?table="+Table+"&ids="+Ids+"&name="+escape(Name)+"&pagesize="+PageSize,"html_build","width="+Width+",height="+Height+",top="+Top+",left="+Left+",toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no");
 }

SetCookie("tab","0");
</script>
</body>
</html>  
