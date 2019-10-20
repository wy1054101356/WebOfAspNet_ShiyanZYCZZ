<% @ Page language="c#"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="C#" Runat="server">
  string HtmlList,D,RootPath,TheFileSize,UserName;
  protected void Page_Load(Object sender,EventArgs e)
   {
        Master_Valicate YZ=new Master_Valicate();
        YZ.Master_Check();//管理员验证
        UserName=YZ._UserName;
        if(!IsNum(Request.QueryString["sid"]) || Request.QueryString["sid"]=="0")
         {
           Response.Write("<"+"script type='text/javascript'>alert('无效的sid!')</"+"script>");
           Response.End();
         }
        if(!IsStr(Request.QueryString["table"]))
         {
           Response.Write("<"+"script type='text/javascript'>alert('无效的table!')</"+"script>");
           Response.End();
         }
        RootPath="/e/upload/s"+Request.QueryString["sid"]+"/"+Request.QueryString["table"]+"/";
        if(!Directory.Exists(Server.MapPath(RootPath)))
         {
           Directory.CreateDirectory(Server.MapPath(RootPath));
         }
        string zdydir=RootPath+"zdy";
        if(!Directory.Exists(Server.MapPath(zdydir)))
         {
           Directory.CreateDirectory(Server.MapPath(zdydir));
         }

        D=RootPath+Request.QueryString["filepath"].Replace("//","/").Replace(".","");
        DirectoryInfo dir=new DirectoryInfo(Server.MapPath(D));
        if(!Directory.Exists(Server.MapPath(D)))
          {
            Response.Write("<s"+"cript type='text/javascript'>location.href=\"?sid="+Request.QueryString["sid"]+"&filepath=/&type="+Request.QueryString["type"]+"&table="+Request.QueryString["table"]+"&field="+Request.QueryString["field"]+"&objid="+Request.QueryString["objid"]+"\"</"+"script>");
            Response.End();
          }

           if(Request.QueryString["act"]=="deldir" && UserName=="admin")
           {
            string DDir=Server.MapPath((D+"/"+Request.QueryString["d"]).Replace("//","/").Replace(".",""));
            if(Directory.Exists(DDir))
            {
             try
              {
               Directory.Delete(DDir,false);
              }
             catch
              {
                Response.Write("<s"+"cript type='text/javascript'>alert('此目录下包含子目录或文件,不能直接删除!');location.href=\"?sid="+Request.QueryString["sid"]+"&filepath="+Request.QueryString["filepath"]+"&type="+Request.QueryString["type"]+"&table="+Request.QueryString["table"]+"&field="+Request.QueryString["field"]+"&objid="+Request.QueryString["objid"]+"\"</"+"script>");
                Response.End();
              }
            }
          }

        if(Request.QueryString["act"]=="delfile" && UserName=="admin")
         {
           string DFile=Server.MapPath((D+"/"+Request.QueryString["d"]).Replace("//","/").Replace("./",""));
           if(File.Exists(DFile))
            {
                File.Delete(DFile);
            }
          }

        foreach(DirectoryInfo dChild in dir.GetDirectories())
        { 
          HtmlList+="<tr><td><img src='/e/images/icon/folder.gif' hspace=5 align=absmiddle><a href=\"javascript:AddFloder('"+dChild.Name+"')\">"+dChild.Name+"</a></td><td>&nbsp;</td><td align=center>"+dChild.CreationTime.ToString("yyyy-MM-dd")+"</td><td align=center><input type='button' value='删除' style='height:20px' onclick=\"return DelFolder('"+dChild.Name+"')\"></td></tr>";
        }
        foreach(FileInfo fChild in dir.GetFiles())
        { 
          TheFileSize=(fChild.Length/(float)1024).ToString("F2");
          if((".gif,.jpg,jpeg,.png,.bmp").IndexOf(fChild.Extension)>=0)
           {
            HtmlList+="<tr><td><a href=\"javascript:OpenFile('"+fChild.Name+"','"+TheFileSize+"')\"><img src='"+D+"/"+fChild.Name+"' border=0 height=50px width=80px><br>"+fChild.Name+"</a></td><td>"+TheFileSize+"kb</td><td align=center>"+fChild.CreationTime.ToString("yyyy-MM-dd")+"</td><td align=center><input type='button' value='删除' style='height:20px' onclick=\"return DelFile('"+fChild.Name+"')\"></td></tr>";
           }
          else
           {
            HtmlList+="<tr><td><img src='/e/images/icon/file.gif' hspace=5 align=absmiddle><a href=\"javascript:OpenFile('"+fChild.Name+"','"+TheFileSize+"')\">"+fChild.Name+"</a></td><td>"+TheFileSize+"kb</td><td align=center>"+fChild.CreationTime.ToString("yyyy-MM-dd")+"</td><td align=center><input type='button' value='删除' style='height:20px' onclick=\"return DelFile('"+fChild.Name+"')\"></td></tr>";
           }
        }
   }
private bool IsStr(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  string str1="abcdefghijklmnopqrstuvwxyz0123456789_";
  string str2=str.ToLower();;
  for(int i=0;i<str2.Length;i++)
   {
    if(str1.IndexOf(str2[i])==-1)
     {
       return false;
     }
   }
  return true;
 }

private bool IsNum(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  int rv=0;
  if(Int32.TryParse(str,out rv))
   {
    return true;  
   }
  else
   {
    return false;
   }
 }
