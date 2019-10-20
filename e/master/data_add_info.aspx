<% @ Page language="c#"%> 
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 string Table,Tags,Type,Ids,NotId,Loadtype,Rv,jg,loadtype,sql;
 OleDbConnection conn;
 protected void Page_Load(Object src,EventArgs e)
  {
    Loadtype="";
    Rv="";
    jg="";
    Table=Request.QueryString["table"];
    Tags=Request.QueryString["tags"];
    Type=Request.QueryString["type"];
    Ids=Request.QueryString["ids"];
    NotId=Request.QueryString["notid"];
    loadtype=Request.QueryString["loadtype"];
    Conn Myconn=new Conn();
    conn=Myconn.OleDbConn();//获取OleDbConnection
    switch(loadtype)
     {
       case "find_list":
          find_related();
       break;

       case "related_list":
          load_relatedlist();
       break;

       case "zt_list":
          load_ztlist();
       break;

       case "qs_list":
          load_signlist();
       break;

       case "push_list":
          load_pushlist();
       break;
     }
 }
 
private void find_related() //通过tag查找相关信息
 {
    OleDbCommand comm;
    OleDbDataReader dr;

    if(IsStr(Table) && IsNum(Type) && Tags!="")//通过tag查找
     {
       if(IsNum(NotId))
        {
          NotId="and id<>"+NotId;
        }
       else
        {
         NotId="";
        }
       Tags=Sql_Format(Tags);
       string[] ATags=Tags.Split(',');
       conn.Open();
       for(int i=0;i<ATags.Length;i++)
       {
         switch(Type)
          {
           case "1":
            sql="select id,title from "+Table+" where source_id=0 and tags like '%"+Sql_Format(ATags[i])+"%' "+NotId;
           break;

           default:
            sql="select id,title from "+Table+" where source_id=0 and title like '%"+Sql_Format(ATags[i])+"%' "+NotId;
           break;
          }
         comm=new OleDbCommand(sql,conn);
         dr=comm.ExecuteReader();
         while(dr.Read()) 
         {
          if(Rv!="")
           {
             jg="\"";
           }
           Rv+=jg+dr["id"].ToString()+","+Server.HtmlEncode(dr["title"].ToString());
         }
        dr.Close();
      }
     conn.Close();
    }
   Response.Write(Rv);
   Response.End();
 }

private void load_relatedlist() //通过相关列表
 {
    conn.Open();
    OleDbCommand comm;
    OleDbDataReader dr;
    if(Ids!=null && IsStr(Table))
     {
       if(Ids=="")
        {
          Response.Write(Rv);
          Response.End();
        }
       else
        {
          string[] AIds=Ids.Split(',');
          for(int i=0;i<AIds.Length;i++)
          {
           if(IsNum(AIds[i]))
            {
               sql="select id,title from "+Table+" where id="+int.Parse(AIds[i]);
               comm=new OleDbCommand(sql,conn);
               dr=comm.ExecuteReader();
               while(dr.Read()) 
               {
                if(Rv!="")
                {
                 jg="\"";
                }
                Rv+=jg+dr["id"].ToString()+","+Server.HtmlEncode(dr["title"].ToString());
               }
               dr.Close();
            }
          }
         conn.Close();
         Response.Write(Rv);
         Response.End();
        }
     }
   conn.Close();
 }

private void load_ztlist() //查找专题
 {
    conn.Open();
    OleDbCommand comm;
    OleDbDataReader dr;
    if(Ids!=null && IsStr(Table))
     {
       if(Ids=="")
        {
          Response.Write(Rv);
          Response.End();
        }
       else
        {
          string[] AIds=Ids.Split(',');
          for(int i=0;i<AIds.Length;i++)
          {
           if(IsNum(AIds[i]))
            {
               sql="select id,name from pa_lanmu where id="+int.Parse(AIds[i]);
               comm=new OleDbCommand(sql,conn);
               dr=comm.ExecuteReader();
               while(dr.Read()) 
               {
                if(Rv!="")
                {
                 jg="\"";
                }
                Rv+=jg+dr["id"].ToString()+","+Server.HtmlEncode(dr["name"].ToString());
               }
               dr.Close();
            }
          }
         conn.Close();
         Response.Write(Rv);
         Response.End();
        }
     }
   conn.Close();
 }

