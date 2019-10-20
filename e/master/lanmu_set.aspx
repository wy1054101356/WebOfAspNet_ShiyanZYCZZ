<% @ Page Language="C#" Inherits="PageAdmin.lanmu_set"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="lanmu_set"/>
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload()" title="点击刷新"><b><%=IsZt=="1"?"专题设置":"栏目设置"%></b></a></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<iframe name="post_iframe" id="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form runat="server" target="post_iframe">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
<table border=0 cellpadding=5 cellspacing=0 width=95% align=center>
<tr>
  <td  height=25 align="left"><b><%=IsZt=="1"?"当前专题":"当前栏目"%></b>：<%=Request.QueryString["lanmu"]%></td>
 </tr>
</table>
<table border=0 cellpadding=5 cellspacing=0 width=95% align=center>
<tr style="width:100px">
    <td>显示属性</td>
    <td><input type="radio"  name="lanmu_show" value="1" checked>显示
        <input type="radio" name="lanmu_show" value="0" <%=Lanmu_Show=="0"?"checked":""%>>隐藏
  </td>
 </tr>

<tr style="display:<%=Is_Static=="0"?"none":""%>">
  <td>封面页静态<br></td>
  <td>
    <asp:DropDownList id="D_Html" runat="server">
    <asp:ListItem value="1">静态文件</asp:ListItem>
    <asp:ListItem value="0">动态文件</asp:ListItem>
    </asp:DropDownList>
  </td>
 </tr>

<tr style="display:<%=IsZt=="1"?"":"none"%>">
  <td>专题名称</td>
  <td><asp:textBox TextMode="singleLine" id="tb_name" runat="server" maxlength="50" style="width:400px" /> 
      <asp:Label id="lb_name" runat="server" visible="false"/>
  </td>
</tr>

<tr style="display:<%=IsZt=="1"?"none":""%>">
  <td>替换名称</td>
  <td><asp:textBox TextMode="singleLine" id="tb_showname" runat="server" maxlength="200" style="width:400px" /> 用于前台替换默认栏目名，支持html标签。
  </td>
</tr>

<tr style="display:<%=IsZt=="1"?"":"none"%>">
  <td>栏目路径</td>
  <td><%=Fdir%><asp:textBox TextMode="singleLine" id="tb_dir" runat="server" maxlength="50" style="width:200px" /> 注：路径只能数字、字母和下划线组成，多级目录请用/线隔开
      <asp:Label id="lb_dir" runat="server"/>
  </td>
</tr>


<tr>
  <td>自定义样式路径<br></td>
  <td><asp:textBox TextMode="singleLine" id="tb_csspath" runat="server" maxlength="150" style="width:400px" /> 如：/e/templates/01/diy.css，留空则继承网站参数设置的样式
  </td>
</tr>

<tr>
  <td>自定义链接</td>
  <td align="left"><asp:textBox TextMode="singleLine" id="tb_url" runat="server" maxlength="150" style="width:600px" />
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
 <td align="left" title="控制在250字以内"><asp:TextBox TextMode="multiLine" id="tb_description" runat="server" onkeyup="if(this.value.length>250)this.value=this.value.substring(0,250)" style="width:90%;height:80px"/>
</td>
 </tr>

<tr>
  <td>head区自定义<br></td>
  <td><asp:TextBox  id="Headzdy" TextMode="MultiLine" runat="server" style="width:90%;height:80px" />
  </td>
</tr>


<tr>
  <td>顶部信息自定义<br><a href="javascript:Open_Editor('pa_partparameter','zdy_wztop','<%=FieldId%>','Wztopzdy','顶部信息自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td><asp:TextBox  id="Wztopzdy"  TextMode="MultiLine"  runat="server" style="width:90%;height:80px" />
  </td>
 </tr>
<tr>
<tr>
 <td colspan=2 height="20">注:自动替换网站顶部信息，留空则显示默认。</td>
</tr>