</script><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>服务器文件</title>
<style type="text/css">
body{word-wrap:break-word;margin:0px;padding:0px;font:12px/18px Tahoma,Verdana,Arial,\5b8b\4f53;background-color:menu}
button,input,select,textarea{font-size:13px}
fieldset{margin:0 0 0 0}
#list{border:0px solid menu;background-color:#cccccc}
#list td{background-color:menu;}
a:link{color:#333333;text-decoration:none}
a:visited{color:#333333;text-decoration:none}
a:hover{color:#333333;text-decoration:underline}
</style>
</head>
<body>
文件路径：<input type="textbox" id="url" name="url" size="30" ondblclick="ViewUrl()" title="双击可浏览文件"></td>
<input type="button" value=" 确定 " style="height:22px" onclick="GetUrl()">
<input type="hidden" name="filesize" id="filesize" value="0">

<table width=100% height=25px border=0 cellpadding=0 cellspacing=0><tr><td align=left><a href="javascript:TFloder('')">根目录(/e/upload/s<%=Request.QueryString["sid"]%>/<%=Request.QueryString["table"]%>)</a><%=Request.QueryString["filepath"]%></td>
<%
if(Request.QueryString["filepath"]!="" && Request.QueryString["filepath"]!="/")
 {
   string Dir="/";
   string[] Adir=Request.QueryString["filepath"].Split('/');
    for(int i=0;i<Adir.Length-1;i++)
    {
      if(Adir[i]!="")
       {
         Dir+="/"+Adir[i];
       }
    }
  Response.Write("<td align=right><a href=\"javascript:TFloder('"+Dir+"')\">→返回上级目录</a></div>");
 }
%>
</tr>
</table>
<fieldset style="overflow:hidden;">
<legend>服务器端文件</legend>
<div  style="height:450px;overflow:auto;valign=top">
<table cellspacing="1" cellpadding="5" width="100%" border="0"  id="list" align=center valign=top>
<tr>
<td width="50%" align=center>文件名</td>
<td width="17%" align=center>大小</td>
<td width="18%" align=center>创建时间</td>
<td width="15%" align=center>管理</td>
</tr>
<%=HtmlList%>
</table>
</div>
</fieldset>
注：请不要选择被其他信息或字段已经调用的文件，否则将导致文件被删除或冗余文件产生。<br>
通过ftp上传的文件务必放在/e/upload/s<%=Request.QueryString["sid"]%>/<%=Request.QueryString["table"]%>/zdy/目录中调用。

<script type="text/javascript">
 var username="<%=UserName%>";
 var opener_obj=opener.document.getElementById("<%=Request.QueryString["objid"]%>");
 var opener_filesize=opener.document.getElementById("filesize");
 var url_obj=document.getElementById("url");
 var Type="<%=Request.QueryString["type"]%>";
 var Table="<%=Request.QueryString["table"]%>";
 var Field="<%=Request.QueryString["field"]%>";
 var Now_Dir="<%=Request.QueryString["filepath"]%>";

function ViewUrl()
 {
   var url=document.getElementById("url").value;
   if(url!="" && url.indexOf(".")>0)
    {
      window.open(url,"view");
    }
 }

function GetUrl()
 {
   var url=url_obj.value;
   if(url!="" && url.indexOf(".")>0)
    {
      opener_obj.value=url;
      if(opener_filesize!=null)
       {
        opener_filesize.value=document.getElementById("filesize").value;
       }
    }
  window.close();
 }

function AddFloder(dir)
 {
  Now_Dir=ReplaceAll((Now_Dir+"/"+dir),"//","/");
  location.href="?sid=<%=Request.QueryString["sid"]%>&filepath="+Now_Dir+"&type="+Type+"&table="+Table+"&field="+Field+"&objid=<%=Request.QueryString["objid"]%>&from=<%=Request.QueryString["from"]%>";
 }

function TFloder(dir)
 {
  dir=ReplaceAll(dir,"//","/");
  location.href="?sid=<%=Request.QueryString["sid"]%>&filepath="+dir+"&type="+Type+"&table="+Table+"&field="+Field+"&objid=<%=Request.QueryString["objid"]%>&from=<%=Request.QueryString["from"]%>";
 }

function OpenFile(FileName,FileSize)
 {
  FileName=ReplaceAll(("/e/upload/s<%=Request.QueryString["sid"]%>/<%=Request.QueryString["table"]%>"+Now_Dir+"/"+FileName),"//","/");
  document.getElementById("url").value=FileName;
  document.getElementById("filesize").value=FileSize;
  //window.open(FileName,"view");
 }

function DelFolder(dir)
 {
  if(username!="admin"){alert("仅admin管理员具备删除权限!");return;}
  if(confirm("确定删除吗!"))
   {
    location.href="?sid=<%=Request.QueryString["sid"]%>&filepath="+Now_Dir+"&type="+Type+"&table="+Table+"&field="+Field+"&objid=<%=Request.QueryString["objid"]%>&act=deldir&d="+dir+"&from=<%=Request.QueryString["from"]%>";
   }
 }

function DelFile(file)
 {
   if(username!="admin"){alert("仅admin管理员具备删除权限!");return;}
   if(confirm("确定删除吗!"))
   {
     location.href="?sid=<%=Request.QueryString["sid"]%>&filepath="+Now_Dir+"&type="+Type+"&table="+Table+"&field="+Field+"&objid=<%=Request.QueryString["objid"]%>&act=delfile&d="+file+"&from=<%=Request.QueryString["from"]%>";
   }
 }

function ReplaceAll(str,str1,str2)
 {
  while(str.indexOf(str1)>= 0)
  {
   str=str.replace(str1,str2);
  }
  return str;
}
</script>
</body>
</html>




