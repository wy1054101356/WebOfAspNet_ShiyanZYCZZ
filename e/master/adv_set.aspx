<% @ Page Language="C#" Inherits="PageAdmin.adv_set"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server"  Type="js_adv"/>
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1 align="left"><b>广告设置</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top  align="left">
<iframe name="post_iframe" id="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form runat="server" target="post_iframe">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top  align="left">
<table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
<tr>
  <td height=10></td>
 </tr>
</table>
<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
 <tr>
  <td height=25px  align="left" width="100px">窗口名称</td>
  <td height=25px  align="left"><asp:TextBox id="Adv_name" maxlength="50" size="30" runat="server" /></td>
 </tr>

  <tr>
   <td height=25 align="left">广告类型</td>
    <td height=25px  align="left">
    <asp:DropDownlist id="Adv_Type" Runat="server">
     <asp:ListItem value="1">弹出窗口广告</asp:ListItem>
     <asp:ListItem value="2">漂浮广告</asp:ListItem>
     <asp:ListItem value="3">对联广告</asp:ListItem>
     <asp:ListItem value="4">自定义js</asp:ListItem>
    </asp:DropDownlist>
    </td>
  </tr>
<tr>
  <td height=25px  align="left">结束日期</td>
  <td align="left"><asp:TextBox id="EndDate" maxlength=10 size=12 runat="server" /><a href="javascript:open_calendar('EndDate')"><img src=images/calendar_bnt.gif border=0 height=20 hspace=2 align=absbottom></a></td>
</tr>

<tr id="tr_item" name="tr_item">
  <td height=25px  align="left">应用范围</td>
  <td height=25px  align="left">
<asp:RadioButton id="Adv_Lanmu" GroupName="range" runat="server" />所有页面&nbsp;
<asp:RadioButton id="Adv_Home"  GroupName="range" runat="server" />仅首页&nbsp;
<asp:RadioButton id="Adv_Close" GroupName="range" runat="server" />关闭
</td>
</tr>

<tr id="tr_item" name="tr_item">
  <td height=25px  align="left" width="100px">窗口标题</td>
  <td height=25px  align="left"><asp:TextBox id="Adv_title" maxlength="80" size="60" runat="server" /></td>
</tr>

<tr id="tr_item" name="tr_item">
  <td height=25px  align="left" width="100px">窗口参数</td>
  <td height=25px  align="left" ><asp:TextBox id="Adv_canshu" maxlength="80" size="60" runat="server" /></td>
</tr>

<tr id="tr_item" name="tr_item">
  <td height=25px  align="left" width="100px">内容(ID:adv_<%=Request.QueryString["id"]%>)<br><a href="javascript:Open_Editor('pa_adv','content','<%=FieldId%>','Adv_content','广告内容编辑')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td height=25px  align="left" ><div id="show_var_href" style="display:none"><a href="javascript:show_var('js')">&gt;&gt;预设变量及方法</a></div><asp:TextBox id="Adv_content" TextMode="multiline" style="width:95%;height:300px" runat="server" /></td>
</tr>

<tr id="tr_item" name="tr_item">
 <td height=25px  align="left" width="100px">左侧内容<br>(ID:adv_<%=Request.QueryString["id"]%>_left)<br><a href="javascript:Open_Editor('pa_adv','left_content','<%=FieldId%>','Left_content','广告内容编辑')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td height=25px  align="left" ><asp:TextBox id="Left_content" TextMode="multiline" style="width:95%;height:100px" runat="server" /></td>
</tr>

<tr id="tr_item" name="tr_item">
  <td height=25px  align="left" width="100px">右侧内容<br>(ID:adv_<%=Request.QueryString["id"]%>_right)<br><a href="javascript:Open_Editor('pa_adv','right_content','<%=FieldId%>','Right_content','广告内容编辑')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td align="left"><asp:TextBox id="Right_content" TextMode="multiline" style="width:95%;height:100px" runat="server" /></td>
</tr>
</table>
</td>
</tr>
</table>
<br>注：内容id表示内容的父标签(div)的id，用户可以通过自定义javascript脚本来控制。
<div align=center>
<span id="post_area">
<asp:Button Text=" 提交 " Cssclass="button" runat="server" OnClick="Data_Update" id="Bt_Submit" />
<input type="button" class=button  value="关闭" onclick="parent.CloseDialog()">
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span> 
</div>
</form>
</td>
</tr>
</table>
</center><br>
<script type="text/javascript">
 function change_type()
  {
   var thetype=document.getElementById("Adv_Type").value;
   var Obj=document.getElementsByName("tr_item");
   var show_var_href=document.getElementById("show_var_href");
   hideall(Obj);
   switch(thetype)
    {
      case "1":
       Obj[0].style.display="";
       Obj[1].style.display="";
       Obj[2].style.display="";
       Obj[3].style.display="";
       show_var_href.style.display="none";
      break;
      case "2":
       Obj[0].style.display="";
       Obj[3].style.display="";
       show_var_href.style.display="none";
      break;
      case "3":
       Obj[0].style.display="";
       Obj[4].style.display="";
       Obj[5].style.display="";
       show_var_href.style.display="none";
      break;
      case "4":
       Obj[0].style.display="";
       Obj[3].style.display="";
       show_var_href.style.display="";
      break;
    }
  }
change_type();
document.getElementById("Bt_Submit").onclick=startpost;
function show_var(Type)
 {
   IDialog('预设变量及方法',"tag_var.aspx?type="+Type,800,400,false,"tagvar");
 }
</script>
</body>
</html>  



