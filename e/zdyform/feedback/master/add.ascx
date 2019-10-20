<% @ Control  Language="C#" Inherits="PageAdmin.paform"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%Start();%>
<tr id='tr_feedback_title'><td class='tdhead'>主题<span style='color:#ff0000'>*</span></td><td><input type=text name='title' id='title' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("title"));}%>" style='width:300px'   maxlength="200"><span id="title_tip"></span></td></tr>
<tr id='tr_feedback_pa_truename'><td class='tdhead'>联系人</td><td><input type=text name='pa_truename' id='pa_truename' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("pa_truename"));}%>" style='width:200px'   maxlength="200"><span id="pa_truename_tip"></span></td></tr>
<tr id='tr_feedback_pa_tel'><td class='tdhead'>联系电话</td><td><input type=text name='pa_tel' id='pa_tel' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("pa_tel"));}%>" style='width:200px'   maxlength="200"><span id="pa_tel_tip"></span></td></tr>
<tr id='tr_feedback_email'><td class='tdhead'>邮箱<span style='color:#ff0000'>*</span></td><td><input type=text name='email' id='email' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("email"));}%>" onblur="if(!IsEmail(this.value)){alert('无效的邮件格式');document.letter.fbk_email.value=''}" maxlength="200"><span id="email_tip"></span></td></tr>
<tr id='tr_feedback_content'><td class='tdhead'>内容<span style='color:#ff0000'>*</span></td><td><textarea name='content' id='content' style="width:100%;height:300px"   ><%if(post=="add"){Response.Write("");}else{Response.Write(r("content"));}%></textarea><script charset="utf-8" src="/e/incs/kindeditor/kindeditor.js" type="text/javascript"></script><script type="text/javascript">var KE_content;KindEditor.ready(function(K) {KE_content= K.create("#content",{uploadJson :kindeditor_uploadJson,fileManagerJson :kindeditor_fileManagerJson,allowFileManager :true,items :kindeditor_SmallItems,filterMode :false,extraFileUploadParams:{siteid:"<%=SiteId%>"}});});</script><span id="content_tip"></span><table width='100%' border='0' cellspacing='0' cellpadding='0'><tr><td><input name='saveimage' type='checkbox' value='1'/>保存远程图片(<input type='checkbox' name='addwatermark' value='1' checked/>加水印)&nbsp;<input name='autotitlepic' type='checkbox' value='1'/>提取第<input type='text' name='titlepic_num' value='1' size='2' onkeyup=if(isNaN(value))execCommand('undo') onblur=if(this.value=='')execCommand('undo')>张图为缩略图(缩略图宽<input type='text' name='thumbnail_width' id='thumbnail_width' value='400' size='2' onkeyup=if(isNaN(value))execCommand('undo') onblur=if(this.value=='')execCommand('undo')>px&nbsp;高<input type='text' name='thumbnail_height' id='thumbnail_height' value='400' size='2' onkeyup=if(isNaN(value))execCommand('undo') onblur=if(this.value=='')execCommand('undo')>px)</td></tr></table></td></tr>
<tr id='tr_feedback_thedate'><td class='tdhead'>发布日期<span style='color:#ff0000'>*</span></td><td><input type=text name='thedate' id='thedate' value="<%if(post=="add"){Response.Write(""==""?DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"):"");}else{Response.Write(DateTime.Parse(r("thedate")).ToString("yyyy-MM-dd HH:mm:ss"));}%>"  maxlength="200"><a href="javascript:open_calendar('thedate',1)"><img src=/e/images/icon/date.gif border=0 height=20 hspace=2 align=absbottom></a><span id="thedate_tip"></span></td></tr>

<input type='hidden' name='mustname' value='主题,邮箱,内容,发布日期,'><input type='hidden' name='mustfield' value='title,email,content,thedate,'><input type='hidden' name='musttype' value='text,text,editor,text,'>
<script  type='text/javascript'>
function feedback_zdycheck(){
KE_content.sync();
return true;
}
</script>
<%End();%>






