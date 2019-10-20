<% @ Page Language="C#" Inherits="PageAdmin.set"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server"  Type="basic_webset" />
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td align="left"  height=10></td></tr>
 <tr><td align="left" class=table_style1><b>网站参数设置</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top  align="left">
<iframe name="post_iframe" id="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form Enctype="multipart/form-data" runat="server" target="post_iframe">
<div id="tabdiv">
<ul>
<li id="tab" name="tab"  onclick="showtab(0)" style="font-weight:bold">基本属性设置</li>
<li id="tab" name="tab"  onclick="showtab(1)">图片上传设置</li>
<li id="tab" name="tab"  onclick="showtab(2)">邮件发送设置</li>
<li id="tab" name="tab"  onclick="showtab(3)">手机短信设置</li>
<li id="tab" name="tab"  onclick="showtab(4)">其他参数设置</li>
</ul>
</div>
<table border=0 cellpadding=10 cellspacing=0 width=100% >
 <tr>
<td align="left"  valign=top class=table_style2>
<div name="tabcontent" id="tabcontent">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center>
<tr>
  <td align="left"  style="width:100px">选择风格<a href="template_edit.aspx?template=<%=Css_path%>"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="编辑模板"></a></td>
 <td align="left">
 <asp:DropDownList id="D_Template" runat="server">
  <asp:ListItem value="0">请选择一个风格</asp:ListItem>
 </asp:DropDownList>
 <asp:RequiredFieldValidator  ControlToValidate="D_Template" display="Static" type="integer"  runat="server">
请选择一个风格</asp:RequiredFieldValidator>
</td>
</tr>

<tr>
  <td align="left"  width=100px>流量统计</td>
 <td align="left" >
<asp:DropDownList id="IpTongji" runat="server">
<asp:ListItem value="0">关闭</asp:ListItem>
<asp:ListItem value="1">启用</asp:ListItem>
</asp:DropDownList>
</td>
</tr>

 <tr>
  <td align="left"  width=100px>网站名称</td>
  <td align="left"><asp:textBox TextMode="singleLine" id="wz_name" runat="server"  size=80 maxlength="150" /></td>
 </tr>
 <tr>
  <td align="left"  width=100px>网站标题</td>
  <td align="left"><asp:textBox TextMode="singleLine"  id="wz_title" runat="server" size=80 maxlength="150"  />
</td>
 </tr>

<tr>
  <td align="left">网站关键字</td>
 <td align="left"><asp:textBox TextMode="multiLine" Columns="75" rows="3" id="wz_keyword" runat="server" onkeyup="if(this.value.length>240)this.value=this.value.substring(0,240)"/>
</td>
 </tr>

<tr>
  <td align="left" >网站描述</td>
 <td align="left" ><asp:TextBox TextMode="multiLine" Columns="75" rows="4" id="wz_description" runat="server" onkeyup="if(this.value.length>240)this.value=this.value.substring(0,240)"/>
</td>
 </tr>

<tr>
  <td colspan="2" height="10px"></td>
 </tr>

<tr>
  <td align="left">Head区自定义</td>
 <td align="left"><asp:TextBox TextMode="multiLine" Columns="75" rows="6"  id="wz_head"  runat="server"/>
 <br>注：页面<head></head>之间内容，可加入自定义的css文件或js文件等。
</td>
 </tr>
<tr>
  <td colspan="2" height="5px"></td>
 </tr>
 <tr>
  <td align="left" width=100px>Logo图片</td>
  <td align="left"><input type="radio" name="radio_logo" checked onclick="c_logo(1)" id="radio_logo_1">路径<input type="radio" name="radio_logo" onclick="c_logo(2)">上传
<span id="logo_1"><asp:textBox TextMode="singleLine"  id="wz_logo" runat="server" size=50 maxlength="100"/></span>
<span id="logo_2" style="display:none"><input type="file" size=30  name="uploadlogo" id="uploadlogo">&nbsp;</span>相对栏目位置：<asp:RadioButton id="wz_logo_site1" GroupName="wz_logo_site" runat="server" />顶部
<asp:RadioButton id="wz_logo_site2" GroupName="wz_logo_site" runat="server" />左侧
</td>
 </tr>
<tr>
  <td colspan="2" height="10px"></td>
 </tr>
<tr>
  <td align="left">网站顶部内容</td>
 <td align="left" >
