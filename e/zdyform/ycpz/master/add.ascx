<% @ Control  Language="C#" Inherits="PageAdmin.paform"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%Start();%>
<tr id='tr_ycpz_title'><td class='tdhead'>标题<span style='color:#ff0000'>*</span></td><td><input type=text name='title' id='title' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("title"));}%>"  maxlength="200"><span id="title_tip"></span></td></tr>
<tr id='tr_ycpz_titlepic'><td class='tdhead'>标题图片<span style='color:#ff0000'>*</span></td><td><input ondblclick="if(this.value!='')window.open(this.value)" type=text name='titlepic' id='titlepic'  value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("titlepic"));}%>"  ><a href="javascript:delete_file('ycpz','titlepic',<%=InforId%>)" id="delete_titlepic" style="padding-left:2px;display:<%=r("titlepic")==""?"none":""%>" title='删除图片'><img src=/e/images/public/del.gif border=0></a><a id='upload_titlepic' href="javascript:open_upload('<%=SiteId%>','','image','ycpz','titlepic','titlepic')" style="display:<%=r("titlepic")==""?"":"none"%>"><img src='/e/images/public/attachimg.gif' border=0  hspace=2 alt='上传图片' align=absbottom></a><span id="titlepic_tip"></span></td></tr><tr id='tr_ycpz_content'><td class='tdhead'>详细内容<span style='color:#ff0000'>*</span></td><td><textarea name='content' id='content' style="width:100%;height:300px"   ><%if(post=="add"){Response.Write("");}else{Response.Write(r("content"));}%></textarea><script charset="utf-8" src="/e/incs/kindeditor/kindeditor.js" type="text/javascript"></script><script type="text/javascript">var KE_content;KindEditor.ready(function(K) {KE_content= K.create("#content",{uploadJson :kindeditor_uploadJson,fileManagerJson :kindeditor_fileManagerJson,allowFileManager :true,items :kindeditor_NormalItems,filterMode :false,extraFileUploadParams:{siteid:"<%=SiteId%>"}});});</script><span id="content_tip"></span><table width='100%' border='0' cellspacing='0' cellpadding='0'><tr><td><input name='saveimage' type='checkbox' value='1'/>保存远程图片(<input type='checkbox' name='addwatermark' value='1' checked/>加水印)&nbsp;<input name='autotitlepic' type='checkbox' value='1'/>提取第<input type='text' name='titlepic_num' value='1' size='2' onkeyup=if(isNaN(value))execCommand('undo') onblur=if(this.value=='')execCommand('undo')>张图为缩略图(缩略图宽<input type='text' name='thumbnail_width' id='thumbnail_width' value='400' size='2' onkeyup=if(isNaN(value))execCommand('undo') onblur=if(this.value=='')execCommand('undo')>px&nbsp;高<input type='text' name='thumbnail_height' id='thumbnail_height' value='400' size='2' onkeyup=if(isNaN(value))execCommand('undo') onblur=if(this.value=='')execCommand('undo')>px)</td></tr></table></td></tr>
<tr id='tr_ycpz_thedate'><td class='tdhead'>发布日期<span style='color:#ff0000'>*</span></td><td><input type=text name='thedate' id='thedate' value="<%if(post=="add"){Response.Write(""==""?DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"):"");}else{Response.Write(DateTime.Parse(r("thedate")).ToString("yyyy-MM-dd HH:mm:ss"));}%>"  maxlength="50"><a href="javascript:open_calendar('thedate',1)"><img src=/e/images/icon/date.gif border=0 height=20 hspace=2 align=absbottom></a><span id="thedate_tip"></span></td></tr>

<input type='hidden' name='mustname' value='标题,标题图片,详细内容,发布日期,'><input type='hidden' name='mustfield' value='title,titlepic,content,thedate,'><input type='hidden' name='musttype' value='text,image,editor,text,'>
<script  type='text/javascript'>
function ycpz_zdycheck(){
KE_content.sync();
return true;
}
</script>
<%End();%>






