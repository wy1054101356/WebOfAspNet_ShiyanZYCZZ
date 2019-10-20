<% @ Page Language="C#" Inherits="PageAdmin.msgsend"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="bs_msgsend"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>信息发送</b></td></tr>
 <tr><td height=10 ></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<form method="post" name="msg">
<table border=0 cellpadding=5px cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
<div name="tabcontent" id="tabcontent">
<table border=0 cellpadding=5 cellspacing=0 align=center width=98%>
 <tr>
   <td width=300px valign=top>
  <table border=0 cellpadding=5 cellspacing=0 align=center width=100%>
    <tr> 
      <td height=20 align=right width=100px>收件组：</td>
      <td><select id="receiver_groups" name="receiver_groups" multiple style='width:100%;height:120px' title="按住Ctrl键可实现多选或取消选择"><%=MTypeList%></select></td>
    </tr>
    <tr> 
      <td height=20 align=right width=100px>部门：</td>
      <td><select id="receiver_department" name="receiver_department" multiple style='width:100%;height:120px' title="按住Ctrl键可实现多选或取消选择"><%=DepartmentList%></select></td>
    </tr>
    <tr> 
      <td height=20 align=right width=100px>指定收件人：</td>
      <td>
      <select id="receiver_users" name="receiver_users" multiple style='width:100%;height:120px' ondblclick="clear_select()" title="双击可以删除选中用户"></select>
      <br><a href=# onclick="User_Select()">[指定收件人]</a>
   </td>
    </tr>
    <tr> 
      <td height=20 align=center colspan="2"><input type="button" value="导出接收用户" onclick="Load_Data()" id="bt_load" class="f_bt"></td>
    </tr>
   </table>

 </td><td valign=top align=left>
<table border=0 cellpadding=5 cellspacing=0 align=center width=100%>
  <tr> 
      <td height=20 align=right width=100px>发件方式：</td>
      <td><input type="radio" value="0"  name="sendmsg" id="sendmsg" checked onclick="change_type()">站内信息
      <input type="radio" value="1"  name="sendmsg" id="sendmsg" onclick="change_type()">发送邮件
      <input type="radio" value="2"  name="sendmsg" id="sendmsg" onclick="change_type()">手机短信
   </td>
  </tr>

  <tr>
      <td height=20 align=right width=100px><span id="txt_users">接收用户：</span></td>
      <td> 
          <span id="d_receiverfrom" style="display:block"><span id="txt_from">可从左边导出用户资料</span></span>
          <textarea name="receiver" id="receiver" style="width:80%;height:80px"></textarea>
      </td>
  </tr>



  <tr id="tr_title">
      <td height=20 align=right>标题：</td>
      <td><input type="text"  id="fb_title"  name="fb_title"  maxlength="100" style="width:80%"> <span style="color:#ff0000">*</span>
   </td>
  </tr>

   <tr id="tr_content">
          <td align=right>内容：</td>
          <td>
            <textarea name="Content" id="Content" style="width:100%;height:200px;"></textarea>