<asp:TextBox id="wz_top" TextMode="multiLine" runat="server" style="width:100%;height:250px;"/>
<script charset="utf-8" src="/e/incs/kindeditor/kindeditor.js"></script>
<script>
        KindEditor.ready(function(K) {
                editor = K.create('#wz_top',
                    {
                      uploadJson :kindeditor_uploadJson,
                      fileManagerJson :kindeditor_fileManagerJson,
                      allowFileManager :true,
                      items :kindeditor_SimpleItems,
                      newlineTag:"br",
                      filterMode :false,
                      extraFileUploadParams:{siteid:'<%=Request.Cookies["SiteId"].Value%>'}
                    }
                );
        });
</script>

</td>
 </tr>

<tr><td colspan="2" height="10px"></td></tr>

<tr>
  <td align="left">网站Banner内容</td>
 <td align="left" >
<asp:TextBox id="wz_banner" TextMode="multiLine"  runat="server" style="width:100%;height:250px;"/>
<script>
        KindEditor.ready(function(K) {
                editor = K.create('#wz_banner',
                    {
                      uploadJson :kindeditor_uploadJson,
                      fileManagerJson :kindeditor_fileManagerJson,
                      allowFileManager :true,
                      items :kindeditor_SimpleItems,
                      newlineTag:"br",
                      filterMode :false,
                      extraFileUploadParams:{siteid:'<%=Request.Cookies["SiteId"].Value%>'}
                    }
                );
        });
</script>
</td>
</tr>

<tr><td colspan="2" height="10px"></td></tr>

<tr>
  <td align="left">网站底部内容</td>
 <td align="left" >
<asp:TextBox id="wz_bottom" TextMode="multiLine"  runat="server" style="width:100%;height:250px;"/>
<script>
        KindEditor.ready(function(K) {
                editor = K.create('#wz_bottom',
                    {
                      uploadJson :kindeditor_uploadJson,
                      fileManagerJson :kindeditor_fileManagerJson,
                      allowFileManager :true,
                      items :kindeditor_SimpleItems,
                      newlineTag:"br",
                      filterMode :false,
                      extraFileUploadParams:{siteid:'<%=Request.Cookies["SiteId"].Value%>'}
                    }
                );
        });
</script>
</td>
 </tr>
</table>
</div>

<div name="tabcontent" id="tabcontent" style="display:none">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center>
<tr>
  <td align="left" width="150px">缩略图质量</td>
  <td align="left">
  <select name="Thumbnail_Quality" id="Thumbnail_Quality">
	<option value="10">1</option>
	<option value="20">2</option>
	<option value="30">3</option>
	<option value="40">4</option>
	<option value="50">5</option>
	<option value="60">6</option>
	<option value="70">7</option>
	<option value="80">8</option>
	<option value="90">9</option>
	<option value="100">10</option>
    </select>
</td>
</tr>

<tr>
  <td align="left">缩略图生成条件</td>
  <td align="left">
     图片宽大于<input type="textbox" name="Thumbnail_MinWidth"  size="4" maxlength=4 value="<%=Thumbnail_MinWidth%>" onkeyup="if(isNaN(value))execCommand('undo')">px
     图片高大于<input type="textbox" name="Thumbnail_MinHeight" size="4" maxlength=4 value="<%=Thumbnail_MinHeight%>" onkeyup="if(isNaN(value))execCommand('undo')">px
</td>
</tr>

<tr>
  <td align="left">水印功能</td>
  <td align="left">
