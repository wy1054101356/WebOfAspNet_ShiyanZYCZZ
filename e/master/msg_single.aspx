<% @ Page Language="C#" Inherits="PageAdmin.msgsend"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table border=0 cellpadding=10 cellspacing=0 width=98% >
 <tr>
<td valign=top align="left">
<form method="post" name="msg">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
<table border=0 cellpadding="2px" cellspacing=0  align=center width=99%>

  <tr> 
      <td height=25 align=right width=80px>发件方式：</td>
      <td>
      <input type="checkbox" value="1"  name="sendmsg" id="sendmsg">站内信息
      <input type="checkbox" value="1"  name="sendmail" id="sendmail">发送邮件
      <input type="checkbox" value="1"  name="sendsms" id="sendsms" onclick="smsclick()">手机短信
   </td>
  </tr>

  <tr id="tr_title">
      <td height=25 align=right>标题：</td>
      <td><input type="text"  id="fb_title" name="fb_title" maxlength="100" size="50" class="tb"> <span style="color:#ff0000">*</span>
   </td>
  </tr>

   <tr id="tr_content">
        <td align=right>内容：</td>
          <td>
<textarea name="Content" id="Content" style="width:100%;height:200px;"></textarea>
<script charset="utf-8" src="/e/incs/kindeditor/kindeditor.js"></script>
<script type="text/javascript">
        var editor;
        KindEditor.ready(function(K) {
                editor= K.create('#Content',
                    {
                      uploadJson :kindeditor_uploadJson,
                      fileManagerJson :kindeditor_fileManagerJson,
                      allowFileManager :false,
                      items :kindeditor_SmallItems,
                      newlineTag:"br",
                      filterMode :false
                    }
                );
        });
</script>
          </td>
      </tr> 

     <tr id="tr_smscontent" style="display:none">
        <td align=right>短信内容：</td>
          <td>
            <textarea name="SmsContent" id="SmsContent" style="width:90%;height:200px" onkeyup="fontnums()" onmousemove="fontnums()"></textarea>
            <br>一条短信最多70个字，超过按2条短信收费，您现在已经输入了<span id="fontnums" style="color:#ff0000">0</span>个字。
          </td>
     </tr> 

     <tr>
      <td height=20px align=center colspan=2>
      <input type="hidden" id="Receiver" name="Receiver" size="50" class="tb" value="<%=Receiver%>">
      <input type="hidden" name="post" value="<%=SendType%>">
      <input type="button" value="发送"  class="button" onclick="Check_Message()">
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
 <%if(Request.QueryString["send"]=="ok"){%>
   parent.ClosePop();
 <%}%>
 function Check_Message()
  { 
    var fb_value;
    fb_value=Trim(document.getElementById("Receiver").value);
    if(fb_value=="")
      {
       alert("收件人不能为空!");
       return false;
     }

   if(document.getElementById("sendmsg").checked==false && document.getElementById("sendmail").checked==false && document.getElementById("sendsms").checked==false)
    {
      alert("请至少选择一种发件方式!");
      return false;
    }

   if(document.getElementById("sendsms").checked)
    {
      fb_value=Trim(document.getElementById("SmsContent").value);
      if(fb_value=="")
       {
        alert("请填写短信内容!");
        return false;
       }
     var kw="";
     var x=new PAAjax();
     x.setarg("post",false);
     x.send("/e/aspx/smskey.aspx","content="+encodeURI(fb_value),function(v){kw=v;});
     if(kw.length>0)
      {
       alert("对不起，短信内容中包含了非法关键词："+kw);
       return;
      }
    }
    else
     {
       fb_value=Trim(document.getElementById("fb_title").value);
       if(fb_value=="")
       {
        alert("请输入信息标题!");
        document.getElementById("fb_title").focus();
        return false;
       }
     var Length=editor.count("text");
      if(Length==0)
      {
       alert("请输入信息内容!");
       editor.focus();
       return false;
      }
     }
   
   if(confirm("是否确定发送?"))
    {
     editor.sync();
     document.forms["msg"].submit();
    }
  }

 function smsclick()
  {
   var tr_title=document.getElementById("tr_title");
   var tr_content=document.getElementById("tr_content");
   var tr_smscontent=document.getElementById("tr_smscontent");
   if(document.getElementById("sendsms").checked)
    {
      tr_title.style.display="none";
      tr_content.style.display="none";
      tr_smscontent.style.display="";
     document.getElementById("sendmsg").checked=false;
     document.getElementById("sendmail").checked=false;
     document.getElementById("sendmsg").disabled=true;
     document.getElementById("sendmail").disabled=true;
    }
   else
    {
      tr_title.style.display="";
      tr_content.style.display="";
      tr_smscontent.style.display="none";
      document.getElementById("sendmsg").disabled=false;
      document.getElementById("sendmail").disabled=false;
    }
  }
 function fontnums()
  {
    var SmsContent=document.getElementById("SmsContent");
    var FontNums=document.getElementById("fontnums");
    FontNums.innerHTML=SmsContent.value.length;
  }
</script>
</body>
</html>  