<% @ Page Language="C#"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="System.Net"%>
<% @ Import NameSpace="PageAdmin"%>
<script Language="c#" Runat="server">
 protected void Page_Load(Object src,EventArgs e)
   {
     if(Session["update"]!=null)
      {
        Download_File();
        Session["update"]="1";
      }
   }

private void Download_File()
 {
   string DownPath=Request.QueryString["filepath"];
   if(string.IsNullOrEmpty(DownPath))
   {
     Response.Write("获取文件路径失败！");
     Response.End();
    }
   bool AllowDomain=false;
   string[] DownDomain=new string[]{"http://download.pageadmin.net/","http://file.pageadmin.net/","http://down.pageadmin.net/","http://update.pageadmin.net/","http://autoupdate.pageadmin.net/","http://updatefile.pageadmin.net/"};
   for(int i=0;i<DownDomain.Length;i++)
      {
        if(DownPath.IndexOf(DownDomain[i])==0)
          {
             AllowDomain=true;
             break;
          }
       }
    if(!AllowDomain)
       {
         Response.Write("无效的下载路径!");
         Response.End();
       }
   string RootPath,File_Name;
   RootPath="/e/update/file/";
   string SavePath=RootPath;
   if(!Directory.Exists(Server.MapPath(SavePath)))
     {
       Directory.CreateDirectory(Server.MapPath(SavePath));
     }
   char[] de={'/'};
   string[] Afilename=DownPath.Split(de);
   File_Name=Afilename[Afilename.Length-1].ToLower();
   string File_Download_Path=SavePath+File_Name;
   if(File.Exists(Server.MapPath(File_Download_Path)))
     {
       File.Delete(Server.MapPath(File_Download_Path));
     }
   try  
     {   
       DownFile(DownPath,Server.MapPath(File_Download_Path));
       Response.Write("success");
     }  
    catch(Exception ex){Response.Write("升级文件下载失败，原因：" + ex.Message);}  
    Response.End();
 }

private void DownFile(string Url,string Path)
 {

  HttpWebRequest request = (HttpWebRequest)WebRequest.Create(Url);
  HttpWebResponse response = (HttpWebResponse)request.GetResponse();
  Stream stream = response.GetResponseStream();
  long size = response.ContentLength;
//创建文件流对象
  using (FileStream fs = new FileStream(Path, FileMode.OpenOrCreate, FileAccess.Write))
  {
    byte[] b = new byte[1025];
   int n = 0;
   while ((n = stream.Read(b, 0, 1024)) > 0)
   {
     fs.Write(b, 0, n);
    }
  } 
 }

</script>
</body>
</html>  



