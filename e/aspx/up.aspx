<% @ Page language="c#"%> 
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 string ObjId,SiteId,TheTable,TheMaster,PostFile,The_Ext,FileNum,The_Maxlength,ListShowType,Upload_Type,SwfWidth,SwfHeight,ReName;
 protected void Page_Load(Object src,EventArgs e)
  {
   if(Request.Form["post"]=="upload")
     {
      Master_Valicate YZ=new Master_Valicate();
      YZ.Master_Check();
      Upload_File();
     }
   else
     {
      TheTable=Request.QueryString["table"];
      SiteId=Request.QueryString["siteid"];
      if(!IsStr(TheTable))
       {
          Write_Result("无效的Table");
       } 
      if(!IsNum(SiteId))
       {
          Write_Result("无效的SiteId");
       } 

      ObjId=Request.QueryString["objid"];
      if(!IsStr(ObjId))
       {
          Write_Result("无效的objid");
       }

      PostFile=Request.QueryString["postfile"];

      The_Ext=Request.QueryString["fileext"];
      if(The_Ext==null){The_Ext="*.rar,*.zip";}

      FileNum=Request.QueryString["filenum"];
      if(!IsNum(FileNum)){FileNum="0";}

      The_Maxlength=Request.QueryString["maxlength"];
      if(!IsNum(The_Maxlength)){The_Maxlength="1024";}

      ListShowType=Request.QueryString["listshowtype"];
      if(!IsNum(ListShowType)){ListShowType="1";}

      Upload_Type=Request.QueryString["type"];
      if(Upload_Type!="files" && Upload_Type!="images"){Upload_Type="images";}

     SwfHeight=Request.QueryString["swfheight"];
     if(!IsNum(SwfHeight)){SwfWidth="200";}

     ReName=Request.QueryString["ReName"];
     if(!IsNum(ReName)){ReName="0";}

     Master_Valicate YZ=new Master_Valicate();
     YZ.Master_Check();
    }
  }


private void Upload_File()
 {
      bool IsSwfUpload=true;
      int AddWatermark=0,AddThumbnail=0,IsPic=0;
      HttpPostedFile hpf;

      TheTable=Request.Form["table"];
      SiteId=Request.Form["siteid"];
      ObjId=Request.Form["objid"];
      The_Ext=Request.Form["fileext"];
      FileNum=Request.Form["filenum"];
      The_Maxlength=Request.Form["maxlength"];
      Upload_Type=Request.Form["type"];
      ReName=Request.Form["ReName"];

      if(IsSwfUpload)
       {
        hpf=Request.Files["filedata"];
        if(Upload_Type=="images")
         {
          IsPic=1;
         }
       }
      else
       {
         hpf=Request.Files["file"];
       } 
      int hpfLength=hpf.ContentLength;
      if(hpfLength==0)
       {
         Write_Result("result=emptyfile");
         return;
       }
      string Source_FileName=Path.GetFileNameWithoutExtension(hpf.FileName);
      string File_ext=Path.GetExtension(hpf.FileName).ToLower();
      if((".aspx,.asp,.php,.asa,.jsp,.shtml").IndexOf(File_ext)>=0)
       {
         Write_Result("result=dangerousext&cs="+File_ext);
         return;
       }

      if(hpfLength>int.Parse(The_Maxlength)*1024)
       {
         Write_Result("result=toolarge&cs="+The_Maxlength.ToString());
         return;
       }

      if(The_Ext.IndexOf(File_ext)<0)
       {
         Write_Result("result=noext&cs="+File_ext);
         return;
       }

      if(hpfLength>0)
      {
        if(Upload_Type=="images")
         {
            if(IsImage(hpf)) 
            {
             IsPic=1;
            }
          if(IsPic==0)
            {
              Write_Result("result=invalidimage&cs="+File_ext);
              return;
            }
         }
         string RootPath="/e/upload/s"+SiteId+"/"+TheTable+"/"+Upload_Type+"/";
         DateTime nowdt=DateTime.Now;
         string dir=nowdt.ToString("yyyy")+"/"+nowdt.ToString("MM");
         string SavePath=RootPath+dir+"/";
         if(!Directory.Exists(Server.MapPath(SavePath)))
          {
            Directory.CreateDirectory(Server.MapPath(SavePath));
          }

         string File_Name;
         if(ReName=="1")
          {
            File_Name=DateTime.Now.ToString("ddHHmmss");
            if(IsSwfUpload && Request.Form["access2008_box_info_over"]!="0"){File_Name+="_"+Request.Form["access2008_box_info_over"];}
            File_Name+=File_ext;
          }
         else
          {
           Source_FileName=Source_FileName.Replace(";","_").Replace(".","_").Replace(" ","_");
           File_Name=Source_FileName+File_ext;
          }
        int num=0;
        string Start_File_Name=File_Name;
        while(true)
         {
           if(!File.Exists(Server.MapPath(SavePath+File_Name)))
            {
             break;
            }
           num++;
           File_Name=(Start_File_Name.Split('.'))[0]+"_"+num+File_ext;
         }
       string SaveFile=SavePath+File_Name;
       hpf.SaveAs(Server.MapPath(SaveFile));
       if(AddWatermark==1 && IsPic==1 && Upload_Type=="images")
        {
         Watermark WM=new Watermark();
         SaveFile=WM.Add_Watermark(int.Parse(SiteId),SaveFile);
        } 
       string ThumbnailUrl="";
       if(AddThumbnail==1 && IsPic==1 && Upload_Type=="images")
        {
         //Thumbnail TB=new Thumbnail();
         //ThumbnailUrl=TB.Add_Thumbnail(int.Parse(SiteId),SaveFile,Twidth,Theight,false);
        }
      string Size=(hpfLength/(float)1024).ToString("F2");
      Write_Result("result=success&url="+SaveFile+"&size="+Size+"&thumbnail="+ThumbnailUrl+"&objid="+ObjId);
     }
    else
     {
       Write_Result("result=cs_error");
       return;
     }
   }