<script charset="utf-8" src="/e/incs/kindeditor/kindeditor.js"></script>
<script type="text/javascript">
        KindEditor.ready(function(K) {
                window.editor = K.create('#Content',
                    {
                      uploadJson :kindeditor_uploadJson,
                      fileManagerJson :kindeditor_fileManagerJson,
                      allowFileManager :false,
                      items :kindeditor_SimpleItems,
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
            <textarea name="SmsContent" id="SmsContent" style="width:80%;height:200px" onkeyup="fontnums()" onmousemove="fontnums()"></textarea>
            <br>一条短信最多70个字，超过按2条短信收费，您现在已经输入了<span id="fontnums" style="color:#ff0000">0</span>个字。
          </td>
     </tr> 

    <tr>
      <td height=30px align=center colspan=2>
      <input type="hidden"  value="<%=SendType%>"  name="post" id="Submit">&nbsp;
      <input type="button" id="bt_send" value="发 送"  class="button" onclick="return Check_Message()">
     </td>
    </tr>
   </table>
  </td>
  </tr>
 </table>

  </td>
  </tr>
 </table>
</form>
</td>
</tr>
</table><br>
</center>
<script>
 var thetype=document.forms["msg"].sendmsg;
 var receiver=document.getElementById("receiver");
 var fb_title=document.getElementById("fb_title");
 var SmsContent=document.getElementById("SmsContent");

 function change_type()
  {
    if(thetype[0].checked)
     {
       receiver.value="";
       document.getElementById("txt_users").innerHTML="接收用户：";
       document.getElementById("bt_load").value="导出接收用户";
       document.getElementById("tr_title").style.display="";
       document.getElementById("tr_content").style.display="";
       document.getElementById("tr_smscontent").style.display="none";
       document.getElementById("txt_from").innerHTML="可从左边导出用户资料";
     }
    else if(thetype[1].checked)
     {
       receiver.value="";
       document.getElementById("txt_users").innerHTML="接收邮箱：";
       document.getElementById("bt_load").value="导出邮箱地址";
       document.getElementById("tr_title").style.display="";
       document.getElementById("tr_content").style.display="";
       document.getElementById("tr_smscontent").style.display="none";
       document.getElementById("txt_from").innerHTML="可从左边导出用户邮箱资料，也可以直接输入邮箱地址(多个地址之间用半角逗号隔开)";
     }
    else
     {
       receiver.value="";
       document.getElementById("txt_users").innerHTML="接收手机：";
       document.getElementById("bt_load").value="导出手机号码";
       document.getElementById("tr_title").style.display="none";
       document.getElementById("tr_content").style.display="none";
       document.getElementById("tr_smscontent").style.display="";
       document.getElementById("txt_from").innerHTML="可从左边导出用户手机资料，也可以直接输入手机号码(多个号码之间用半角逗号隔开)";
     }
  }


function Check_Message()
  { 
    var fb_value;
      if(receiver.value=="")
       {
        alert("请输入接收资料!");
        receiver.focus();
        return false;
       }

    if(thetype[2].checked=="1")
     {
      fb_value=Trim(SmsContent.value);
      if(fb_value=="")
      {
       alert("请输入短信内容!");
       SmsContent.focus();
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
      fb_value=Trim(fb_title.value);
      if(fb_value=="")
      {
       alert("请输入信息标题!");
       fb_title.focus();
       return false;
      }
     var Length=editor.count("text"); 
     if(Length==0)
      {
       editor.focus();
       alert("请输入信息内容!");
       return false;
      }
    }
   if(confirm("是否确定发送?"))
    {
     editor.sync();
     document.forms["msg"].submit();
    }
  }

 function fontnums()
  {
    var SmsContent=document.getElementById("SmsContent");
    var FontNums=document.getElementById("fontnums");
    FontNums.innerHTML=SmsContent.value.length;
  }

function User_Select()
 {
  IDialog("选择接收用户","member_select.aspx?checked=checked",750,400);
 }

var url_sendmsg="<%=Request.QueryString["sendmsg"]%>";
if(url_sendmsg!="")
{
  thetype[url_sendmsg].checked=true;
  change_type();
}
else
{
  thetype[0].checked=true;
}

function Load_Data()
 {
   var bt_text=document.getElementById("bt_load").value;
   document.getElementById("bt_load").value="加载中,请稍等..."
   var mtypeids,departmentids,users,sendtype,vback;
   mtypeids=departmentids=users=vback="";
   var receiver_groups=document.getElementById("receiver_groups");
   var receiver_department=document.getElementById("receiver_department");
   var receiver_users=document.getElementById("receiver_users");
   for(var i=0;i<receiver_groups.options.length;i++)
   {
    if(receiver_groups.options[i].selected)
     {
      if(receiver_groups.options[i].value!="")
       
       if(mtypeids=="")
        {
           mtypeids+=receiver_groups.options[i].value;
        }
       else
        {
           mtypeids+=","+receiver_groups.options[i].value;
        }
     }
   }
   for(var i=0;i<receiver_department.options.length;i++)
   {
    if(receiver_department.options[i].selected)
     {
       if(departmentids=="")
        {
          departmentids+=receiver_department.options[i].value;
        }
       else
        {
          departmentids+=","+receiver_department.options[i].value;
        }
     }
   }

    if(thetype[2].checked)
     {
       sendtype="mobile"
     }
    else if(thetype[1].checked)
     {
       sendtype="email"
     }
    else
     {
       sendtype="username"
     }

   for(var i=0;i<receiver_users.options.length;i++)
   {
      if(users=="")
       {
         users+=receiver_users.options[i].value;
       }
      else
       {
         users+=","+receiver_users.options[i].value;
       }
   }
  var x=new PAAjax();
  x.setarg("post",false);
  x.send("msgsend_users.aspx","mtypeids="+mtypeids+"&departmentids="+departmentids+"&users="+users+"&type="+sendtype,function(v){vback=v;});
  if(sendtype=="username")
   {
     if(users!="")
      {
        vback+=","+users;
      }
   }
  var Avback=vback.split(",");   
  vback=",";  
  for(var i=0;i<Avback.length;i++)
    {  
      if(Avback[i]==""){continue;}  
      if(vback.indexOf(","+Avback[i]+",")<0)
       {
        vback+=Avback[i]+",";
       }
    }  
   if(vback.length>2)
    {
     vback=vback.substring(1,vback.length-1);
    }
   else
    {
     vback=vback.substring(1,vback.length);
    }
  document.getElementById("receiver").value=vback;
  document.getElementById("bt_load").value=bt_text;
 }

function AddUsers(txt,value)
 {
   var obj=document.getElementById("receiver_users");
   obj.options.add(new Option(txt,value));
 }

function clear_select()
 {
  var obj=document.getElementById("receiver_users");
  if(obj.options.length==0){return;}
  for(i=0;i<obj.options.length;i++)
   {
    if(obj.options[i].selected)
     {
       obj.remove(i);
     }
   }
 }
</script>
</body>
</html>