<input type="radio" name="Watermark_open" id="Watermark_0" value=0 checked>关闭 <input type="radio" name="Watermark_open" id="Watermark_1" value=1 >开启(<input type="checkbox" name="Watermark_InEditor" id="Watermark_InEditor" value=1 <%=WaterMark_InEditor=="1"?"checked":""%>>编辑器上传图片加水印)
</td>
<td align="left" rowspan=8>
<table width="190" height="154" border="0" background="images/flower.gif" title="设置水印位置"><tr><td width="33%" align="center" style="vertical-align:middle;"><input type="radio" id="watermark_site" name="watermark_site" value="1" ><b>#1</b></td><td width="33%" align="center" style="vertical-align:middle;"><input type="radio" id="watermark_site" name="watermark_site" value="2" ><b>#2</b></td><td width="33%" align="center" style="vertical-align:middle;"><input type="radio" id="watermark_site" name="watermark_site" value="3" ><b>#3</b></td></tr><tr><td width="33%" align="center" style="vertical-align:middle;"><input type="radio" id="watermark_site" name="watermark_site" value="4" ><b>#4</b></td><td width="33%" align="center" style="vertical-align:middle;"><input type="radio" id="watermark_site" name="watermark_site" value="5" ><b>#5</b></td><td width="33%" align="center" style="vertical-align:middle;"><input type="radio" id="watermark_site" name="watermark_site" value="6" ><b>#6</b></td></tr><tr><td width="33%" align="center" style="vertical-align:middle;"><input type="radio" id="watermark_site" name="watermark_site" value="7" checked><b>#7</b></td><td width="33%" align="center" style="vertical-align:middle;"><input type="radio" id="watermark_site" name="watermark_site" value="8" ><b>#8</b></td><td width="33%" align="center" style="vertical-align:middle;"><input type="radio" id="watermark_site" name="watermark_site" value="9" ><b>#9</b></td></tr></table>
</td>
</tr>

<tr>
  <td align="left" width="150px">水印图质量</td>
  <td align="left">
  <select name="Watermark_Quality" id="Watermark_Quality">
	<option value="10">1</option>
	<option value="20">2</option>
	<option value="30">3</option>
	<option value="40">4</option>
	<option value="50">5</option>
	<option value="60">6</option>
	<option value="70">7</option>
	<option value="80">8</option>
	<option value="90">9</option>
	<option value="100">10</option>
    </select>
</td>
</tr>


<tr>
  <td align="left">水印图片路径</td>
  <td align="left"><input type="text" size="40" maxlength="50" name="Watermark_Pic" id="Watermark_Pic" value="<%=Watermark_Pic%>" /></td>
</tr>

<tr>
  <td align="left">水印文字</td>
  <td align="left"><input type="text" size="40" maxlength="50" name="Watermark_font" id="Watermark_font" value="<%=Font_Text%>" /> <span style="color:#666666">(注：水印图片不存在才显示水印文字)</span></td>
</tr>

<tr>
  <td align="left">水印透明度</td>
  <td align="left">
  <select name="Watermark_alpha" id="Watermark_alpha">
	<option value="1">1</option>
	<option value="2">2</option>
	<option value="3">3</option>
	<option value="4">4</option>
	<option value="5">5</option>
	<option value="6">6</option>
	<option value="7">7</option>
	<option value="8">8</option>
	<option value="9">9</option>
	<option value="10">10</option>
    </select>
    </td>
</tr>

<tr>
  <td align="left">水印字体颜色</td>
  <td align="left"><input type="text" size="7" maxlength="7" name="Watermark_font_color" id="Watermark_font_color"  value="<%=Font_Color%>" /><a href="javascript:foreColor('Watermark_font_color','')"><img src=images/color.gif border=0 height=21 align=absbottom></a></td>
</tr>
<tr>
  <td align="left">水印字体样式</td>
  <td align="left"><select name="Watermark_font_style" id="Watermark_font_style">
	<option value="1">普通字体</option>
	<option value="2">粗体</option>
	<option value="3">粗斜体</option>
    </select>
</tr>


<tr>
  <td align="left">水印字体大小</td>
  <td align="left"><input type="text" size="7" maxlength="2" name="Watermark_font_size" value="<%=Font_Size%>" onkeyup="if(isNaN(value))execCommand('undo')">px</td>
</tr>