private void Write_Result(string info) 
  {
     Response.Write(info);
     Response.End();
  }

private bool IsImage(HttpPostedFile hpf)
 {
   bool rv=true;
   if(hpf.ContentType.IndexOf("image/")<0) 
     {
      rv=false;
     }
   else
    {
      try
       {
         System.Drawing.Image img = System.Drawing.Image.FromStream(hpf.InputStream);
         if(img.Width*img.Height<1){rv=false;}
         img.Dispose();
       }
     catch
      {
       rv=false;
      }  
    }   
   return rv;       
}

private bool IsStr(string str)
 { 
  if(string.IsNullOrEmpty(str)){return false;}
  string str1="0123456789abcdefghijklmnopqrstuvwxyz_";
  string str2=str.ToLower();
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
  string str1="0123456789";
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
</script><!DOCTYPE html>
<html>
<head>
<title>PageAdmin批量上传界面</title>
<style type="text/css">
body{word-wrap:break-word;font:12px/1.6em Tahoma,Helvetica,Arial,\5b8b\4f53;color:#333333;background-color:#ffffff;padding:0px;margin:0px;width:100%;}
button,input,select,textarea{font-size:13px}
form,ul,li{list-style-type:none;margin:0 0 0 0;padding:0 0 0 0;}
#list{border:0px solid menu;background-color:#cccccc}
#list td{background-color:menu;}
a:link{color:#333333;text-decoration:none}
a:visited{color:#333333;text-decoration:none}
a:hover{color:#333333;text-decoration:underline}
.main{border:1px solid #999999;text-align:cetner;padding:5px;margin:10px;background-color:#D1EAFE;}
.main table td{padding:3px 3px 4px 3px;}
.button{
	width:55px;
	font-size:9pt;
	height:19px;
	cursor: hand;
	background-image: url(/e/images/public/button.gif);
	background-position: center center;
	border-top: 0px outset #eeeeee;
	border-right: 0px outset #888888;
	border-bottom: 0px outset #888888;
	border-left: 0px outset #eeeeee;
	padding-top: 2px;
	background-repeat: repeat-x;
	}

.tabhead{}
.tabhead ul{height:20px;clear:both;overflow:hidden}
.tabhead ul li{float:left;width:100px;height:20px;text-align:center;border:1px solid #999999;border-bottom:0px;margin-right:5px;line-height:20px;cursor:pointer}
.tabhead ul li.current{background-color:#D1EAFE;}
select .rootnode{background-color:#8AC9FD}
select .childnode{background-color:#D1EAFE}
</style>
<script type="text/javascript">
 var CurrentNums="0";
 if(isNaN(CurrentNums)){CurrentNums="0";}
 CurrentNums=parseInt(CurrentNums);
 var AuotTitlePic="";
 var PostType="add";
 var PostFile="/e/aspx/up.aspx";
 var TypeFile = ["(<%=The_Ext%>)","<%=The_Ext.Replace(",",";")%>"];
 var NewTypeFile = ["(<%=The_Ext%>)","<%=The_Ext.Replace(",",";")%>"];
 var FileNum =<%=FileNum%>;//可限制待传文件的数量，0或负数为不限制
 var Size = <%=(float.Parse(The_Maxlength)/1024).ToString("f2")%>;//上传单个文件限制大小，单位KB，可以填写小数类型
 var FormID = ['siteid','table','fileext','maxlength','rename','type','watermark','post'];//设置每次上传时将注册了ID的表单数据以POST形式发送到服务器需要设置的FORM表单中checkbox,text,textarea,radio,select项目的ID值,radio组只需要一个设置ID即可参数为数组类型，注意使用此参数必须有 challs_flash_FormData() 函数支持
 var ListShowType =<%=ListShowType%>;//文件列表显示类型：1 = 传统列表显示，2 = 缩略图列表显示（适用于图片专用上传）,3 = 单列模式4 = MP3播放模式
</script>
<script language="javascript" src="/e/incs/swfupload/diyupload.js"></script>
</head>
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<div class="main">
<table border=0 cellpadding=10 cellspacing=0 width=98%>
 <tr>
<td valign=top align="left">
<form  Enctype="multipart/form-data">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center class=table_style2>
<tr>
  <td valign=top>
<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=11,0,0,0" width="100%" height="<%=SwfHeight%>" id="update" align="middle">
<param name="allowFullScreen" value="false" />
    <param name="allowScriptAccess" value="always" />
	<param name="movie" value="/e/incs/swfupload/upload.swf" />
    <param name="quality" value="high" />
    <param name="bgcolor" value="#ffffff" />
    <embed src="/e/incs/swfupload/upload.swf" quality="high" bgcolor="#ffffff" width="100%" height="<%=SwfHeight%>" name="update" align="middle" allowScriptAccess="always" allowFullScreen="false" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
	</object>
   <div style="padding-left:20px">
      <input type="checkbox" id="watermark" name="watermark" value="1">增加水印
   </div> 
   <input type="hidden" id="siteid" name="siteid" value="<%=SiteId%>">
   <input type="hidden" id="table" name="table" value="<%=TheTable%>">
   <input type="hidden" id="fileext" name="fileext" value="<%=The_Ext%>">
   <input type="hidden" id="maxlength" name="maxlength" value="<%=The_Maxlength%>">
   <input type="hidden" id="rename" name="rename" value="<%=ReName%>">
   <input type="hidden" id="type" name="type" value="<%=Upload_Type%>">
   <input type="hidden" id="objid" name="objid" value="<%=ObjId%>">
   <input type="hidden" id="post" name="post" value="upload">
</td>
</tr>
</table>
</form>
</td>
</tr>
</table>
<div id="show"></div>
</div>
<div align="center"><input type="button" value="关闭" class="button" onclick="parent.CloseDialog()"></div>
</body>
</html>
<!--
 本页调用说明：
 调用地址：up.aspx?siteid=1&table=pa_biao&fileext=*.doc,*.docx,*.rar,*.zip&filenum=0&type=images&maxlength=2&rename=0&listshowtype=1&swfheight=200&objid=objid";
  siteid：站点id
  table:表明
  fileext：允许的后缀名。
  filenum：允许最大上传数。
  type：images或files。
  maxlength：允许上传文件大小,单位kb
  rename：是否重命名。
  listshowtype：列表显示方式。
  swfheight:flash高。
-->