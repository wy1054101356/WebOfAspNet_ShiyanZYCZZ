<% @ Page Language="C#"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="System.Net"%>
<% @ Import NameSpace="System.Text"%>
<% @ Import  NameSpace="System.Data"%>
<% @ Import  NameSpace="System.Data.OleDb"%>
<% @ Import  NameSpace="System.Configuration"%>
<% @ Import NameSpace="PageAdmin"%>
<script Language="c#" Runat="server">
 OleDbConnection conn;
  protected void Page_Load(Object src,EventArgs e)
   {
      if(File.Exists(Server.MapPath("/bin/PageAdmin.Web.dll")))
        {
          Conn myconn=new Conn();
          conn=myconn.OleDbConn();
          Update_File();
          Session["update"]=null;
        }
   }

 protected void Update_File()
    {
       string DownPath=Request.QueryString["filepath"];
       string Version=Request.QueryString["version"];
       string UpdateVersion=Request.QueryString["updateversion"];
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
       string DirPath=FilePath.Split('.')[0];
      try
       {
        if(Directory.Exists(Server.MapPath(DirPath)))
        {
          CopyFile(Server.MapPath(DirPath),Server.MapPath("/")); //复制升级文件覆盖
          Update_Log(Version,UpdateVersion);
          conn.Open();
          Update_ModelFile();
          Update_TagFile();
          conn.Close();
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

private void Update_Log(string Version,string UpdateVersion)
 {
      string File_Path=Server.MapPath("/e/update/update.log");
      Encoding encoding=Encoding.GetEncoding("UTF-8"); 
      FileStream fs=new FileStream(File_Path,FileMode.Append,FileAccess.Write);
      StreamWriter rw=new StreamWriter(fs,encoding);
      rw.Write("升级时间："+DateTime.Now.ToString()+"\r\n升级日志："+Version+"升级到"+UpdateVersion+"\r\n--------------------------------------------------\r\n");
      rw.Flush();
      fs.Close();
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

private void Update_ModelFile()
 {
    string Ftable,fpath,NewFile,Mtype,Model_Content="",Id;
    string sql="select id,content,thetype,thetable from pa_model where hasfile=1";
    OleDbCommand Comm=new OleDbCommand(sql,conn);
    OleDbDataReader dr=Comm.ExecuteReader();
    while(dr.Read())
     {
       Ftable=dr["thetable"].ToString();
       Id=dr["id"].ToString();
       Mtype=dr["thetype"].ToString();
       Model_Content=dr["content"].ToString();
       fpath="/e/zdymodel/"+Ftable+"/"+Mtype+"/";
       if(!Directory.Exists(Server.MapPath(fpath)))
       {
        Directory.CreateDirectory(Server.MapPath(fpath));
       }
      if(Mtype=="ajax")
       {
        NewFile=fpath+Id+".aspx";
        Create_ModelFile(NewFile,Model_Content,"/e/aspx/ajax_zdymodel.aspx",Id);
       }
      else if(Mtype=="custom")
       {
         NewFile=fpath+Id.ToString()+".aspx";
         Create_ModelFile(NewFile,Model_Content,"/e/aspx/custom_zdymodel.aspx",Id);
       }
      else
       {
       NewFile=fpath+Id+".ascx";
       Create_ModelFile(NewFile,Model_Content,"/e/usercontrol/"+Mtype+"_zdymodel.ascx",Id);
       }
    }
   dr.Close();
 }


private void Create_ModelFile(string NewFile,string ModelContent,string FileTemplate,string Id)
 {
   string File_Path=Server.MapPath(FileTemplate);
   Encoding encoding=Encoding.GetEncoding("UTF-8"); 
   FileStream fs=new FileStream(File_Path,FileMode.Open,FileAccess.Read);
   StreamReader Re=new StreamReader(fs,encoding);
   string F_Content=Re.ReadToEnd();
   Re.Close();
   F_Content=F_Content.Replace("{pa:Model_Content}",ModelContent);
   F_Content=F_Content.Replace("{pa:Model_Id}",Id);
   File_Path=Server.MapPath(NewFile);
   fs=new FileStream(File_Path,FileMode.Create,FileAccess.Write);
   StreamWriter rw=new StreamWriter(fs,encoding);
   rw.Write(F_Content);
   rw.Flush();
   rw.Close();
   fs.Close();
 }

//更新标签
private void Update_TagFile()
 {
   string sql="select id,zdy_tag from pa_module where zdy_tag_open=1";
   OleDbCommand mycomm=new  OleDbCommand(sql,conn);
   OleDbDataReader dr=mycomm.ExecuteReader();
   while(dr.Read())
    {
     if(dr["zdy_tag"].ToString()!="")
      {
       Create_Module_File(dr["zdy_tag"].ToString(),dr["id"].ToString());
      }
    }
   dr.Close();

   sql="select id,zdy_tag from pa_nav where zdy_tag_open=1";
   mycomm=new  OleDbCommand(sql,conn);
   dr=mycomm.ExecuteReader();
   while(dr.Read())
    {
     if(dr["zdy_tag"].ToString()!="")
      {
       Create_Nav_File(dr["zdy_tag"].ToString(),dr["id"].ToString());
      }
    }
   dr.Close();
 }


private void Create_Module_File(string Tag_Content,string ModuleId)
 {
   string File_Path=Server.MapPath("/e/zdytag/template.ascx");
   Encoding encoding=Encoding.GetEncoding("UTF-8"); 
   FileStream fs=new FileStream(File_Path,FileMode.Open,FileAccess.Read);
   StreamReader Re=new StreamReader(fs,encoding);
   string F_Content=Re.ReadToEnd();
   Re.Close();

   string t_rules=@"{pa:model}(?<siteid>\d+),(?<modelid>\d+),(?<sortid>\d+),(?<sqlcondition>[^{}]*),(?<sqlsort>[^{},]*),(?<target>[^{},]*),(?<shownum>\d+),(?<titlenum>\d+),(?<picwidth>\d+),(?<picheight>\d+){/pa:model}";
   Tag_Content=Get_Module_Template(Tag_Content,t_rules,ModuleId);
   F_Content=F_Content.Replace("{pa:ReplaceContent}",Tag_Content);
   File_Path=Server.MapPath("/e/zdytag/module/"+ModuleId+".ascx");

   fs=new FileStream(File_Path,FileMode.Create,FileAccess.Write);
   StreamWriter rw=new StreamWriter(fs,encoding);
   rw.Write(F_Content);
   rw.Flush();
   rw.Close();
   fs.Close();
 }

private string Get_Module_Template(string content,string rules,string ModuleId)
 {
  Regex Reg=new Regex(rules,RegexOptions.IgnoreCase);
  MatchCollection Ms=Regex.Matches(content,rules,RegexOptions.IgnoreCase); 
  int i=0;
  foreach (Match M in Ms)
   {
    content=new Regex(M.Value).Replace(content,Get_Module_Content(ModuleId,(i++).ToString(),M.Groups["siteid"].Value,M.Groups["modelid"].Value,M.Groups["sortid"].Value,M.Groups["sqlcondition"].Value,M.Groups["sqlsort"].Value,M.Groups["target"].Value,M.Groups["shownum"].Value,M.Groups["titlenum"].Value,M.Groups["picwidth"].Value,M.Groups["picheight"].Value),1);
   }
  return content;
 }

private string Get_Module_Content(string ModuleId,string TagNameId,string Site_Id,string Model_Id,string SortId,string SqlCondition,string SqlOrder,string Target,string ShowNum,string TitleNum,string PicWidth,string PicHeight)
 {
   OleDbDataReader dr;
   OleDbCommand comm;
   string Rv="",sql;
   if(IsNum(Model_Id))
    {
     sql="select thetable from pa_model where id="+int.Parse(Model_Id);
     comm=new OleDbCommand(sql,conn);
     dr=comm.ExecuteReader();
     if(dr.Read())
      { 
        Rv="<% @ Register TagPrefix=\"ascx\" TagName=\"M_"+TagNameId+"\" src=\"/e/zdymodel/"+dr["thetable"].ToString()+"/module/"+Model_Id+".ascx\"%>"; 
        if(!IsNum(SortId))
         {
           SortId="0";
         }
        Rv+="<ascx:M_"+TagNameId+" runat=\"server\" SiteId="+Site_Id.ToString()+" ZdyTag=1 ModuleId=\""+ModuleId.ToString()+"_"+TagNameId+"\"  TagTable=\""+dr["thetable"].ToString()+"\" TagSortId="+SortId+" SqlOrder=\"order by "+SqlOrder+"\" SqlCondition=\""+ZH_Tag(SqlCondition)+"\" ShowNum="+ShowNum+" TitleNum="+TitleNum+" TitlePicWidth="+PicWidth+" TitlePicHeight="+PicHeight+" TheTarget=\""+Target+"\"/>";
      }
     dr.Close();
   }
   return Rv;
 }


private void Create_Nav_File(string Tag_Content,string NavId)
 {
   string File_Path=Server.MapPath("/e/zdytag/template.ascx");
   Encoding encoding=Encoding.GetEncoding("UTF-8"); 
   FileStream fs=new FileStream(File_Path,FileMode.Open,FileAccess.Read);
   StreamReader Re=new StreamReader(fs,encoding);
   string F_Content=Re.ReadToEnd();
   Re.Close();

   string t_rules=@"{pa:model}(?<siteid>\d+),(?<modelid>\d+),(?<sortid>\d+),(?<sqlcondition>[^{},]*),(?<sqlsort>[^{},]*),(?<target>[^{},]*),(?<shownum>\d+),(?<titlenum>\d+),(?<picwidth>\d+),(?<picheight>\d+){/pa:model}";
   Tag_Content=Get_Nav_Template(Tag_Content,t_rules,NavId);
   F_Content=F_Content.Replace("{pa:ReplaceContent}",Tag_Content);
   File_Path=Server.MapPath("/e/zdytag/nav/"+NavId+".ascx");

   fs=new FileStream(File_Path,FileMode.Create,FileAccess.Write);
   StreamWriter rw=new StreamWriter(fs,encoding);
   rw.Write(F_Content);
   rw.Flush();
   rw.Close();
   fs.Close();
 }

private string Get_Nav_Template(string content,string rules,string Nav_Id)
 {
  Regex Reg=new Regex(rules,RegexOptions.IgnoreCase);
  MatchCollection Ms=Regex.Matches(content,rules,RegexOptions.IgnoreCase); 
  int i=0;
  foreach (Match M in Ms)
   {
    content=new Regex(M.Value).Replace(content,Get_Nav_Content(Nav_Id,(i++).ToString(),M.Groups["siteid"].Value,M.Groups["modelid"].Value,M.Groups["sortid"].Value,M.Groups["sqlcondition"].Value,M.Groups["sqlsort"].Value,M.Groups["target"].Value,M.Groups["shownum"].Value,M.Groups["titlenum"].Value,M.Groups["picwidth"].Value,M.Groups["picheight"].Value),1);
   }
  return content;
 }

private string Get_Nav_Content(string Nav_Id,string TagNameId,string Site_Id,string Model_Id,string SortId,string SqlCondition,string SqlOrder,string Target,string ShowNum,string TitleNum,string PicWidth,string PicHeight)
 {
   OleDbDataReader dr;
   OleDbCommand comm;
   string Rv="",sql;
   if(IsNum(Model_Id))
    {
     sql="select thetable from pa_model where id="+int.Parse(Model_Id);
     comm=new OleDbCommand(sql,conn);
     dr=comm.ExecuteReader();
     if(dr.Read())
      {
        Rv="<% @ Register TagPrefix=\"ascx\" TagName=\"M_"+TagNameId+"\" src=\"/e/zdymodel/"+dr["thetable"].ToString()+"/nav/"+Model_Id+".ascx\"%>"; 
        if(!IsNum(SortId))
         {
           SortId="0";
         }
        Rv+="<ascx:M_"+TagNameId+" runat=\"server\" SiteId="+Site_Id.ToString()+" NavId=\""+Nav_Id.ToString()+"_"+TagNameId+"\" ZdyTag=1 TagTable=\""+dr["thetable"].ToString()+"\" TagSortId="+SortId+" SqlOrder=\"order by "+SqlOrder+"\" SqlCondition=\""+ZH_Tag(SqlCondition)+"\" ShowNum="+ShowNum+" TitleNum="+TitleNum+" TitlePicWidth="+PicWidth+" TitlePicHeight="+PicHeight+" TheTarget=\""+Target+"\"/>";
      }
     dr.Close();
   }
   return Rv;
 }

private string ZH_Tag(string content)
 {
   content=content.Replace("/fxg/","\\");
   content=content.Replace("/xh/","*");
   content=content.Replace("/jh/","+");
   content=content.Replace("/wh/","?");
   content=content.Replace("/my/","$");
   content=content.Replace("/lykh/","(");
   content=content.Replace("/rykh/",")");
   content=content.Replace("/lfkh/","[");
   content=content.Replace("/rfkh/","]");
   content=content.Replace("/ldkh/","{");
   content=content.Replace("/rdkh/","}");
   return content;
 }
//更新标签
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

private string Sql_Format(string str)
 {
   string Res=str.Replace("'","''");
   return Res;
 }
</script>