private void load_signlist() //load签收用户列表
 {
    OleDbCommand comm;
    OleDbDataReader dr;
    if(Ids!=null && IsStr(Table))
     {
       if(Ids=="")
        {
          Response.Write(Rv);
          Response.End();
        }
       else
        {
          string[] AIds=Ids.Split(',');
          conn.Open();
          for(int i=0;i<AIds.Length;i++)
          {
           if(IsNum(AIds[i]))
            {
               sql="select id,username,department_id,truename from pa_member where id="+int.Parse(AIds[i]);
               comm=new OleDbCommand(sql,conn);
               dr=comm.ExecuteReader();
               while(dr.Read()) 
               {
                if(Rv!="")
                {
                 jg="\"";
                }
                Rv+=jg+dr["id"].ToString()+","+Server.HtmlEncode(Get_Department(dr["department_id"].ToString(),conn))+Server.HtmlEncode(dr["username"].ToString())+"<"+Server.HtmlEncode(dr["truename"].ToString())+">";
               }
               dr.Close();
            }
          }
         conn.Close();
         Response.Write(Rv);
         Response.End();
        }
     }
 }

private void load_pushlist() //查找专题
 {
    conn.Open();
    OleDbCommand comm;
    OleDbDataReader dr;
    if(Ids!=null && IsStr(Table))
     {
       if(Ids=="")
        {
          Response.Write(Rv);
          Response.End();
        }
       else
        {
          string[] AIds=Ids.Split(',');
          for(int i=0;i<AIds.Length;i++)
          {
           if(IsNum(AIds[i]))
            {
               sql="select id,site_id,parent_ids from pa_sort where id="+int.Parse(AIds[i]);
               comm=new OleDbCommand(sql,conn);
               dr=comm.ExecuteReader();
               while(dr.Read()) 
               {
                if(Rv!="")
                {
                 jg="\"";
                }
                Rv+=jg+dr["id"].ToString()+","+Get_SortName(dr["site_id"].ToString(),dr["parent_ids"].ToString()+","+dr["id"].ToString());
               }
               dr.Close();
            }
          }
         conn.Close();
         Response.Write(Rv);
         Response.End();
        }
     }
   conn.Close();
 }

private string Get_SortName(string SiteId,string Parent_Ids)
 {
   string rv="";
   OleDbCommand comm;
   OleDbDataReader dr;
   string sql="select sitename from pa_site where id="+SiteId;
   comm=new OleDbCommand(sql,conn);
   dr=comm.ExecuteReader();
   if(dr.Read())
   {
     rv+="["+dr["sitename"].ToString()+"]";
   }
  dr.Close();

  if(Parent_Ids!="0")
   {
     string[] A=Parent_Ids.Split(',');
     for(int i=0;i<A.Length;i++)
      {
        if(IsNum(A[i]))
         {
           sql="select sort_name from pa_sort where id="+int.Parse(A[i]);
           comm=new OleDbCommand(sql,conn);
           dr=comm.ExecuteReader();
           if(dr.Read())
            {
              rv+=">"+dr["sort_name"].ToString();
            }
           dr.Close();
         }
      }
   }
  return rv;
 }

private string  Get_Department(string departmentid,OleDbConnection conn)
 {
   string rv="";
   string sql="select name from pa_department where id="+int.Parse(departmentid);
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
     {
       rv=dr["name"].ToString()+":";
     }
   dr.Close();
   return rv;
 }  

private string Sql_Format(string str)
 {
   if(string.IsNullOrEmpty(str)){return "";}
   str=str.Replace("'","''");
   str=str.Replace("\"","\""); 
   return str;
 }

protected string Sql_Format(string str,bool isFuzzyQuery)
 {
    if(string.IsNullOrEmpty(str)){return string.Empty;}
    str=Server.UrlDecode(Server.UrlEncode(str).Replace("%00",""));
    str=str.Replace("'","''");
    str=str.Replace("\"","\"");
    return str;
 }


private string GetUrl(string Url)
     {
      if(IsLocal(Url) || Url.IndexOf(".")<0)
       {
         return "localhost";
       }
      else
       {   
         return Url.Replace("www.","");
       }
     }
private bool IsLocal(string str)
 {
   string[] LocalIp=new string[]{@"^127[.]\d{1,3}[.]\d{1,3}[.]\d{1,3}$",@"^localhost$",@"^10[.]\d{1,3}[.]\d{1,3}[.]\d{1,3}$",@"^172[.]((1[6-9])|(2\d)|(3[01]))[.]\d{1,3}[.]\d{1,3}$",@"^192[.]168[.]\d{1,3}[.]\d{1,3}$"};
   for(int i=0;i<LocalIp.Length;i++)
    {
      if(System.Text.RegularExpressions.Regex.IsMatch((str==null?"":str),LocalIp[i]))
       {
         return true;
       }
    }
   return false;
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