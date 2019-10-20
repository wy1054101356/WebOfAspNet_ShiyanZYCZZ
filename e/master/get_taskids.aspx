<% @ Page language="c#"%> 
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 string type,ids,sql;
 OleDbConnection conn;
 protected void Page_Load(Object src,EventArgs e)
  {
    Master_Valicate YZ=new Master_Valicate();
    YZ.Master_Check();
    type=Request.QueryString["type"];
    ids=Request.QueryString["ids"];
    Conn Myconn=new Conn();
    conn=Myconn.OleDbConn();//获取OleDbConnection
    switch(type)
     {
       case "lanmu":
         load_lanmu(0);
       break;

       case "zt":
         load_lanmu(1);
       break;

       case "sublanmu":
         load_sublanmu();
       break;

       case "slide":
         load_slide();
       break;

       case "adv":
         load_adv();
       break;
     }
 }
 

private void load_lanmu(int iszt) //查找栏目
 {
    string Rv="";
    OleDbCommand comm;
    OleDbDataReader dr;
    if(ids!=null && ids!="")
     {
        conn.Open();
        string[] AIds=ids.Split(',');
        for(int i=0;i<AIds.Length;i++)
          {
           if(IsNum(AIds[i]))
            {
               sql="select id,name from pa_lanmu where iszt="+iszt+" and id="+int.Parse(AIds[i]);
               comm=new OleDbCommand(sql,conn);
               dr=comm.ExecuteReader();
               while(dr.Read()) 
               {
                Rv+=dr["id"].ToString()+"{,}"+Server.HtmlEncode(dr["name"].ToString())+"{|}";
               }
               dr.Close();
            }
          }
         conn.Close();
         Response.Write(Rv);
         Response.End();
     }
 }

private void load_sublanmu() //查找子栏目
 {
    string Rv="";
    OleDbCommand comm;
    OleDbDataReader dr;
    if(ids!=null && ids!="")
     {
         conn.Open();
          string[] AIds=ids.Split(',');
          for(int i=0;i<AIds.Length;i++)
          {
           if(IsNum(AIds[i]))
            {
               sql="select id,name,lanmu_id,parent_ids from pa_sublanmu where id="+int.Parse(AIds[i]);
               comm=new OleDbCommand(sql,conn);
               dr=comm.ExecuteReader();
               while(dr.Read()) 
               {
                Rv+=dr["id"].ToString()+"{,}"+Get_Location(int.Parse(dr["lanmu_id"].ToString()),dr["parent_ids"].ToString(),dr["name"].ToString())+"{|}";
               }
               dr.Close();
            }
          }
         conn.Close();
         Response.Write(Rv);
         Response.End();
     }
 }

private string Get_Location(int LanmuId,string Parent_Ids,string Name)
 {
   string Current_Location="";
   OleDbCommand comm;
   OleDbDataReader dr;
   sql="select name,lanmu_dir,lanmu_file,zdy_url,thetype,location_style from pa_lanmu where id="+LanmuId;
   comm=new OleDbCommand(sql,conn);
   dr=comm.ExecuteReader();
   if(dr.Read())
     {
       Current_Location+=dr["name"].ToString();
     }
  dr.Close();
  if(Parent_Ids!="0")
   {
     string[] A=Parent_Ids.Split(',');
     for(int i=0;i<A.Length;i++)
      {
        if(IsNum(A[i]))
         {
           sql="select name,lanmu_id,lanmu_dir,zdy_url,parent_dir,sublanmu_dir,permissions from pa_sublanmu where id="+int.Parse(A[i]);
           comm=new OleDbCommand(sql,conn);
           dr=comm.ExecuteReader();
           if(dr.Read())
            {
              Current_Location+=">"+dr["name"].ToString();
            }
           dr.Close();
         }
      }
   }
  Current_Location+=">"+Name;
  return Current_Location;
 }



private void load_slide()
 {
    string Rv="";
    OleDbCommand comm;
    OleDbDataReader dr;
    if(ids!=null && ids!="")
     {
         conn.Open();
          string[] AIds=ids.Split(',');
          for(int i=0;i<AIds.Length;i++)
          {
           if(IsNum(AIds[i]))
            {
               sql="select id,name from pa_slide where id="+int.Parse(AIds[i]);
               comm=new OleDbCommand(sql,conn);
               dr=comm.ExecuteReader();
               while(dr.Read()) 
               {
                Rv+=dr["id"].ToString()+"{,}"+Server.HtmlEncode(dr["name"].ToString())+"{|}";
               }
               dr.Close();
            }
          }
         conn.Close();
         Response.Write(Rv);
         Response.End();
     }
 }

private void load_adv()
 {
    string Rv="";
    OleDbCommand comm;
    OleDbDataReader dr;
    if(ids!=null && ids!="")
     {
         conn.Open();
          string[] AIds=ids.Split(',');
          for(int i=0;i<AIds.Length;i++)
          {
           if(IsNum(AIds[i]))
            {
               sql="select id,name from pa_adv where id="+int.Parse(AIds[i]);
               comm=new OleDbCommand(sql,conn);
               dr=comm.ExecuteReader();
               while(dr.Read()) 
               {
                Rv+=dr["id"].ToString()+"{,}"+Server.HtmlEncode(dr["name"].ToString())+"{|}";
               }
               dr.Close();
            }
          }
         conn.Close();
         Response.Write(Rv);
         Response.End();
     }
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