</tr>
  <td align="left">水印字体类型</td>
   <td align="left">
      <select name="Watermark_font_type" id="Watermark_font_type" onChange="C_Font_Type(this.options[this.selectedIndex].value)">
	<option value="Arial">Arial</option>
	<option value="Arial Black">Arial Black</option>
	<option value="Batang">Batang</option>
	<option value="BatangChe">BatangChe</option>
	<option value="Comic Sans MS">Comic Sans MS</option>
	<option value="Courier New">Courier New</option>
	<option value="Dotum">Dotum</option>
	<option value="DotumChe">DotumChe</option>
	<option value="Estrangelo Edessa">Estrangelo Edessa</option>
	<option value="Franklin Gothic Medium">Franklin Gothic Medium</option>
	<option value="Gautami">Gautami</option>
	<option value="Georgia">Georgia</option>
	<option value="Gulim">Gulim</option>
	<option value="GulimChe">GulimChe</option>
	<option value="Gungsuh">Gungsuh</option>
	<option value="GungsuhChe">GungsuhChe</option>
	<option value="Impact">Impact</option>
	<option value="Latha">Latha</option>
	<option value="Lucida Console">Lucida Console</option>
	<option value="Lucida Sans Unicode">Lucida Sans Unicode</option>
	<option value="Mangal">Mangal</option>
	<option value="Marlett">Marlett</option>
	<option value="Microsoft Sans Serif">Microsoft Sans Serif</option>
	<option value="MingLiU">MingLiU</option>
	<option value="MS Gothic">MS Gothic</option>
	<option value="MS Mincho">MS Mincho</option>
	<option value="MS PGothic">MS PGothic</option>
	<option value="MS PMincho">MS PMincho</option>
	<option value="MS UI Gothic">MS UI Gothic</option>
	<option value="MV Boli">MV Boli</option>
	<option value="Palatino Linotype">Palatino Linotype</option>
	<option value="PMingLiU">PMingLiU</option>
	<option value="Raavi">Raavi</option>
	<option value="Shruti">Shruti</option>
	<option value="Sylfaen">Sylfaen</option>
	<option value="Symbol">Symbol</option>
	<option value="Tahoma">Tahoma</option>
	<option value="Times New Roman">Times New Roman</option>
	<option value="Trebuchet MS">Trebuchet MS</option>
	<option value="Tunga">Tunga</option>
	<option value="Verdana">Verdana</option>
	<option value="Webdings">Webdings</option>
	<option value="Wingdings">Wingdings</option>
	<option value="仿宋_GB2312">仿宋_GB2312</option>
	<option value="宋体">宋体</option>
	<option value="新宋体">新宋体</option>
	<option value="楷体_GB2312">楷体_GB2312</option>
	<option value="黑体">黑体</option>
</select>

        <span id="Watermark_font_style_view" style="font-family:Arial Black">Arial Black</span>
    </td>
 </tr>
<tr>
  <td align="left">增加水印条件</td>
  <td align="left">
     图片宽大于<input type="textbox" name="Watermark_MinWidth"  size="4" maxlength=4  value="<%=WaterMark_MinWidth%>" onkeyup="if(isNaN(value))execCommand('undo')">px
     图片高大于<input type="textbox" name="Watermark_MinHeight" size="4" maxlength=4 value="<%=WaterMark_MinHeight%>" onkeyup="if(isNaN(value))execCommand('undo')">px
</td>
</tr>
</table>
<script language=javascript>

function C_Font_Type(str)
 {
   document.getElementById("Watermark_font_style_view").innerText=document.getElementById("Watermark_font").value;
   document.getElementById("Watermark_font_style_view").style.fontFamily=str;
 }
var WaterMark_Open,Font_Site;
document.getElementById("Thumbnail_Quality").value="<%=Thumbnail_Quality%>";
document.getElementById("Watermark_Quality").value="<%=Watermark_Quality%>";
WaterMark_Open="<%=WaterMark_Open%>"
if(WaterMark_Open=="1")
 {
  document.getElementById("Watermark_1").checked=true;
 }
document.getElementById("Watermark_alpha").value="<%=Font_Alpha%>";
document.getElementById("Watermark_font_style").value="<%=Font_Style%>";
document.getElementById("Watermark_font_type").value="<%=Font_Type%>";
Font_Site=<%=Font_Site%>;
document.getElementsByName("watermark_site")[Font_Site-1].checked=true;
</script>
</div>

<div name="tabcontent" id="tabcontent" style="display:none">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center>
<tr>
  <td align="left" width="150px">系统发件邮箱</td>
 <td align="left" ><asp:textBox TextMode="singleLine" id="em_add" runat="server" size=30 maxlength=45 /> 如：pageadmin@sohu.com
</td>
 </tr>

<tr>
  <td align="left" >邮箱密码</td>
 <td align="left" ><asp:textBox TextMode="Password" id="em_pass"  runat="server" size=30 maxlength=45 /> 不修改密码则留空。 
</td>
 </tr>
<tr>
  <td align="left" >发件方名称</td>
 <td align="left" ><asp:textBox TextMode="singleLine" id="em_from" runat="server" size=30 maxlength=45 /> 如:PageAdmin
</td>
 </tr>
