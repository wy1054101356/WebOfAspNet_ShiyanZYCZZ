<% @ Page Language="C#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" Runat="server">
 protected void Page_Load(Object src,EventArgs e)
  {
    Master_Valicate YZ=new Master_Valicate();
    YZ.Master_Check();
    Session["update"]="1";
  }
 </script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>升级界面</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Author" content="www.pageadmin.net" />
<script src="/e/js/function.js" type="text/javascript"></script>
<style type="text/css">
body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,p,blockquote,th,hr{margin:0px;padding:0px;}
button,input,select,textarea{font-size:13px;line-height:25px;vertical-align:middle;}
table{word-wrap:break-word;word-break:break-all}
p{padding:0 0 0 0;margin:0 0 0 0;}
td,div{font-size:9pt;color:#000000;text-align:left}
a{color:#000000;text-decoration:none;}
a:hover{color:#000000;text-decoration: none;}
body{word-wrap:break-word;margin:0px;padding:10px 0px 0px 0px;font:12px/18px 宋体,\5b8b\4f53,Tahoma,Verdana,Arial;}
.table_style2{
	border-width: 1px;
	border-left-style: solid;
	border-right-style: solid;
	border-bottom-style: solid;
	border-top-style: solid;
	border-color:#808080;
        background-color:#D1EAFE;
}
<script type="text/javascript">
function Request(paras,url) //获取url中参数
 { 
  if(url==null){url=location.href;}
  var paraString = url.substring(url.indexOf("?")+1,url.length).split("&"); 
  var paraObj={} 
  for (i=0;j=paraString[i]; i++)
   { 
    paraObj[j.substring(0,j.indexOf("=")).toLowerCase()] = j.substring(j.indexOf("=")+1,j.length); 
   } 
  var returnValue = paraObj[paras.toLowerCase()]; 
  if(typeof(returnValue)=="undefined")
  { 
   return ""; 
  }
 else
  { 
    return decodeURI(returnValue); 
  } 
} 
</script>
</style>
</head>
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table border=0 cellpadding=0 cellspacing=0 width=95% align=center  class=table_style2>
<tr>
  <td valign=top>
   <table border=0 cellpadding=0 cellspacing=5 width=100% align=center>
    <tr>
    <td height=20px>
     <div id="uploadlog"></div>

<input type="button" value="开始升级" onclick="down_upfile()" id="bt_1">
<input type="button" value="升级中..."  id="bt_2" style="display:none">
   </td>
   </tr>
   <tr id="tr_1" style="display:none">
    <td height=20px><b>步骤1：</b>下载升级文件<img src="loading.gif" style="width:16px;height:16px" align=absmiddle id="tr_1_img">
      <div id="tr_1_log"></div>
    </td>
   </tr>

   <tr id="tr_2" style="display:none">
    <td height=20px><b>步骤2：</b>升级文件解压</span><img src="loading.gif" style="width:16px;height:16px" align=absmiddle id="tr_2_img"> 
     <div id="tr_2_log"></div>
   </td>
   </tr>

   <tr id="tr_3" style="display:none">
    <td height=20px><b>步骤3：</b>复制升级文件</span><img src="loading.gif" style="width:16px;height:16px" align=absmiddle id="tr_3_img">
     <div id="tr_3_log"></div>
    </td>
   </tr>

   <tr id="tr_4" style="display:none">
    <td height=20px><b>步骤4：</b>更新网站</span><img src="loading.gif" style="width:16px;height:16px" align=absmiddle id="tr_4_img">
     <div id="tr_4_log"></div>
    </td>
   </tr>

  </table>
 </td>
  </tr>
</table>
<table border=0 cellpadding=0 cellspacing=5 width=95% align=center>
    <tr>
    <td height=20px>提示：升级前备份好网站文件和数据库，升级过程中请不要关闭或刷新窗口</td>
   </tr>
</table>
<div align="center"></div>
<script type="text/javascript">
var bt_1=document.getElementById("bt_1");
var bt_2=document.getElementById("bt_2");

var tr_1=document.getElementById("tr_1");
var tr_2=document.getElementById("tr_2");
var tr_3=document.getElementById("tr_3");
var tr_4=document.getElementById("tr_4");

var tr_1_img=document.getElementById("tr_1_img");
var tr_2_img=document.getElementById("tr_2_img");
var tr_3_img=document.getElementById("tr_3_img");
var tr_4_img=document.getElementById("tr_4_img");

var tr_1_log=document.getElementById("tr_1_log");
var tr_2_log=document.getElementById("tr_2_log");
var tr_3_log=document.getElementById("tr_3_log");
var tr_4_log=document.getElementById("tr_4_log");

var parentuploadlog=parent.document.getElementById("update_log");

var parentfilepath=parent.document.getElementById("update_path");
var parentupdateversion=parent.document.getElementById("update_version");

if(parentuploadlog!=null)
{
  document.getElementById("uploadlog").innerHTML=parentuploadlog.value;
}

var filepath=Request("filepath");
var version=Request("version");
var updateversion=Request("update_version");
if(filepath=="")
{
  bt_1.style.display="none";
  alert("无法获取升级文件!");
}
var ajx=new PAAjax();
function down_upfile() //下载更新文件
 {
   if(confirm("升级前建议先备份好网站文件和数据库文件，是否继续升级？"))
    {
        tr_1.style.display="";
        bt_1.style.display="none";
        bt_2.style.display="";
        tr_1_log.innerHTML+="开始下载....";
        ajx.setarg("get",true);
        ajx.send("down_file.aspx","filepath="+encodeURI(filepath),function(v){
        if(v=="success")
          {
           tr_1_log.innerHTML+="<br>下载完毕！"
           tr_1_img.style.display="none";
           extract_upfile();
          }
        else
         {
           tr_1_log.innerHTML+="<br><span style='color:#ff0000'>下载文件出错：</span>"+v;
          }
      });

    }
 }
function extract_upfile() //解压更新文件
 {
   tr_2.style.display="";
   tr_2_log.innerHTML+="开始解压...."
   ajx.setarg("get",true);
   ajx.send("extract_file.aspx","filepath="+encodeURI(filepath),function(v){
   if(v=="success")
     {
       tr_2_log.innerHTML+="<br>解压完毕！"
       tr_2_img.style.display="none";
       copy_file();
     }
    else
     {
      tr_2_log.innerHTML+="<br><span style='color:#ff0000'>解压文件出错：</span>"+v;
     }

   });
 }

function copy_file() //复制升级文件
 {
   tr_3.style.display="";
   tr_3_log.innerHTML+="开始复制升级文件....."
   ajx.setarg("get",true);
   ajx.send("copy_file.aspx","filepath="+encodeURI(filepath),function(v){
   if(v=="success")
     {
       tr_3_log.innerHTML+="<br>文件复制完毕！"
       tr_3_img.style.display="none";
       update_file();
     }
    else
     {
       tr_3_log.innerHTML+="<br><span style='color:#ff0000'>出错：</span>"+v;
     }
   });
 }

function update_file() //更新表单文件，模型文件
 {
   tr_4.style.display="";
   tr_4_log.innerHTML+="开始更新网站文件...."
   ajx.setarg("get",true);
   ajx.send("update_file.aspx","version="+encodeURI(version)+"&updateversion="+encodeURI(updateversion),function(v){
   if(v=="success")
     {
       tr_4_log.innerHTML+="<br>运行完毕，系统已经升级成功，</a>点击<input type='button' value='刷新页面' onclick='top.location.href=top.location.href'>按钮刷新一下页面或自行手动刷新。"
       bt_2.value="升级完毕";
       tr_4_img.style.display="none";
     }
    else
     {
       tr_4_log.innerHTML+="<br><span style='color:#ff0000'>出错：</span>"+v;
     }
   });
 }

</script>
</body>
</html>