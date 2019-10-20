<% @ Page language="c#"%> 
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<% @ Import NameSpace="System.IO"%>
<script language="c#" runat="server">
 string FromUrl,SiteLanguage,SiteId,thetable,Field,Id,Detail_Id,ErrorInfo,path,FilePath,FileName,UserName,Point_Expire,sql;
 int Need_Point,Ky_Point,IsHttpFile;
 OleDbConnection conn;
 protected void Page_Load(Object src,EventArgs e)
  {
    FromUrl=Request.ServerVariables["HTTP_REFERER"];
    SiteId="0";
    SiteLanguage="zh-cn";
    Check_FromUrl();
    Conn Myconn=new Conn();
    conn=Myconn.OleDbConn();//获取OleDbConnection
    if(IsStr(Request.QueryString["table"]) && IsStr(Request.QueryString["field"]) && IsNum(Request.QueryString["id"]))
     {
       From_Table();
     }
    else if(IsNum(Request.QueryString["id"]))
     {
       From_PaFile();
     }
  }

private void From_Table() 
 {
   thetable=Request.QueryString["table"];
   Field=Request.QueryString["field"];
   Detail_Id=Request.QueryString["id"];
   ErrorInfo="";
   IsHttpFile=0;
   conn.Open();
   sql="select id from pa_field where thetable='"+thetable+"' and [field]='"+Field+"' and field_type='file'"; //检测字段
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(!dr.Read()) 
    {
     ErrorInfo="notexists";
    }
   dr.Close();
   if(ErrorInfo=="notexists"){conn.Close();return;}
   sql="select "+Field+" from "+thetable+" where id="+int.Parse(Detail_Id);
   comm=new OleDbCommand(sql,conn);
   dr=comm.ExecuteReader();
   if(dr.Read()) 
     {
       FilePath=dr[Field].ToString();
       if(FilePath!="")
         {
             if(FilePath.ToLower().IndexOf("http://")>=0 || FilePath.ToLower().IndexOf("https://")>=0 || FilePath.ToLower().IndexOf("ftp://")>=0 )
              {
                IsHttpFile=1;
              }
             else
              {
                FilePath=Server.MapPath(FilePath);
                if(!File.Exists(FilePath))
                {
                  ErrorInfo="notexists";
                }
              }
           if(ErrorInfo=="")
           {
            dr.Close();

             sql="update "+thetable+" set downloads=downloads+1 where id="+int.Parse(Detail_Id);
             comm=new OleDbCommand(sql,conn);
             comm.ExecuteNonQuery();

             sql="update pa_file set downloads=downloads+1 where thetable='"+thetable+"' and field='"+Field+"' and detail_id="+int.Parse(Detail_Id);
             comm=new OleDbCommand(sql,conn);
             comm.ExecuteNonQuery();

            conn.Close();
            ReadFile();
           }
        }
      else
        {
         ErrorInfo="notexists";
        }
     }
   else
     {
      ErrorInfo="notexists";
     }
   dr.Close();
   conn.Close();
 }

private void From_PaFile() //从附件组
 {
    thetable="";ErrorInfo="";
    IsHttpFile=0;
    Id=Request.QueryString["id"];//附件表的id
    Detail_Id="0"; //对应的信息表的id
    if(IsNum(Id))
     {
       conn.Open();
       sql="select [title],site_id,url,permissions,point,thetable,detail_id from pa_file where id="+int.Parse(Id);
       OleDbCommand comm=new OleDbCommand(sql,conn);
       OleDbDataReader dr=comm.ExecuteReader();
       if(dr.Read()) 
       {
         FilePath=dr["url"].ToString();
         if(FilePath!="")
         {
             SiteId=dr["site_id"].ToString();
             thetable=dr["thetable"].ToString();
             Detail_Id=dr["detail_id"].ToString();
             FileName=dr["title"].ToString();
             Need_Point=int.Parse(dr["point"].ToString());
             if(FilePath.ToLower().IndexOf("http://")>=0 || FilePath.ToLower().IndexOf("https://")>=0 || FilePath.ToLower().IndexOf("ftp://")>=0 )
              {
                IsHttpFile=1;
              }
             else
              {
                FilePath=Server.MapPath(FilePath);
                if(!File.Exists(FilePath))
                {
                 ErrorInfo="notexists";
                 dr.Close();
                 conn.Close();
                 return;
                }
              }
          
              if(dr["permissions"].ToString()!="" || Need_Point>0) //检查权限和积分
                {
                  Check_Member(dr["permissions"].ToString());
                }
               if(ErrorInfo=="" && IsStr(thetable))
                 {
                  sql="update "+thetable+" set downloads=downloads+1 where id="+int.Parse(Detail_Id);
                  comm=new OleDbCommand(sql,conn);
                  comm.ExecuteNonQuery();

                  sql="update pa_file set downloads=downloads+1 where id="+int.Parse(Id);
                  comm=new OleDbCommand(sql,conn);
                  comm.ExecuteNonQuery();
                  dr.Close();
                  conn.Close();
                  ReadFile();//下载文件
                }
         }
       }
       else
       {
        dr.Close();
        conn.Close();
        ErrorInfo="notexists";
       }
      dr.Close();
      conn.Close();
    }
 }

