<% @ Page Language="C#"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="ICSharpCode.SharpZipLib.BZip2"%>
<% @ Import NameSpace="ICSharpCode.SharpZipLib.Zip"%>
<% @ Import NameSpace="ICSharpCode.SharpZipLib.Zip.Compression"%>
<% @ Import NameSpace="ICSharpCode.SharpZipLib.Zip.Compression.Streams"%>
<% @ Import NameSpace="ICSharpCode.SharpZipLib.GZip"%>
<script Language="c#" Runat="server">
  protected void Page_Load(Object src,EventArgs e)
   {
        Extract_File();
   }

  protected void Extract_File()
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
       if(!File.Exists(Server.MapPath(FilePath)))
        {
         Response.Write("升级文件不存在，请到/e/update/file下检查文件是否下载成功！");
         Response.End();
        }
       try
       {
         Decompress(Server.MapPath(FilePath),Server.MapPath(DirPath+"/"));
         File.Delete(Server.MapPath(FilePath));//删除压缩包
         Response.Write("success");
       }
       catch(Exception e)
        {
         Response.Write(e.Message);
        }
      Response.End();
   }      

private void CompressFile(string[] FileList,string ZipPath) //压缩文件为zip
  {
    using(ZipFile zip = ZipFile.Create(ZipPath))
  　　{
          zip.BeginUpdate();
　　　　　zip.SetComment("");
          string ext;
          for(int i=0;i<FileList.Length;i++)
           {
            ext=Path.GetExtension(FileList[i]);
            if(string.IsNullOrEmpty(ext))
             {
               if(Directory.Exists(FileList[i]))
               {
                zip.AddDirectory(FileList[i]); 
               }
             }
            else
             {
              if(File.Exists(FileList[i]))
               {
                zip.Add(FileList[i]);
               }
             }
           }
          zip.CommitUpdate();
     }
  }

private void CompressDirectory(string DirPath,string ZipPath) //压缩目录为zip
    {
      using(ZipOutputStream s = new ZipOutputStream(File.Create(ZipPath)))
         {
           s.SetLevel(6);
           string RootPath=DirPath;
           CompressDirectoryMethod(DirPath,s,RootPath);
           s.Finish();
           s.Close();
        }
    }

private void CompressDirectoryMethod(string DirPath,ZipOutputStream s,string RootPath) //压缩目录为zip,CompressDirectory的关联方法
        {
             string[] filenames=Directory.GetFileSystemEntries(DirPath);
             foreach (string file in filenames)
             {
                if (Directory.Exists(file))
                {
                   CompressDirectoryMethod(file+@"\",s,RootPath);  //递归压缩子文件夹
                }
                else
                {
                   using (FileStream fs = File.OpenRead(file))
                    {
                        byte[] buffer = new byte[4 * 1024];
                        //ZipEntry entry = new ZipEntry(file.Replace(Path.GetPathRoot(file),""));
                        ZipEntry entry = new ZipEntry(file.Replace(RootPath,""));
                        entry.DateTime = DateTime.Now;
                        s.PutNextEntry(entry);
                        int sourceBytes;
                        do
                        {
                           sourceBytes = fs.Read(buffer, 0, buffer.Length);
                           s.Write(buffer, 0, sourceBytes);
                        }while (sourceBytes > 0);
                    }
                }
            }
    }

private void Decompress(string ZipFile, string targetPath)   //注:其中targetPath必须/号结束，只支持zip格式
        {   
          string ext=Path.GetExtension(ZipFile).ToLower();
          if(ext==".zip")
          {
            string directoryName = targetPath;  
            if (!Directory.Exists(directoryName)) Directory.CreateDirectory(directoryName);//生成解压目录    
            string CurrentDirectory = directoryName;  
            byte[] data = new byte[2048];  
            int size = 2048;  
            ZipEntry theEntry = null;  
            using (ZipInputStream s = new ZipInputStream(File.OpenRead(ZipFile)))  
            {  
                while ((theEntry = s.GetNextEntry()) != null)  
                {  
                    if (theEntry.IsDirectory)  
                    {// 该结点是目录    
                        if (!Directory.Exists(CurrentDirectory + theEntry.Name)) Directory.CreateDirectory(CurrentDirectory + theEntry.Name);  
                    }  
                    else  
                    {  
                        if (theEntry.Name != String.Empty)  
                        {  
                            //  检查多级目录是否存在  
                            if (theEntry.Name.Contains("//"))  
                            {  
                                string parentDirPath = theEntry.Name.Remove(theEntry.Name.LastIndexOf("//") + 1);  
                                if (!Directory.Exists(parentDirPath))  
                                {  
                                    Directory.CreateDirectory(CurrentDirectory + parentDirPath);  
                                }  
                            }  
                            //解压文件到指定的目录    
                            using (FileStream streamWriter = File.Create(CurrentDirectory + theEntry.Name))  
                            {  
                                while (true)  
                                {  
                                    size = s.Read(data, 0, data.Length);  
                                    if (size <= 0) break;  
                                    streamWriter.Write(data, 0, size);  
                                }  
                                streamWriter.Close();  
                            }  
                        }  
                    }  
                }  
                s.Close();  
            }  
          }
        }  

</script>