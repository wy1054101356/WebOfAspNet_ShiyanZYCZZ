<% @ Page Language="C#"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="PageAdmin"%>
<script Language="c#" Runat="server">
  protected void Page_Load(Object src,EventArgs e)
   {
      if(File.Exists(Server.MapPath("/bin/PageAdmin.Web.dll")))
        {
          Copy_File();
        }
   }

 protected void Copy_File()
    {
       string DownPath=Request.QueryString["filepath"];
       if(string.IsNullOrEmpty(DownPath))
        {
         Response.Write("获取文件路径失败！");
         Response.End();
        }
       string RootPath,File_Name;
       RootPath="/e/update/file/";
       char[] de={'/'};
       string[] Afilename=DownPath.Split(de);
       File_Name=Afilename[Afilename.Length-1].ToLower();
       string FilePath=RootPath+File_Name;
       FilePath=FilePath.Replace("..","");
       string DirPath=FilePath.Replace(".zip","").Replace(".rar","");
      try
       {
        if(Directory.Exists(Server.MapPath(DirPath)))
        {
          CopyFile(Server.MapPath(DirPath),Server.MapPath("/")); //复制升级文件覆盖
          Response.Write("success");
        }
       else
        {
           Response.Write("文件不存在");
        }
       }
      catch(Exception e)
       {
        Response.Write(e.Message);
       }
      Response.End();
   }   


private void CopyFile(string sources,string dest)
        { 
                DirectoryInfo dinfo=new DirectoryInfo(sources);//注，这里面传的是路径，并不是文件，所以不能保含带后缀的文件
                foreach(FileSystemInfo f in dinfo.GetFileSystemInfos())
                {
                    //目标路径destName = 目标文件夹路径 + 原文件夹下的子文件(或文件夹)名字
                     string destName = Path.Combine(dest,f.Name); //Path.Combine(string a ,string b) 为合并两个字符串
                     if (f is FileInfo)//如果是文件就复制
                      {
                        File.Copy(f.FullName,destName,true);//true代表可以覆盖同名文件
                      }
                     else//如果是文件夹就创建文件夹然后复制然后递归复制
                      {
                        if(!Directory.Exists(destName))
                         {
                           Directory.CreateDirectory(destName);
                         }
                         CopyFile(f.FullName,destName);
                       }
                }
              Directory.Delete(sources,true);//删除解压目录
        }

</script>