<tr>

 <tr>
  <td align="left"  width=100px>邮箱服务器</td>
  <td align="left"><asp:textBox TextMode="singleLine" id="em_server" runat="server" size=30 maxlength=45 /> 如：smtp.sohu.com
</td>
 </tr>

<tr>
  <td align="left">财务接收邮箱</td>
 <td align="left"><asp:textBox TextMode="singleLine" id="em_fnc" runat="server" size=30 maxlength=45 />
</td>
 </tr>

<tr>
  <td align="left">定单接收邮箱</td>
 <td align="left"><asp:textBox TextMode="singleLine" id="em_order" runat="server" size=30 maxlength=45 />
</td>
 </tr>

<tr>
  <td align="left">会员反馈接收邮箱</td>
 <td align="left"><asp:textBox TextMode="singleLine" id="em_feedback" runat="server" size=30 maxlength=45 />
</td>

 </tr>
<tr>
 <td align="left">邮件签名</td>
 <td align="left"><asp:textBox TextMode="multiLine" id="em_sign" runat="server" style="width:100%;height:150px;" />
<script>
        KindEditor.ready(function(K) {
                editor = K.create('#em_sign',
                    {
                      uploadJson :kindeditor_uploadJson,
                      fileManagerJson :kindeditor_fileManagerJson,
                      allowFileManager :true,
                      items :kindeditor_SimpleItems,
                      newlineTag:"br",
                      filterMode :true,
                      extraFileUploadParams:{siteid:'<%=Request.Cookies["SiteId"].Value%>'}
                    }
                );
        });
</script>
</td>
</tr>
<tr>
  <td align="left"></td>
 <td align="left"><input type="button" value="发送测试邮件" onclick="SendTest('email')" class="f_bt"></td>
</td>
</tr>
</table>
</div>

<div name="tabcontent" id="tabcontent" style="display:none">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center>
<tr>
  <td align="left" width="120px">短信发送账户</td>
 <td align="left"><asp:textBox TextMode="singleLine" id="sms_user" runat="server" size=30 maxlength=50 /> 账户和密码可联系PageAdmin客服人员获取。 
</td>
</tr>

<tr>
  <td align="left">短信发送密码</td>
 <td align="left"><asp:textBox TextMode="Password" id="sms_pass" runat="server" size=30 maxlength=50 /> 不修改密码则留空。
</td>
</tr>

<tr>
 <td align="left">短信签名</td>
 <td align="left"><asp:textBox TextMode="singleLine" id="sms_sign" runat="server" size=30 maxlength=50 />
</td>
 </tr>
<tr>
  <td align="left"></td>
 <td align="left"><input type="button" value="查看账户信息" onclick="SmsInfo()" class="f_bt"> &nbsp;  <input type="button" value="发送测试短信" onclick="SendTest('sms')" class="f_bt">
</td>
</tr>
</table>

</div>

<div name="tabcontent" id="tabcontent" style="display:none">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center>
<tr>
   <td align="left" style="width:150px">当前位置自定义</td>
   <td align="left"><asp:TextBox id="Tb_Location" TextMode="multiLine" runat="server" style="width:80%;height:80px"/><br><span style="color:#666666">如：当前位置：&lt;a href=/&gt;首页&lt;/a&gt;</span></td>
</tr>

<tr>
   <td align="left" style="width:150px">页码链接文本</td>
   <td align="left"><asp:TextBox id="Tb_Page_LinkText" runat="server" maxlength="100" size="40"/> &nbsp;<span style="color:#666666">格式：首页,上一页,下一页,尾页</span></td>
</tr>
<tr>
   <td align="left" style="width:150px">页码链接信息</td>
   <td align="left"><asp:TextBox id="Tb_Page_LinkInfo" runat="server" maxlength="100" size="40"/> &nbsp;<span style="color:#666666">格式：页次：{0}/{1} 共{2}条记录</span></td>
</tr>
<tr>
   <td align="left" style="width:150px">新增字段前缀</td>
   <td align="left"><asp:TextBox id="Tb_Field_Prefix" runat="server" maxlength="20" size="20"/></td>
</tr>

<tr>
   <td align="left">日志自动清理</td>
   <td align="left"><asp:TextBox id="Tb_log_expire" runat="server" maxlength="10" size="10"/>天前的日志  &nbsp;<span style="color:#666666">0为不清理</span></td>
