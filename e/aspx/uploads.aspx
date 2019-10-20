<% @ Page language="c#" Inherits="PageAdmin.uploads"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Upload</title>
</head>
<body>
<script type="text/javascript">
var Result="<%=Server.HtmlEncode(Request.QueryString["result"])%>";
var CS="<%=Server.HtmlEncode(Request.QueryString["cs"])%>";
var Tpic="<%=Server.HtmlEncode(Request.QueryString["tpic"])%>";
var P_State=parent.document.getElementById("UploadState");
var P_Postarea=parent.document.getElementById("postarea");
var P_postbt=parent.document.getElementById("postbt");
var p_Ulr=parent.document.getElementById("url");
var p_Size=parent.document.getElementById("filesize");
var p_View=parent.document.getElementById("view");
var P_file=parent.document.getElementById("file");


<%if(Request.QueryString["result"]!=null)
 {
%>

switch(Result)
 {
  case "emptyfile":

   P_State.style.display="none";
   <%if(IsMaster==1){%>
   P_Postarea.style.display="";
   <%}%>
   P_postbt.disabled=false;
   alert("未选择上传文件!");
  break;

  case "invalidusername":
   P_State.style.display="none";
   <%if(IsMaster==1){%>
   P_Postarea.style.display="";
   <%}%>
   P_postbt.disabled=false;
   alert("无效的用户名!");
  break;

  case "nopermission":
   P_State.style.display="none";
   <%if(IsMaster==1){%>
   P_Postarea.style.display="";
   <%}%>
   P_postbt.disabled=false;
   alert("无上传权限!");
  break;

  case "invalidimage":
   P_State.style.display="none";
   <%if(IsMaster==1){%>
   P_Postarea.style.display="";
   <%}%>
   P_postbt.disabled=false;
   alert("无效的图片文件!");
  break;


  case "invalid_submit":
   P_State.style.display="none";
   <%if(IsMaster==1){%>
   P_Postarea.style.display="";
   <%}%>
   P_postbt.disabled=false;
   alert("非法提交!");
  break;

  case "toolarge":
   P_State.style.display="none";
   <%if(IsMaster==1){%>
   P_Postarea.style.display="";
   <%}%>
   P_postbt.disabled=false;
   alert("文件太大了,请控制在"+CS+"kb以内!");
  break;

  case "noext":
   P_State.style.display="none";
   <%if(IsMaster==1){%>
   P_Postarea.style.display="";
   <%}%>
   P_postbt.disabled=false;
   alert("禁止发布"+CS+"格式的文件!");
  break;

  case "dangerousext":
   P_State.style.display="none";
   <%if(IsMaster==1){%>
   P_Postarea.style.display="";
   <%}%>
   P_postbt.disabled=false;
   alert("警告：禁止发布"+CS+"这类不安全文件!");
  break;

  case "cs_error":
   P_State.style.display="none";
   <%if(IsMaster==1){%>
   P_Postarea.style.display="";
   <%}%>
   P_postbt.disabled=false;
   alert("参数错误!");
  break;

  case "invalidimage":
   P_State.style.display="none";
   <%if(IsMaster==1){%>
   P_Postarea.style.display="";
   <%}%>
   P_postbt.disabled=false;
   alert("无效的图片文件!");
  break;

  case "nojilu":
   P_State.style.display="none";
   <%if(IsMaster==1){%>
   P_Postarea.style.display="";
   <%}%>
   P_postbt.disabled=false;
   alert("不存在上传点!");
  break;

  case "noset_ext":
   P_State.style.display="none";
   <%if(IsMaster==1){%>
   P_Postarea.style.display="";
   <%}%>
   P_postbt.disabled=false;
   alert("允许上传的扩展名未设置!");
  break;

  case "noset_maxlength":
   P_State.style.display="none";
   <%if(IsMaster==1){%>
   P_Postarea.style.display="";
   <%}%>
   P_postbt.disabled=false;
   alert("未设置上传单个文件的最大限制!");
  break;

  case "more_nums":
   P_State.style.display="none";
   <%if(IsMaster==1){%>
   P_Postarea.style.display="";
   <%}%>
   P_postbt.disabled=false;
   parent.ReFresh_Parent(Tpic);
  break;

  case "success":
   P_State.style.display="none";
   <%if(IsMaster==1){%>
   P_Postarea.style.display="";
   <%}%>
   P_postbt.disabled=false;
   if(CS=="add")
    {
     alert("增加成功!");
    }
   else
    {
     alert("更新成功!");
    }
   parent.ReFresh_Parent(Tpic);
  break;

 }

<%}%>

</script>
</body>
</html>