<% @ Page language="c#"%> 
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<% @ Import NameSpace="System.IO"%>
<script language="c#" runat="server">
 string InforTitle,thetable,Id,Detail_Id,path,sql;
 int Site_Id;
 OleDbConnection conn;
 protected void Page_Load(Object src,EventArgs e)
  {
    thetable="";
    path="";
    Id=Request.QueryString["id"];
    Detail_Id="0";
    if(IsNum(Id))
     {
       Conn theconn=new Conn();
       conn=new OleDbConnection(theconn.Constr());
       conn.Open();
       sql="select url,permissions,point,thetable,detail_id from pa_file where id="+int.Parse(Id);
       OleDbCommand comm=new OleDbCommand(sql,conn);
       OleDbDataReader dr=comm.ExecuteReader();
       if(dr.Read()) 
       {
         thetable=dr["thetable"].ToString();
         Detail_Id=dr["detail_id"].ToString();
         path=dr["url"].ToString();
         path=Server.MapPath(path);
         if(File.Exists(path))
           {
             if(thetable!="")
              {
               sql="update "+thetable+" set downloads=downloads+1 where id="+int.Parse(Detail_Id);
               comm=new OleDbCommand(sql,conn);
               comm.ExecuteNonQuery();
              }
              if(dr["permissions"].ToString()!="0" || dr["point"].ToString()!="0")
              {
               Check_Member(","+dr["permissions"].ToString()+",",int.Parse(dr["point"].ToString()));
              }
             FileInfo fi = new FileInfo(path);
             Response.Clear();
             Response.ClearHeaders();
             Response.Buffer = false;
             Response.AppendHeader("Content-Disposition","attachment;filename=" +HttpUtility.UrlEncode(Path.GetFileName(path),System.Text.Encoding.UTF8));
             Response.AppendHeader("Content-Length",fi.Length.ToString());
             Response.ContentType="application/octet-stream";
             Response.WriteFile(path);
             Response.Flush();
             dr.Close();
             conn.Close();
             Response.End();
         }
        else
         {
           path="notexists";
         }
       }
       else
       {
         path="notexists";
       }
      dr.Close();
      conn.Close();
      Response.Write(path);
      Response.End();
    }
  }

private void Check_Member(string Permissions,int Point)
 {
    if(Request.Cookies["Member"]==null)
      {
       Response.Write("notlogin");
       Response.End();
      }
    else
      {
        Member_Valicate MCheck=new Member_Valicate();
        MCheck.Member_Check(true);

        string UserName=Request.Cookies["Member"].Values["UserName"].ToString();
        sql="select m_type,point_ky from pa_member where username='"+UserName+"'";
        OleDbCommand comm=new OleDbCommand(sql,conn);
        OleDbDataReader dr=comm.ExecuteReader();
        if(dr.Read())
         {

           if(Permissions!=",0," && Permissions.IndexOf(","+dr["m_type"].ToString()+",")<0)
            {
             dr.Close();
             Response.Write("nopermission");
             Response.End();
            }
            
           if(int.Parse(dr["point_ky"].ToString())<Point)
            {
             dr.Close();
             Response.Write("nopoint");
             Response.End();
            }
           else if(Point>0)
            {
             string Identification=thetable+"."+Detail_Id;
             if(!Check_Downloaded(Identification)) //检查是否有扣点记录
              {
               sql="update pa_member set point_ky=point_ky-"+Point+",point_xf=point_xf+"+Point+" where username='"+UserName+"'";
               comm=new OleDbCommand(sql,conn);
               comm.ExecuteNonQuery();
               Get_Infor();

               sql="insert into pa_fnc_list(site_id,thetype,username,act,amount,detail,beizhu,identification) values("+Site_Id+",2,'"+UserName+"','k',"+Point+",'下载附件','"+InforTitle+"','"+Identification+"')";
               comm=new OleDbCommand(sql,conn);
               comm.ExecuteNonQuery();
              }
            }
         }
        else
         {
           dr.Close();
           Response.Write("notlogin");
           Response.End();
         }
       dr.Close();
      }
 }

private void Get_Infor()
 {
  sql="select site_id,title from "+thetable+" where id="+int.Parse(Detail_Id);
  OleDbCommand comm=new OleDbCommand(sql,conn);
  OleDbDataReader dr=comm.ExecuteReader();
  if(dr.Read()) 
    {
      Site_Id=int.Parse(dr["site_id"].ToString());
      InforTitle=Sql_Format(dr["title"].ToString());
    }
  else
    {
     Site_Id=0;
     InforTitle="";
    }
  dr.Close();
 }

private bool Check_Downloaded(string Identification) //判断是否重复下载过
 {
   bool Rv=false;
   int  DownloadDays=365;
   string Dbtype=ConfigurationManager.AppSettings["DbType"].ToString(); 
   if(Dbtype=="0")
    {
      sql="select id from pa_fnc_list where identification='"+Identification+"' and datediff('d',thedate,Now())>"+DownloadDays;
    }
   else
    {
      sql="select id from pa_fnc_list where identification='"+Identification+"' and datediff(day,thedate,getdate())>"+DownloadDays;
    }
  OleDbCommand comm=new OleDbCommand(sql,conn);
  OleDbDataReader dr=comm.ExecuteReader();
  if(dr.Read()) 
    {
      Rv=true;
    }
  dr.Close();
  return Rv;
 }

private string Sql_Format(string str)
 {
  if(str=="" || str==null)
   {
    return "";
   }
   str=str.Replace("'","''");
   str=str.Replace("\"","\""); 
   return str;
 }

private bool IsStr(string str)
 {
  if(str=="" || str==null)
   {
    return false;
   }
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
  if(str=="" || str==null)
   {
    return false;
   }
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
</script>