</tr>

<tr>
   <td align="left">下载扣除积分</td>
   <td align="left"><asp:TextBox id="Tb_point_expire" runat="server" maxlength="10" size="10"/>天内不重复扣除  &nbsp;<span style="color:#666666">0为每次都扣除</span></td>
</tr>


<tr>
  <td align="left">屏蔽关键字<br><font color=#666666>多个关键字用|分开<br>前台提交后将被阻止</font></td>
  <td align="left"><textarea id="forbid_keyword" name="forbid_keyword" style="width:80%;height:50px"><%=forbid_keyword%></textarea></td>
</tr>

<tr>
  <td align="left">替换关键字<br><font color=#666666>多个关键字用|分开<br>前台提交后将被替换成***</font></td>
  <td align="left"><textarea id="replace_keyword" name="replace_keyword" style="width:80%;height:50px"><%=replace_keyword%></textarea></td>
</tr>

<tr>
  <td align="left">两次评论时间间隔<br><font color=#666666>0则不限制</font></td>
  <td align="left"><input type="text" size="8" maxlength="8" name="comment_timelimit" id="comment_timelimit" value="<%=comment_timelimit%>" onkeyup="if(isNaN(value))execCommand('undo')">秒</font></td>
</tr>

<tr>
  <td align="left" width="150px">评论内容最大字符<br><font color=#666666>0则不限制</font></td>
  <td align="left"><input type="text" size="8" maxlength="8" name="comment_maxlength" id="comment_maxlength" value="<%=comment_maxlength%>" onkeyup="if(isNaN(value))execCommand('undo')">字符</font></td>
</tr>
<tr>
  <td align="left">新注册用户投稿限制<br><font color=#666666>0则不限制</font></td>
  <td align="left">注册<input type="text" size="8" maxlength="8" name="newuser_tg_timelimit" id="newuser_tg_timelimit" value="<%=newuser_tg_timelimit%>" onkeyup="if(isNaN(value))execCommand('undo')">分钟后才能投稿</td>
</tr>

</table>
</div>

<table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
<tr>
<td align="center"  height=25 align=center >
<asp:Label  id="lbl"  runat="server" />
<span id="post_area">
<asp:Label id="lb_siteid" Text="0" runat="server" visible="false"/>
<asp:Button class=button text="提交" Id="Bt_Submit" Onclick="Data_update" OnClientClick="return c_post()"  runat="server" /></span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>
</td>
 </tr>
</table>
</td>
</tr>
</table><br>
</form>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
var logo_1=document.getElementById("logo_1");
var logo_2=document.getElementById("logo_2");
function c_post()
 {
  var uploadfile=document.getElementById("uploadlogo").value;
  if(uploadfile!="")
   {
    var Auploadfile=uploadfile.split(".");
    var ftype=Auploadfile[Auploadfile.length-1].toLowerCase();
    var AllowType="jpg,gif,png,bmp";
    if(AllowType.indexOf(ftype)<0)
     {
      alert("对不起，Logo图片只能上传图片格式文件!");
      return false;
     }
   }
  startpost();
 }

function c_logo(v)
 {
  if(v==1)
   {
    logo_1.style.display="";
    logo_2.style.display="none";
    document.getElementById("uploadlogo").value="";
    logo_2.innerHTML="<input type='file' size=30  name='uploadlogo' id='uploadlogo'>&nbsp;";
   }
  else
   {
    logo_1.style.display="none";
    logo_2.style.display="";
   }
 }

function get_logourl(url)
 {
  document.getElementById("radio_logo_1").click();
  if(url!="")
   {
   document.getElementById("wz_logo").value=url;
   }
 }

function SendTest(type)
 {
  var title;
  if(type=="email")
   { 
     title="邮件发送";
   }
  else
   {
     title="短信发送";
   }
  var kw="";
  var x=new PAAjax();
  x.setarg("post",false);
  x.send("/e/aspx/smskey.aspx","content="+encodeURI(document.getElementById("sms_sign").value),function(v){kw=v;});
  if(kw.length>0)
   {
     alert("对不起，短信签名中包含了非法关键词："+kw);
     return;
   }
  IDialog(title,"send_test.aspx?type="+type,560,160);
 }

function SmsInfo()
 {
  IDialog("账户信息","send_test.aspx?type=smsinfo",250,100);
 }

</script>
</body>
</html>  