<tr>
  <td>栏目自定义<br><a href="javascript:Open_Editor('pa_partparameter','zdy_lanmu','<%=FieldId%>','Lanmuzdy','栏目自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td><asp:TextBox id="Lanmuzdy" TextMode="MultiLine"  runat="server" style="width:90%;height:80px"/>
  </td>
 </tr>
<tr>
 <td colspan=2 height="20">注:自动替换网站默认栏目条，留空则显示默认。</td>
</tr>

<tr>
  <td>下拉菜单自定义</td>
  <td><asp:TextBox  id="Dropmenuzdy"  TextMode="MultiLine"  runat="server" style="width:90%;height:80px"/>
  </td>
 </tr>
<tr>
 <td colspan=2 height="20">注:支持三级下拉，格式为：&lt;ul&gt;&lt;li&gt;&lt;a href="链接"&gt;链接内容&lt;/a&gt;&lt;/li&gt;&lt;/ul&gt;,多条下拉可相应增加&lt;li&gt;&lt;/li&gt;记录</td>
</tr>


<tr>
  <td width=100px>横幅自定义<br><a href="javascript:Open_Editor('pa_partparameter','zdy_banner','<%=FieldId%>','Banner','banner横幅自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td><asp:TextBox  id="Banner"  TextMode="MultiLine"  runat="server" style="width:90%;height:80px" />
  </td>
 </tr>
<tr>
 <td colspan=2 height="20">注:留空则默认通栏Banner，不显示默认banner可以输入&lt;!--hide--&gt;等注释标签</td><!--hide-->
</tr>


<tr>
  <td>小幅banner自定义<br><a href="javascript:Open_Editor('pa_partparameter','zdy_smallbanner','<%=FieldId%>','SmallBanner','小幅banner自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td><asp:TextBox  id="SmallBanner"  TextMode="MultiLine"  runat="server" style="width:90%;height:80px" />
  </td>
 </tr>

<tr style="display:<%=LanmuType=="home"?"none":""%>">
    <td>当前位置自定义</td>
    <td>链接样式：<input type="radio" name="location_style" value="0" checked>显示栏目名称（首页 &gt; 栏目名 &gt; 子栏目名）
    <input type="radio"  name="location_style" value="1" <%=Location_Style=="1"?"checked":""%>>不显示栏目名称（首页 &gt; 子栏目名）<br>
     <asp:TextBox  id="Tb_Zdy_Locaiton"  TextMode="MultiLine"  runat="server" style="width:90%;height:80px" />
  </td>
 </tr>
<tr>
 <td colspan=2 height="20">注:自动替换当前位置信息，留空则显示默认。</td>
</tr>

<tr>
  <td>底部信息自定义<br><a href="javascript:Open_Editor('pa_partparameter','zdy_bottom','<%=FieldId%>','Wzbottomzdy','底部信息自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td><asp:TextBox  id="Wzbottomzdy"  TextMode="MultiLine"  runat="server" style="width:90%;height:80px" />
  </td>
 </tr>
<tr>
<tr>
 <td colspan=2 height="20">注:留空则显示默认底部内，开头加&lt;!--prepend--&gt;或&lt;!--append--&gt;可在默认内容前或后实现插入自定义内容。</td>
</tr>
</table>

</td>
</tr>
</table>
<br>
<table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
<tr>
<td height=25 align=center >
<asp:Label    id="Lb_SiteDir"   runat="server" Visible="false" />
<asp:Label    id="Lb_OldFile"   runat="server" Visible="false" />
<span id="post_area">
<asp:Button Cssclass=button  text="提交" id="Bt_Submit" runat="server" onclick="Data_Update" />
<input type="button" class=button  value="关闭"  onclick="parent.CloseDialog()">
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>
</td>
 </tr>
</table>
<asp:Label id="LblErr" runat="server" />

</form>

</td>
</tr>
</table>

</center>
</body>
<script language="javascript">  
document.getElementById("Bt_Submit").onclick=startpost;
</script>
</html>  