private void ReadFile()
 {
    if(IsHttpFile==0)
     {
      Response.Clear();
      Response.ContentType="application/x-zip-compressed";
      //Response.ContentType="application/octet-stream";
      Response.Charset="utf-8";
      Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
      Response.AddHeader("Content-Disposition", "attachment;filename="+Server.UrlEncode(Path.GetFileName(FilePath)));
      Response.TransmitFile(FilePath);
      Response.End();
     }
    else
     {
      Response.Redirect(FilePath);
      Response.End();
    }
 }

private void Check_Member(string Permissions)
 {
    Get_Site();//获取语言调用对应js
    Get_WebSet();//获取积分相关设置
    if(Request.Cookies["Member"]==null)
      {
       ErrorInfo="notlogin";
      }
    else
      {
        Member_Valicate MCheck=new Member_Valicate();
        MCheck.Member_Check();
        UserName=MCheck._UserName;
        sql="select mtype_id,point_ky from pa_member where username='"+UserName+"'";
        OleDbCommand comm=new OleDbCommand(sql,conn);
        OleDbDataReader dr=comm.ExecuteReader();
        if(dr.Read())
         {
           if(Permissions!="" && IsContains(dr["mtype_id"].ToString(),Permissions.Split(',')))
            {
               ErrorInfo="nopermission";
            }
           else
            {
               Ky_Point=int.Parse(dr["point_ky"].ToString());
               if(Need_Point>0)//检查积分并记录
               {
                  string Identification="pa_file_"+Id;
                  if(!Check_Downloaded(Identification)) //检查是否需要扣除积分。
                   {
                     if(Ky_Point<Need_Point)
                     {
                       ErrorInfo="nopoint"; //积分不足;
                     }
                   else
                     {
                       sql="update pa_member set point_ky=point_ky-"+Need_Point+",point_xf=point_xf+"+Need_Point+" where username='"+UserName+"'";
                       comm=new OleDbCommand(sql,conn);
                       comm.ExecuteNonQuery();

                       FileName="<a href=\""+FromUrl+"\" target=\"_blank\">"+FileName+"</a>";
                       sql="insert into pa_fnc_list(site_id,thetype,username,act,amount,detail,beizhu,identification,state) values("+int.Parse(SiteId)+",2,'"+UserName+"','k',"+Need_Point+",'下载附件','"+FileName+"','"+Identification+"',1)";
                       comm=new OleDbCommand(sql,conn);
                       comm.ExecuteNonQuery();
                    }
                 }
              }
            }
         }
       dr.Close();
     }
 }


private bool Check_Downloaded(string Identification) //判断是否有下载记录
 {
   bool Rv=false;
   int  DownloadDays=0; 
   if(IsNum(Point_Expire))
    {
      DownloadDays=int.Parse(Point_Expire);
    }
   if(DownloadDays==0)
    {
      return Rv;
    }
   else
    {
      string Dbtype=ConfigurationManager.AppSettings["DbType"].ToString(); 
      if(Dbtype=="0")
      {
       sql="select id from pa_fnc_list where username='"+UserName+"' and thetype=2 and identification='"+Identification+"' and datediff('d',thedate,Now())<"+DownloadDays;
      }
     else
      {
       sql="select id from pa_fnc_list where username='"+UserName+"' and thetype=2 and identification='"+Identification+"' and datediff(day,thedate,getdate())<"+DownloadDays;
      }
     OleDbCommand comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr=comm.ExecuteReader();
     if(dr.Read()) 
      {
       Rv=true;
      }
     dr.Close();
    }
  return Rv;
 }



private void Get_Site()
 {
  sql="select [language] from pa_site where id="+int.Parse(SiteId);
  OleDbCommand comm=new OleDbCommand(sql,conn);
  OleDbDataReader dr=comm.ExecuteReader();
  if(dr.Read()) 
    {
     SiteLanguage=dr["language"].ToString();
    }
  else
    {
      SiteLanguage="zh-cn";
    }
  dr.Close();
 }

private void Get_WebSet()
 {
  sql="select point_expire from pa_webset where site_id="+int.Parse(SiteId);
  OleDbCommand comm=new OleDbCommand(sql,conn);
  OleDbDataReader dr=comm.ExecuteReader();
  if(dr.Read()) 
    {
      Point_Expire=dr["point_expire"].ToString();
    }
  else
    {
      Point_Expire="0";
    }
  dr.Close();
 }

private void Check_FromUrl()
 {

    string LocalUrl=Request.ServerVariables["SERVER_NAME"];
    if(FromUrl==null)
      {
       Response.Write("Invalid Request");
       Response.End();
      }
    else
      {
        if(FromUrl.Replace("http://","").Split('/')[0].Split(':')[0]!=LocalUrl)
         {
           Response.Write("Invalid Request");
           Response.End();
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

private bool IsContains(string str,string[] ArrStr)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  for(int i=0;i<ArrStr.Length;i++)
   {
    if(str==ArrStr[i])
     {
       return true;
     }
   }
  return false;
 }
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>附件下载</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<script src="/e/js/<%=SiteLanguage%>/lang.js" type="text/javascript"></script>
</head>
<body>
<script type="text/javascript">
Attachment_Back("<%=ErrorInfo%>",<%=Need_Point%>,<%=SiteId%>);
</script>
</body>
</html>