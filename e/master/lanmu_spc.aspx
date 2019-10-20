<% @ Page Language="C#"   Inherits="PageAdmin.lanmu_spc"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="lanmu_spc"/>
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload()" title="点击刷新"><b>局部内容设置</b></a></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top>
<iframe name="post_iframe" id="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form runat="server" target="post_iframe">
<div id="tabdiv">
<ul>
<li id="tab" name="tab" style="font-weight:bold" onclick="location.href='lanmu_spc.aspx'">自定义栏目</li>
<li id="tab" name="tab" onclick="location.href='lanmu_spc.aspx?thetype=member'">会员中心</li>
<li id="tab" name="tab" onclick="location.href='lanmu_spc.aspx?thetype=search'">搜索页面</li>
</ul>
</div>

<table border=0 cellpadding=5 cellspacing=0  width=100% align=center  class=table_style2>
<tr>
  <td valign=top  align="left">
<div name="tabcontent" id="tabcontent">
<table border=0 cellpadding=2 cellspacing=0 width=100% align=center>
     <tr>
          <td height=40 width="100px">是否开启</td>
          <td><asp:CheckBox id="Spe_lanmu_open"  Runat="server" />开启自定义栏目(通过此功能，用户可制作个性化的栏目菜单)</td>
      </tr> 
      <tr>
          <td>
         栏目内容
         <br><a href="javascript:Open_Editor('pa_webset','zdy_lanmu','<%=FieldId%>','Content','栏目内容编辑')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a>
        </td>
          <td>
             <asp:TextBox id="Content" TextMode="MultiLine"  runat="server" columns="80" rows="15"/>
          </td>
      </tr> 
      
    </table>
<br>
<div align="left">说明：开启自定义栏目后，系统默认栏目将不显示，所以自定义栏目中的链接务必和默认栏目链接保持一致。</div>

</div>

<div name="tabcontent" id="tabcontent" style="display:none">
<table border=0 cellpadding=5 cellspacing=0 width=95% align=center>
<tr>
  <td style="width:100px">自定义样式路径<br></td>
  <td><asp:textBox TextMode="singleLine" id="tb_csspath" runat="server" maxlength="150" style="width:300px" /> 如：/e/template/01/diy.css，留空则继承网站参数设置的样式
  </td>
</tr>
<tr>
  <td>Seo标题</td>
  <td align="left"><asp:textBox TextMode="singleLine" id="tb_title" runat="server" maxlength="150" style="width:600px"/>
</td>
 </tr>

<tr>
  <td>Seo关键字</td>
 <td align="left" title="关键字之间用半角逗号分开"><asp:textBox TextMode="singleLine" id="tb_keywords" runat="server" maxlength="150" style="width:600px" />
</td>
 </tr>

<tr>
  <td>Seo描述</td>
 <td align="left" title="控制在250字以内"><asp:TextBox TextMode="multiLine" id="tb_description" runat="server" onkeyup="if(this.value.length>250)this.value=this.value.substring(0,250)" style="width:600px;height:100px"/>
</td>
 </tr>

<tr>
  <td>头信息自定义<br></td>
  <td><asp:TextBox  id="Headzdy" TextMode="MultiLine" runat="server" style="width:600px;height:100px" />
  </td>
</tr>
<tr>
 <td colspan=2 height="20">注:&lt;head&gt;&lt;/head&gt;之间的内容。</td>
</tr>
<tr>
  <td>顶部信息自定义<br><a href="javascript:Open_Editor('pa_partparameter','zdy_wztop','<%=FieldId%>','Wztopzdy','顶部信息自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td><asp:TextBox  id="Wztopzdy"  TextMode="MultiLine"  runat="server" style="width:600px;height:100px" />
  </td>
 </tr>
<tr>
<tr>
 <td colspan=2 height="20">注:自动替换网站顶部信息，留空则显示默认。</td>
</tr>

<tr>
  <td>栏目自定义<br><a href="javascript:Open_Editor('pa_partparameter','zdy_lanmu','<%=FieldId%>','Lanmuzdy','栏目自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td><asp:TextBox id="Lanmuzdy" TextMode="MultiLine"  runat="server" style="width:600px;height:100px"/>
  </td>
 </tr>
<tr>
 <td colspan=2 height="20">注:自动替换网站默认栏目条，留空则显示默认。</td>
</tr>

<tr>
  <td width=100px>横幅自定义<br><a href="javascript:Open_Editor('pa_partparameter','zdy_banner','<%=FieldId%>','Banner','banner横幅自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td><asp:TextBox  id="Banner"  TextMode="MultiLine"  runat="server" style="width:600px;height:100px" />
  </td>
 </tr>
<tr>
 <td colspan=2 height="20">注:留空则默认通栏Banner，不显示默认banner可以输入&lt;p/&gt;等HTML空白标签</td>
</tr>

<tr>
  <td>底部信息自定义<br><a href="javascript:Open_Editor('pa_partparameter','zdy_bottom','<%=FieldId%>','Wzbottomzdy','底部信息自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td><asp:TextBox  id="Wzbottomzdy"  TextMode="MultiLine"  runat="server" style="width:600px;height:100px" />
  </td>
 </tr>
<tr>
<tr>
 <td colspan=2 height="20">注:留空则显示默认底部内，开头加&lt;!--prepend--&gt;或&lt;!--append--&gt;可在默认内容前或后实现插入自定义内容。</td>
</tr>
</table>
</div>

<br>
<div align="center">
<span id="post_area"><asp:Button Text=" 提 交 " runat="server" cssclass="button"  onclick="Data_Update" Id="Bt_Submit"/></span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span> 
</div>
 </td>
 <tr>
</table>
</form>
</td>
</tr>
</table>
<br>
</center>
</body>
<script language="javascript">
var tab=document.getElementsByName("tab");
var type="<%=Request.QueryString["thetype"]%>";
if(type=="search")
 {
  showtab(1);
  tab[1].style.fontWeight="normal";
  tab[2].style.fontWeight="bold";
 }
else if(type=="member")
 {
  showtab(1);
 }
document.getElementById("Bt_Submit").onclick=startpost;
</script>
</html>